part of 'user_bloc.dart';


abstract class UserState extends Equatable {}

class InitialUserState extends UserState{
  @override
  List<Object> get props => [];
}

// success state
class UserFetched extends UserState {
  final List<UserResponse> user;

  UserFetched(this.user);

  @override
  List<Object> get props => [user];
}
//loading state
class FetchingUsers extends UserState{
  @override
  List<Object> get props => [];

//error state
}class ErrorFetching extends UserState{
  @override
  List<Object> get props => [];
}