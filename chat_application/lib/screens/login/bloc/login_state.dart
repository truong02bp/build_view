part of 'login_bloc.dart';

enum LoginStatus {initial, obscureTextSuccess, loginSuccess}

class LoginState {
  String email = '';
  String password = '';
  bool obscureText = true;
  LoginStatus status = LoginStatus.initial;
  User? user;

  LoginState clone(LoginStatus status) {
    LoginState state = LoginState();
    state.email = this.email;
    state.password = this.password;
    state.obscureText = this.obscureText;
    state.status = status;
    state.user = this.user;
    return state;
  }
}

