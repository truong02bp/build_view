import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_post_event.dart';
part 'detail_post_state.dart';

class DetailPostBloc extends Bloc<DetailPostEvent, DetailPostState> {
  DetailPostBloc() : super(DetailPostInitial()) {
    on<DetailPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
