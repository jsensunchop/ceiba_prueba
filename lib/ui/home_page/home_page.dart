import 'dart:async';

import 'package:flutter/material.dart';

import 'package:prueba_tecnica/data/provider/db_provider.dart';
import 'package:prueba_tecnica/domain/entities/user_response.dart';
import 'package:prueba_tecnica/ui/style/theme.dart' as Style;
import 'package:prueba_tecnica/ui/details_page/details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  Timer? debouncer;
  ///INICIALIZAR LA BASE DE DATOS
  final dbHelper = DBProvider.db;
  String keyword = '';
  int userId = 0;
  late String userName;
  late String userEmail;
  late String userPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prueba de ingreso"),
        backgroundColor: Style.Colors.mainColor,
      ),

      ///LLAMANDO LA DATA DE LA DB
      body: FutureBuilder<List<UserResponse>>(
        ///FILTRO DE USUARIOS POR PALABRA
        future: dbHelper.searchUsers(keyword),

          builder: (BuildContext context, AsyncSnapshot<List<UserResponse>> snapshot) {


          if(snapshot.data == null){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return Column(
              children: [

                ///CREACION DEL WIDGET DE FILTRO DE USUARIOS
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                        border: OutlineInputBorder(
                        ),
                        labelText: 'Buscar usuario',),
                    onChanged: (value) {
                      keyword = value;
                      setState(() {

                      });
                    },
                  ),
                ),
                ///CREACION DE LA LISTA DE USUARIOS DEL API
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
                          ///WIDGET DE TARJETA
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              ///ORGANIZACION DE LA INFORMACION DE LA TARJETA
                              child: ListTile(
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      ///NOMBRE DE USUARIO
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
                                      ///TELEFONO DE USUARIO
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
                                            style: const TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      ///EMAIL DE USUARIO
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
                                            style: const TextStyle(fontSize: 14.0),
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

                                      ///MANEJO DE EVENTOS A LA SIGUIENTE PANTALLA DE PUBLICACIONES DE USUARIO
                                      InkWell(
                                        onTap: (){
                                          userId = snapshot.data![index].id;
                                          userName = snapshot.data![index].name;
                                          userEmail = snapshot.data![index].email;
                                          userPhone = snapshot.data![index].phone;

                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                              DetailsScreen(
                                                userId: userId,
                                                userEmail: userEmail,
                                                userName: userName,
                                                userPhone: userPhone,
                                              ))
                                          );
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

}


