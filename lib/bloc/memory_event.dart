// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

abstract class MemoryEvent extends Equatable{
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
  SubmitMemory({
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
