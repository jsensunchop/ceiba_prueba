import 'dart:async';

import 'package:flutter/material.dart';

import 'package:prueba_tecnica/data/provider/db_dao.dart';
import 'package:prueba_tecnica/data/provider/db_provider.dart';
import 'package:prueba_tecnica/domain/entities/user_response.dart';
import 'package:prueba_tecnica/style/theme.dart' as Style;
import 'package:prueba_tecnica/ui/details_page.dart';
import 'package:prueba_tecnica/ui/widget/search_widget.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  Timer? debouncer;
  final dbHelper = DBProvider.db;
  final dbGetter = DBDao();
  String keyword = '';
  int userId = 0;
  List<UserResponse> users = [];
  List<UserResponse> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    // dbHelper.initDB();
    // dbGetter = DBDao()

    init();



  }

  Future init() async {
    dbHelper.getAllUsers().then((query) {
      setState(() {
        users = users;

      });
    });
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prueba de ingreso"),
        backgroundColor: Style.Colors.mainColor,
      ),
      // body: Column(
      //   children: [
      //     const Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 20.0),
      //       child: TextField(
      //         // onChanged: (value) => _runFilter(value),
      //         decoration: InputDecoration(
      //             labelText: 'Search', suffixIcon: Icon(Icons.search)),
      //       ),
      //     ),
      //     Container(
      //         padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
      //         height: MediaQuery.of(context).size.height*0.796,
      //         width: double.maxFinite,
      //         child: BlocBuilder<UserBloc, UserState>(
      //             builder: (context, state){
      //               if(state is UserFetched){
      //                 return ListView.separated(
      //                     separatorBuilder: (BuildContext context, int index) {
      //                       return const SizedBox(
      //                         height: 20,
      //                       );
      //                     },
      //                     scrollDirection: Axis.vertical,
      //                     shrinkWrap: true,
      //                     itemCount: state.user.length,
      //                     itemBuilder: (context, index) {
      //                       return Container(
      //                         height: MediaQuery.of(context).size.height*0.19,
      //                         child: Card(
      //                           elevation: 1,
      //                           child: Padding(
      //                             padding: EdgeInsets.all(7),
      //                             child: ListTile(
      //                                 title: Column(
      //                                   mainAxisAlignment: MainAxisAlignment.start,
      //                                   crossAxisAlignment: CrossAxisAlignment.start,
      //                                   children: [
      //
      //                                     const SizedBox(height: 7,),
      //                                     Text(state.user[index].name, style: TextStyle(fontSize: 14.0, color: Style.Colors.mainColor, fontWeight: FontWeight.bold),),
      //                                     const SizedBox(height: 7,),
      //                                     Row(
      //                                       children: <Widget> [
      //                                         Icon(Icons.phone, size: 15, color: Style.Colors.mainColor),
      //                                         SizedBox(width: 10,),
      //                                         Text(state.user[index].phone, style: TextStyle(fontSize: 14.0),),
      //                                       ],
      //                                     ),
      //                                     const SizedBox(height: 7,),
      //                                     Row(
      //                                       children: <Widget> [
      //                                         Icon(Icons.mail, size: 15, color: Style.Colors.mainColor),
      //                                         SizedBox(width: 10,),
      //                                         Text(state.user[index].email, style: TextStyle( fontSize: 14.0),),
      //                                       ],
      //                                     ),
      //                                   ],
      //                                 ),
      //                                 trailing: Column(
      //                                   children: <Widget> [
      //                                     const SizedBox(height: 40,),
      //                                     InkWell(
      //                                       // onTap: (){
      //                                       //   userId = state.user[index].id;
      //                                       //
      //                                       //   Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsPage(userId: userId)));
      //                                       // },
      //                                         child: const Text(
      //                                           "VER PUBLICACIONES",
      //                                           style: TextStyle(
      //                                               fontSize: 12.0,
      //                                               color: Style.Colors.mainColor,
      //                                               fontWeight: FontWeight.bold),
      //                                         )
      //                                     ),
      //                                   ],
      //                                 )
      //                             ),
      //                           ),
      //                         ),
      //                       );
      //                     }
      //                 );
      //               }  else {
      //                 return const Center(
      //                   child: CircularProgressIndicator(),
      //                 );
      //               }
      //             })
      //
      //
      //       ),
      //   ],
      // )

      body: FutureBuilder<List<UserResponse>>(
        future: dbHelper.searchUsers(keyword),
          builder: (BuildContext context, AsyncSnapshot<List<UserResponse>> snapshot) {

          if(snapshot.data == null){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'keyword'),
                    onChanged: (value) {
                      keyword = value;
                      setState(() {

                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.19,
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: ListTile(
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        snapshot.data![index].name,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Style.Colors.mainColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Icon(Icons.phone,
                                              size: 15,
                                              color: Style.Colors.mainColor),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            snapshot.data![index].phone,
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Icon(Icons.mail,
                                              size: 15,
                                              color: Style.Colors.mainColor),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            snapshot.data![index].email,
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    children:  <Widget>[
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      InkWell(
                                        onTap: (){
                                          // userId = snapshot.data![index].id;

                                          // Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsPage(userId: userId)));
                                        },
                                          child: const Text(
                                            "VER PUBLICACIONES",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Style.Colors.mainColor,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }

          }
      )

    );
  }
  // Widget buildSearch() => SearchWidget(
  //   text: query,
  //   hintText: 'Title or Author Name',
  //   onChanged: searchUser,
  // );
  //
  // Future searchUser(String query) async => debounce(() async {
  //
  //   dbHelper.getAllUsers().then((query) {
  //     setState(() {
  //       users = users;
  //
  //     });
  //   });
  //
  // });

}

