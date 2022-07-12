part of 'post_bloc.dart';

enum PostStatus {normal, initial, getPostSuccess, deletePostSuccess, updatePostSuccess }

class PostState {
  List<Post> posts = [];
  User? user;
  int page = 0;
  int limit = 20;
  PostStatus status = PostStatus.initial;

  PostState({
    this.user
  });

  PostState clone({required PostStatus postStatus}) {
    PostState postState = PostState();
    postState.status = postStatus;
    postState.page = this.page;
    postState.posts = this.posts;
    postState.user = this.user;
    postState.limit = this.limit;
    return postState;
  }

}
