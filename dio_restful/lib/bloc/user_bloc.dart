
import 'package:bloc/bloc.dart';
import 'package:dio_restful/models/user.dart';
import 'package:dio_restful/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserInitialEvent>((event, emit) async {
      UserRepository userRepository = UserRepository.getInstance();
      String? token = await userRepository.login();
      print(token);
      User? user = await userRepository.getUserLogin();
      print(user?.toJson());
      if (user != null) {
        emit(GetUserSuccess(user: user));
      }
    });
  }
}
