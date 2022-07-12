part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}


class PostInitialEvent extends PostEvent {
  final User user;

  PostInitialEvent({required this.user});
}

class GetPostEvent extends PostEvent {

}

class RebuildUpdatePost extends PostEvent {
  final Post post;

  RebuildUpdatePost({required this.post});
}


class DeletePostEvent extends PostEvent {
  int postId;

  DeletePostEvent({required this.postId});
}