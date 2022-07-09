part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}


class PostInitialEvent extends PostEvent {
  final User user;

  PostInitialEvent({required this.user});
}

class GetPostEvent extends PostEvent {
  int userId;
  int page;
  int limit;

  GetPostEvent({required this.userId, required this.page, required this.limit});
}

class DeletePostEvent extends PostEvent {
  int postId;

  DeletePostEvent({required this.postId});
}