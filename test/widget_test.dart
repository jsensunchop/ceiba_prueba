// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:prueba_tecnica/data/repositories/user_repo.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:prueba_tecnica/domain/bloc/user_bloc/user_bloc.dart';
// import 'package:prueba_tecnica/domain/entities/user_response.dart';
//
// import 'package:prueba_tecnica/main.dart';
//
// class MockUserRepo extends Mock implements UserRepo {}
//
// void main() {
//   late MockUserRepo mockUserRepo;
//
//   setUp(() {
//     mockUserRepo = MockUserRepo();
//   });
//
//
//   group('FetchUser', () {
//     final weather = [UserResponse(1,"Leanne Graham","Bret","Sincere@april.biz", "1-770-736-8031 x56442"),
//       UserResponse(2,"Leanne Graham","Bret","Sincere@april.biz", "1-770-736-8031 x56442")];
//
//     test('OLD WAY emits [WeatherLoading, WeatherLoaded] when successful', () {
//       when(mockUserRepo.fetchUsers())
//           .thenAnswer((_) async => Future.value(weather));
//
//       final bloc = UserBloc(mockUserRepo);
//
//       bloc.add(FetchUser());
//
//       expectLater(
//         bloc,
//         emitsInOrder([
//           InitialUserState(),
//           FetchingUsers(),
//           UserFetched(weather),
//         ]),
//       );
//     });
//
//
//     // test(
//     //   'NEWER WAY BUT LONG-WINDED emits [WeatherLoading, WeatherLoaded] when successful',
//     //   () {
//     //     when(mockUserRepo.fetchUsers()).thenAnswer((_) async => weather);
//     //     final bloc = UserBloc(mockUserRepo);
//     //     bloc.add(FetchUser());
//     //
//     //     emitsExactly(bloc, [
//     //       InitialUserState(),
//     //       FetchingUsers(),
//     //       UserFetched(weather),
//     //     ]);
//     //   },
//     // );
//
//
//   });
//
//
// }
