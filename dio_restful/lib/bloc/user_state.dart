part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {

}
class GetUserSuccess extends UserState {
  final User user;

  GetUserSuccess({required this.user});
}
