import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/domain/bloc/publications_bloc/publication_bloc.dart';
import 'package:prueba_tecnica/domain/bloc/user_bloc/user_bloc.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';
import 'package:prueba_tecnica/ui/home_page/home_screen.dart';
import 'package:prueba_tecnica/ui/style/theme.dart' as Style;

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
        child: const MyApp())

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Style.Colors.mainColor,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Style.Colors.mainColor,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      ),
      home: const HomeScreen()
    );
  }
}

