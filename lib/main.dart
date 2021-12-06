import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/bloc/publications_bloc/publication_bloc.dart';
import 'package:prueba_tecnica/bloc/user_bloc/user_bloc.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';
import 'package:prueba_tecnica/ui/home_page.dart';
import 'package:prueba_tecnica/ui/home_screen.dart';

void main() {
  final userRepo = UserRepo();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<PublicationBloc>(create: (context){
        return PublicationBloc(userRepo)..add(FetchPublication());
      }),
      BlocProvider<UserBloc>(create: (context){
        return UserBloc(userRepo)..add(FetchUser());
      }),
    ],
        child: MyApp())

  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen()
    );
  }
}
