part of 'edit_post_bloc.dart';

@immutable
abstract class EditPostEvent {}

class UpdatePost extends EditPostEvent {
  final File? file;
  final String? caption;
  final int postId;
  final int? mediaId;

  UpdatePost({required this.file, required this.caption, required this.postId, this.mediaId});
}

class PickImage extends EditPostEvent {
  final File file;

  PickImage(this.file);
}

class RemoveImage extends EditPostEvent {

}
