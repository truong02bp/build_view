part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginWidthEmailPassword extends LoginEvent {
  final String email;
  final String password;

  LoginWidthEmailPassword({required this.email, required this.password});
}

class ObscurePasswordEvent extends LoginEvent {

}

class LoginGoogleEvent extends LoginEvent {

}
