import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:exam_ui/models/post.dart';
import 'package:exam_ui/models/post_dto.dart';
import 'package:exam_ui/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'add_post_event.dart';

part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {

  PostRepository postRepository = PostRepository.getInstance();

  AddPostBloc() : super(AddPostInitial()) {
    on<PickImage>((event, emit) {
      emit(PickImageSuccess(event.file));
    });

    on<RemoveImage>((event, emit) {
      emit(RemoveImageSuccess());
    });

    on<UploadPost>((event, emit) async {
      PostDto postDto = PostDto(userId: event.userId, caption: event.caption);
      if (event.file != null) {
        List<int> bytes = List.from(await event.file!.readAsBytes());
        postDto.bytes = base64Encode(bytes);
        postDto.name =
            event.file!.path.substring(event.file!.path.lastIndexOf("/") + 1);
      }
      Post? post = await postRepository.uploadPost(postDto: postDto);
      if (post != null) {
        emit(UploadPostSuccess(post: post));
      }
    });
  }
}
