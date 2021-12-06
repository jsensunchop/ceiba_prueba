import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/bloc/publications_bloc/publication_bloc.dart';
import 'package:prueba_tecnica/bloc/user_bloc/user_bloc.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';
import 'package:prueba_tecnica/style/theme.dart' as Style;

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.userId}) : super(key: key);

  // Declare a field that holds the Todo.
  final int userId;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _userRepo = UserRepo();

  late Status _keysStatus;

  late List<PostResponse> _key;

  void initState() {
    _keysStatus = Status.STARTING;
    super.initState();
  }

  ///Getting the cities by department id
  void _getPublications(int id) async {
    try {
      _keysStatus = Status.LOADING;
      _key = await _userRepo.fetchPostsById(id);
      /// if successful then update state => runs build again
      setState(() {
        _keysStatus = Status.SUCCESS;
      });
    } catch (error) {
      _keysStatus = Status.FAILURE;
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text("Prueba de ingreso"),
          backgroundColor: Style.Colors.mainColor,
        ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                height: MediaQuery.of(context).size.height * 0.18,
                width: double.maxFinite,
                child:
                    BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  if (state is UserFetched) {
                    _getPublications(widget.userId);
                    print(_keysStatus);
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: Card(
                        elevation: 1,
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.userId.toString(),
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Style.Colors.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.phone,
                                        size: 15,
                                        color: Style.Colors.mainColor),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "state.user[index].phone",
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.mail,
                                        size: 15,
                                        color: Style.Colors.mainColor),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "state.user[index].email",
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),

            if (_keysStatus == Status.LOADING)
              Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(
                        color: Style.Colors.mainColor),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.066),
                ],
              ),

            if(_keysStatus == Status.SUCCESS)
            Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.maxFinite,
                child:


                    ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _key.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: ListTile(
                                  leading: Text(
                                    _key[index].id.toString(),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Style.Colors.mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                    title:Text(
                                      _key[index].title,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Style.Colors.mainColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  subtitle: Text(
                                    _key[index].body,
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),


            ),
          ],
        ));
  }
}

///this enum helps me control the cities dropdown menu state
enum Status { LOADING, SUCCESS, FAILURE, STARTING }
