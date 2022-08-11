part of 'home_bloc.dart';

enum HomeStatus { initial, getUsersSuccess, getConversationSuccess }

class HomeState {
  List<UserData> users = [];
  HomeStatus status = HomeStatus.initial;
  Conversation? conversation;

  HomeState clone(HomeStatus status) {
    HomeState state = HomeState();
    state.status = status;
    state.users = this.users;
    state.conversation = this.conversation;
    return state;
  }
}
