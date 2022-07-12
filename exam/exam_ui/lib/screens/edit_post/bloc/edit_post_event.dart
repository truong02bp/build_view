part of 'edit_post_bloc.dart';

@immutable
abstract class EditPostEvent {}

class EditPostInitialEvent extends EditPostEvent {
  final Post post;

  EditPostInitialEvent({required this.post});
}

class UpdatePost extends EditPostEvent {

}

class UpdateCaption extends EditPostEvent {
  String value;

  UpdateCaption(this.value);
}

class PickImage extends EditPostEvent {
  final File file;

  PickImage(this.file);
}

class RemoveImage extends EditPostEvent {

}
