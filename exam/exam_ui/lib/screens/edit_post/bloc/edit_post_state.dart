part of 'edit_post_bloc.dart';

@immutable
abstract class EditPostState {}

class EditPostInitial extends EditPostState {}

class PickImageSuccess extends EditPostState {
  final File file;

  PickImageSuccess(this.file);
}

class RemoveImageSuccess extends EditPostState {

}

class UpdatePostSuccess extends EditPostState {
  final Post post;

  UpdatePostSuccess({required this.post});
}