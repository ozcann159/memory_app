import 'package:equatable/equatable.dart';

abstract class MemoryEvent extends Equatable {
  const MemoryEvent();

  @override
  List<Object> get props => [];
}

class SubmitMemory extends MemoryEvent {
  final String name;
  final String surname;
  final String state;
  final String city;
  final String memory;
  final String imageUrl;

  const SubmitMemory({
    required this.name,
    required this.surname,
    required this.state,
    required this.city,
    required this.memory,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [name, surname, state, city, memory, imageUrl];
}

class LoadMemories extends MemoryEvent {}
