part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetUsers extends HomeEvent {

}

class GetConversation extends HomeEvent {
  final String userId;
  final String guestId;

  GetConversation({required this.userId, required this.guestId});
}
