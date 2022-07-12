part of 'edit_post_bloc.dart';

enum EditPostStatus { initial, pickImageSuccess, removeImageSuccess, updatePostSuccess}

class EditPostState {
  File? file;
  EditPostStatus status = EditPostStatus.initial;
  Post? post;
  int? mediaId;


  EditPostState clone({required EditPostStatus status}) {
    final state = EditPostState();
    state.post = this.post;
    state.file = this.file;
    state.status = status;
    state.mediaId = this.mediaId;
    return state;
  }
}
