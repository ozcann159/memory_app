import 'package:bloc/bloc.dart';
import 'package:memory_app/bloc/memory_event.dart';
import 'package:memory_app/bloc/memory_state.dart';
import 'package:memory_app/models/memory_model.dart';
import 'package:memory_app/repo/memory_repository.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  final MemoryRepository repository;

  MemoryBloc(this.repository) : super(MemoryInitial()) {
    on<SubmitMemory>(_onSubmitMemory);
    on<LoadMemories>(_onLoadMemories);
  }

  void _onSubmitMemory(SubmitMemory event, Emitter<MemoryState> emit) async {
    emit(MemorySubmitting());
    try {
      final memory = Memory(
        name: event.name,
        surname: event.surname,
        state: event.state,
        city: event.city,
        memory: event.memory,
        imageUrl: event.imageUrl,
        mosque: event.mosque,
        date: DateTime.now(),
        
      );
      await repository.addMemory(memory);
      emit(MemorySubmitted());
    } catch (e) {
      emit(MemorySubmitError(e.toString()));
    }
  }

  void _onLoadMemories(LoadMemories event, Emitter<MemoryState> emit) async {
    try {
      final memories = await repository.getMemoriesOrderedByDate().first;
      emit(MemoriesLoaded(memories));
    } catch (e) {
      emit(MemoryLoadError(e.toString()));
    }
  }
}
