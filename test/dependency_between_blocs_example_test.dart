// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:prueba_tecnica/domain/bloc/user_bloc/user_bloc.dart';
//
// class MockUserBloc extends MockBloc<UserEvent, UserState>
//     implements UserBloc {}
//
// void main() {
//   late MockUserBloc mockUserBloc = MockUserBloc();
//
//   setUp(() {
//     mockUserBloc = MockUserBloc();
//   });
//
//   test('Example mocked BLoC test', () {
//     whenListen(
//       mockUserBloc,
//       Stream.fromIterable([InitialUserState(), FetchingUsers()]),
//     );
//
//     expectLater(
//       mockUserBloc,
//       emitsInOrder([InitialUserState(), FetchingUsers()]),
//     );
//   });
// }