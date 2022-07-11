part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetUserSuccess extends UserState {
  final List<User> users;

  GetUserSuccess({required this.users});
}
