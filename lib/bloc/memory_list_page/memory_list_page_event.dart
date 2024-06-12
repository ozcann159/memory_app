import 'package:equatable/equatable.dart';

abstract class MemoryListEvent extends Equatable {
  const MemoryListEvent();

  @override
  List<Object> get props => [];
}

class LoadMemories extends MemoryListEvent {}
