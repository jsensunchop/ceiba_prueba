import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/data/provider/db_dao.dart';
import 'package:prueba_tecnica/data/provider/db_provider.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';
import 'package:prueba_tecnica/domain/entities/user_response.dart';



part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.userRepo) : super(InitialUserState());

  final UserRepo userRepo ;


  @override
  void onTransition(Transition<UserEvent, UserState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUser) {
      yield FetchingUsers();
      try {
        final data = await userRepo.fetchUsers();
        print("...");
        DBProvider.db.database;
        DBProvider.db.deleteAllUsers();
        for (var age in data) {
          DBProvider.db.createUser(age);
        }
        final data_db = await DBProvider.db.getAllUsers();
        print("...");
        yield UserFetched(data_db);
      } catch (error) {
        final data = await userRepo.fetchUsers();
        print(data);
        yield Fetching();
        print("error = ${error}");
      }
    }
  }

  UserState get initialState => InitialUserState();
}
