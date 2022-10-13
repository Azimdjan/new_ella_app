import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'guid_event.dart';
part 'guid_state.dart';

class GuidBloc extends Bloc<GuidEvent, GuidState> {
  GuidBloc() : super(GuidInitial()) {
    on<GuidEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
