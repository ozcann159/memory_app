import 'package:bloc/bloc.dart';
import 'package:memory_app/bloc/memory_list_page/memory_list_page_event.dart';
import 'package:memory_app/bloc/memory_list_page/memory_list_page_state.dart';
import 'package:memory_app/repo/memory_repository.dart';

class MemoryListBloc extends Bloc<MemoryListEvent, MemoryListState> {
  final MemoryRepository memoryRepository;

  MemoryListBloc({required this.memoryRepository}) : super(MemoryListInitial());

  @override
  Stream<MemoryListState> mapEventToState(
    MemoryListEvent event,
  ) async* {
    if (event is LoadMemories) {
      yield MemoryListLoading();
      try {
        final memories = await memoryRepository.getMemories().first;
        yield MemoryListLoaded(memories);
      } catch (e) {
        yield MemoryListError(e.toString());
      }
    }
  }
}
