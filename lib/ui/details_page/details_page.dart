import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prueba_tecnica/data/provider/db_provider.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';
import 'package:prueba_tecnica/ui/style/theme.dart' as Style;

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.userEmail,
      required this.userPhone})
      : super(key: key);

  final int userId;
  final String userName;
  final String userEmail;
  final String userPhone;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final dbHelper = DBProvider.db;

  String keyword = '';

  Timer? debouncer;

  @override
  void initState() {
    super.initState();
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
        ///LLAMAR DATOS DE LA DB
        body: FutureBuilder<List<PostResponse>>(
            ///FUNCIONALIDAD DE BUSCAR POST POR ID DE USUARIO DESDE LA DB
            future: dbHelper.searchPosts(widget.userId),
            builder: (BuildContext context,
                AsyncSnapshot<List<PostResponse>> snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Card(
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
                              ///NOMBRE DE USUARIO SELECCIONADO
                              Text(
                                widget.userName,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Style.Colors.mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              ///TELEFONO DE USUARIO SELECCIONADO
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.phone,
                                      size: 15, color: Style.Colors.mainColor),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.userPhone,
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              ///EMAIL DE USUARIO SELECCIONADO
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.mail,
                                      size: 15, color: Style.Colors.mainColor),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.userEmail,
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ///MOSTRAR LISTA DE PUBLICACIONES PERTENECIENTES AL USUARIO
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
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ListTile(
                                    leading: Text(
                                      snapshot.data![index].userId.toString(),
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Style.Colors.mainColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    title: Text(
                                      snapshot.data![index].title,
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Style.Colors.mainColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index].body,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
            }));
  }
}
