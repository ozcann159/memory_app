import 'package:equatable/equatable.dart';
import 'package:memory_app/models/memory_model.dart';

abstract class MemoryListState extends Equatable {
  const MemoryListState();

  @override
  List<Object> get props => [];
}

class MemoryListInitial extends MemoryListState {}

class MemoryListLoading extends MemoryListState {}

class MemoryListLoaded extends MemoryListState {
  final List<Memory> memories;

  const MemoryListLoaded(this.memories);

  @override
  List<Object> get props => [memories];
}

class MemoryListError extends MemoryListState {
  final String message;

  const MemoryListError(this.message);

  @override
  List<Object> get props => [message];
}
