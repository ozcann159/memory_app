import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:memory_app/bloc/memory_event.dart';
import 'package:memory_app/bloc/memory_state.dart';
import 'package:meta/meta.dart';


class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  MemoryBloc() : super(MemoryInitial()) {
    

    @override
    Stream<MemoryState> mapEventToState(MemoryEvent event)async*{
      if (event is SubmitMemory) {
        yield MemorySubmitting();
        try {
          final docRef = FirebaseFirestore.instance.collection('memories').doc();
          await docRef.set({
            'name': event.name,
            'surname': event.surname,
            'state': event.state,
            'city': event.city,
            'memory': event.memory,
            'timestamp':FieldValue.serverTimestamp(),
          });

          //Resim yükleme
          if (event.imageUrl != null) {
            final storageRef = FirebaseStorage.instance.ref().child('memories/${docRef.id}');
            await storageRef.putFile(File(event.imageUrl));
            final imageUrl = await storageRef.getDownloadURL();
            await docRef.update({'imageUrl': imageUrl});
          }

          yield MemorySubmitted();
        } catch (e) {
          yield MemorySubmitError(e.toString());
        }
      }
    }
  }
}
