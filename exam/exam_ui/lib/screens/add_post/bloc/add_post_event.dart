part of 'add_post_bloc.dart';
@immutable
abstract class AddPostEvent {}

class PickImage extends AddPostEvent {
  final File file;

  PickImage(this.file);
}

class RemoveImage extends AddPostEvent {

}

class UploadPost extends AddPostEvent {
  final File? file;
  final String caption;
  final int userId;

  UploadPost({required this.file,required this.userId, required this.caption});
}