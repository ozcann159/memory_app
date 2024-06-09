// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class MemoryState extends Equatable{
  @override
  List<Object> get props => [];
}


class MemoryInitial extends MemoryState{}

class MemorySubmitting extends MemoryState{}

class MemorySubmitted extends MemoryState{}

class MemorySubmitError extends MemoryState {
  final String error;
  MemorySubmitError(
    this.error,
  );

  @override
  List<Object> get props => [error];
}
