import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_application/model/conversation.dart';
import 'package:chat_application/model/user_data.dart';
import 'package:chat_application/repository/firebase_repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  FirebaseRepository firebaseRepository = FirebaseRepository();

  HomeBloc() : super(HomeState()) {
    on<GetUsers>((event, emit) async {
      List<UserData> users = await firebaseRepository.getUserList();
      state.users = users;
      emit(state.clone(HomeStatus.getUsersSuccess));
    });

    on<GetConversation>((event, emit) async {
      Conversation? conversation = await firebaseRepository.getConversation(
          senderUID: event.userId, receiverUID: event.guestId);
      if (conversation != null) {
        state.conversation = conversation;
        emit(state.clone(HomeStatus.getConversationSuccess));
      }
    });
  }
}
