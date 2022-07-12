part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}


class PostInitialEvent extends PostEvent {
  final User user;

  PostInitialEvent({required this.user});
}

class GetPostEvent extends PostEvent {

}

class CreatePostEvent extends PostEvent {
  final Post post;

  CreatePostEvent({required this.post});
}

class RebuildUpdatePostEvent extends PostEvent {
  final Post post;

  RebuildUpdatePostEvent({required this.post});
}


class DeletePostEvent extends PostEvent {
  int postId;

  DeletePostEvent({required this.postId});
}