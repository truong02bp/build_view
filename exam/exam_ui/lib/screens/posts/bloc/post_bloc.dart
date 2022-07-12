import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:exam_ui/models/post.dart';
import 'package:exam_ui/models/user.dart';
import 'package:exam_ui/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository.getInstance();

  PostBloc() : super(PostState()) {
    _onInitialEvent();
    _onGetPostEvent();
    _onDeletePostEvent();
    _onRebuildPostUpdateEvent();
    _onCreatePostEvent();
  }

  _onInitialEvent(){
    on<PostInitialEvent>((event, emit) {
      state.posts.clear();
      state.page = 0;
      state.limit = 20;
      state.user = event.user;
      add(GetPostEvent());
    });
  }

  _onGetPostEvent(){
    on<GetPostEvent>((event, emit) async {
      List<Post>? posts = await postRepository.getPostByUserId(
          userId: state.user!.id, page: state.page, limit: state.limit);
      state.page++;
      if (posts != null) {
        state.posts.addAll(posts);
        emit(state.clone(postStatus: PostStatus.getPostSuccess));
      }
    });

  }

  _onDeletePostEvent() {
    on<DeletePostEvent>((event, emit) async {
      String? message = await postRepository.deleteById(id: event.postId);
      if (message != null) {
        state.posts.removeWhere((element) => element.id == event.postId);
        emit(state.clone(postStatus: PostStatus.deletePostSuccess));
      }
    });
  }

  _onRebuildPostUpdateEvent() {
    on<RebuildUpdatePostEvent>((event, emit) {
      for (int i=0;i<state.posts.length;i++) {
        if (state.posts[i].id == event.post.id) {
          state.posts[i] = event.post;
          break;
        }
      }
      emit(state.clone(postStatus: PostStatus.updatePostSuccess));
    });
  }

  _onCreatePostEvent() {
    on<CreatePostEvent>((event, emit) {
      state.posts.insert(0, event.post);
      emit(state.clone(postStatus: PostStatus.updatePostSuccess));
    });
  }
}
