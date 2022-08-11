import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_application/repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository = LoginRepository();

  LoginBloc() : super(LoginState()) {
    on<LoginGoogleEvent>((event, emit) async {
      User? user = await loginRepository.signInWithGoogle();
      if (user != null) {
        state.user = user;
        emit(state.clone(LoginStatus.loginSuccess));
      }
    });

    on<ObscurePasswordEvent>((event, emit) {
      state.obscureText = !state.obscureText;
      emit(state.clone(LoginStatus.obscureTextSuccess));
    });

    on<LoginWidthEmailPassword>((event, emit) async {
      print(event.email);
      print(event.password);
      User? user = await loginRepository.signInWithEmailPassword(
          email: event.email, password: event.password);
      state.user = user;
      emit(state.clone(LoginStatus.loginSuccess));
    });
  }
}
