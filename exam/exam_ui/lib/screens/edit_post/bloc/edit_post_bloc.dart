import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:exam_ui/models/post.dart';
import 'package:exam_ui/models/post_dto.dart';
import 'package:exam_ui/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'edit_post_event.dart';

part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {

  PostRepository postRepository = PostRepository.getInstance();


  EditPostBloc() : super(EditPostInitial()) {
    on<PickImage>((event, emit) {
      emit(PickImageSuccess(event.file));
    });

    on<RemoveImage>((event, emit) {
      emit(RemoveImageSuccess());
    });

    on<UpdatePost>((event, emit) async {
      PostDto postDto = PostDto();
      postDto.postId = event.postId;
      if (event.caption != null) {
        postDto.caption = event.caption;
      }
      if (event.file != null) {
        List<int> bytes = List.from(await event.file!.readAsBytes());
        postDto.bytes = base64Encode(bytes);
        postDto.name =
            event.file!.path.substring(event.file!.path.lastIndexOf("/") + 1);
      }
      if (event.mediaId != null) {
        postDto.mediaId = event.mediaId;
      }
      Post? post = await postRepository.updatePost(postDto: postDto);
      if (post != null) {
        emit(UpdatePostSuccess(post: post));
      }
    });
  }
}
