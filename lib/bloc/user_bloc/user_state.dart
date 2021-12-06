part of 'user_bloc.dart';


abstract class UserState extends Equatable {}

class InitialUserState extends UserState{
  @override
  List<Object> get props => [];
}

class UserFetched extends UserState {
  final List<UserResponse> user;

  UserFetched(this.user);

  @override
  List<Object> get props => [user];
}

class FetchingUsers extends UserState{
  @override
  List<Object> get props => [];


}class Fetching extends UserState{
  @override
  List<Object> get props => [];
}