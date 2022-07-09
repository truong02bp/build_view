import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:exam_ui/models/post.dart';
import 'package:exam_ui/models/user.dart';
import 'package:exam_ui/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository.getInstance();

  PostBloc() : super(PostInitial()) {
    on<PostInitialEvent>((event, emit) {
      add(GetPostEvent(userId: event.user.id, page: 0, limit: 20));
    });

    on<GetPostEvent>((event, emit) async {
      List<Post>? posts = await postRepository.getPostByUserId(
          userId: event.userId, page: event.page, limit: event.limit);
      if (posts != null) {
        emit(GetPostSuccess(posts: posts));
      }
    });

    on<DeletePostEvent>((event, emit) async {
      String? message = await postRepository.deleteById(id: event.postId);
      if (message != null) {
        emit(DeletePostSuccess(postId: event.postId));
      }
    });
  }
}
