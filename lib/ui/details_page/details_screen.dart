import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/bloc/publications_bloc/publication_bloc.dart';
import 'package:prueba_tecnica/bloc/user_bloc/user_bloc.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';

import 'details_page.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, required this.userId, required this.userName, required this.userEmail, required this.userPhone}) : super(key: key);
  final int userId;
  final String userName;
  final String userEmail;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<PublicationBloc, PublicationState>(builder: (context, state) {
          if (state is PublicationsFetched) {
            return DetailsPage(
                userId: userId,
                userName: userName,
                userEmail: userEmail,
                userPhone: userPhone
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}