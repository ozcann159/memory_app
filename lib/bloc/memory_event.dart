// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:memory_app/models/memory_model.dart';

abstract class MemoryEvent extends Equatable {
  const MemoryEvent();

  @override
  List<Object> get props => [];
}

class SubmitMemory extends MemoryEvent {
  final String id;
  final String name;
  final String surname;
  final String state;
  final String city;
  final String memory;
  final String imageUrl;
  final String mosque;
  final bool isApproved;
  final String? email;

  const SubmitMemory({
    required this.id,
    required this.name,
    required this.surname,
    required this.state,
    required this.city,
    required this.memory,
    required this.imageUrl,
    required this.mosque,
    required this.isApproved,
    this.email,
  });

 @override
List<Object> get props => [id, name, surname, state, city, memory, imageUrl, mosque, isApproved, ];

}

class LoadMemories extends MemoryEvent {}

class ApproveMemory extends MemoryEvent {
  final Memory memory;

  const ApproveMemory(this.memory);

  @override
  List<Object> get props => [memory];
}

class RejectMemory extends MemoryEvent {
  final Memory memory;

  const RejectMemory(this.memory);

  @override
  List<Object> get props => [memory];
}
