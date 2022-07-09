import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {
  EditPostBloc() : super(EditPostInitial()) {
    on<EditPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
