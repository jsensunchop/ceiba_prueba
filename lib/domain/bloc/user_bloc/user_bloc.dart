import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    super.onTransition(transition);
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUser) {
      yield FetchingUsers();
      try {
        //consuming api
        final data = await userRepo.fetchUsers();
        // DBProvider.db.database;
        //delete previous saved User Database Table
        DBProvider.db.deleteAllUsers();
        //fill User table with api data
        for (var age in data) {
          DBProvider.db.createUser(age);
        }
        //get the User table
        final dataDb = await DBProvider.db.getAllUsers();

        //database successfully fetched
        yield UserFetched(dataDb);
      } catch (error) {
        yield ErrorFetching();
      }
    }
  }

  UserState get initialState => InitialUserState();
}
