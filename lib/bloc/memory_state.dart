import 'package:equatable/equatable.dart';
import 'package:memory_app/models/memory_model.dart';


abstract class MemoryState extends Equatable {
  const MemoryState();

  @override
  List<Object> get props => [];
}

class MemoryInitial extends MemoryState {}

class MemorySubmitting extends MemoryState {}

class MemorySubmitted extends MemoryState {}

class MemorySubmitError extends MemoryState {
  final String error;

  const MemorySubmitError(this.error);

  @override
  List<Object> get props => [error];
}

class MemoriesLoaded extends MemoryState {
  final List<Memory> memories;

  const MemoriesLoaded(this.memories);

  @override
  List<Object> get props => [memories];
}

class MemoryLoadError extends MemoryState {
  final String error;

  const MemoryLoadError(this.error);

  @override
  List<Object> get props => [error];
}
