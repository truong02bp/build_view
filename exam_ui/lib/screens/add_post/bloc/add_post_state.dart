part of 'add_post_bloc.dart';

@immutable
abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class PickImageSuccess extends AddPostState {
  final File file;

  PickImageSuccess(this.file);
}

class RemoveImageSuccess extends AddPostState {

}

class UploadPostSuccess extends AddPostState {
  final Post post;

  UploadPostSuccess({required this.post});
}
