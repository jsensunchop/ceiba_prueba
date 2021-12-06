import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/bloc/user_bloc/user_bloc.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';

import 'home_page.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserFetched) {
            return HomePage();
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
        }));
  }
}
