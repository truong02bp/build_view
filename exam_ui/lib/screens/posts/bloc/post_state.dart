part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class GetPostSuccess extends PostState {
  final List<Post> posts;

  GetPostSuccess({required this.posts});
}

class DeletePostSuccess extends PostState {
  int postId;

  DeletePostSuccess({required this.postId});
}
