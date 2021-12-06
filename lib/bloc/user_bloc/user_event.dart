part of 'user_bloc.dart';


abstract class UserEvent extends Equatable {}

class FetchUser extends UserEvent{
  @override
  List<Object> get props => [];
}