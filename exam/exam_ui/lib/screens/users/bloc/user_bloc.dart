import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:exam_ui/models/user.dart';
import 'package:exam_ui/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository = UserRepository.getInstance();

  UserBloc() : super(UserInitial()) {
    _onInitialEvent();
  }

  _onInitialEvent() {
    on<UserInitialEvent>((event, emit) async {
      List<User>? users = await userRepository.getUsers();
      if (users != null) {
        emit(GetUserSuccess(users: users));
      }
    });
  }
}
