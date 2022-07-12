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


  EditPostBloc() : super(EditPostState()) {

    on<EditPostInitialEvent>((event, emit) {
      state.post = event.post;
    });

    on<PickImage>((event, emit) {
      state.file = event.file;
      emit(state.clone(status: EditPostStatus.pickImageSuccess));
    });

    on<RemoveImage>((event, emit) {
      if (state.file != null) {
        state.file = null;
      }
      else {
        state.mediaId = state.post!.media!.id;
      }
      emit(state.clone(status: EditPostStatus.removeImageSuccess));
    });

    on<UpdateCaption>((event, emit) {
      if (state.post != null) {
        state.post!.caption = event.value;
      }
    });
    _onUpdatePostEvent();
  }

  _onUpdatePostEvent() {
    on<UpdatePost>((event, emit) async {
      PostDto postDto = PostDto();
      postDto.postId = state.post!.id;
      postDto.caption = state.post!.caption;
      print(state.mediaId);
      postDto.mediaId = state.mediaId;
      final file = state.file;
      File? uploadFile;
      if (file != null) {
        uploadFile = File(file.path);
      }
      if (uploadFile != null) {
        List<int> bytes = List.from(await uploadFile.readAsBytes());
        postDto.bytes = base64Encode(bytes);
        postDto.name =
            uploadFile.path.substring(uploadFile.path.lastIndexOf("/") + 1);
      }
      Post? post = await postRepository.updatePost(postDto: postDto);
      if (post != null) {
        state.post = post;
        emit(state.clone(status: EditPostStatus.updatePostSuccess));
      }
    });
  }
}
