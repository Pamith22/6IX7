import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repos/promt_repo.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptEnteredEvent>(_handlePromptEnteredEvent);
  }

  Future<void> _handlePromptEnteredEvent(
      PromptEnteredEvent event,
      Emitter<PromptState> emit,
      ) async {
    emit(PromptGeneratingImageLoadState());
    try {
      final bytes = await PromptRepo.generateImage(event.prompt);
      if (bytes != null) {
        emit(PromptGeneratingImageSuccessState(bytes));
      } else {
        emit(PromptGeneratingImageErrorState());
      }
    } catch (e) {
      emit(PromptGeneratingImageErrorState());
    }
  }
}