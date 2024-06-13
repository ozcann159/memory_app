import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_app/models/memory_model.dart';

class MemoryRepository {
  final CollectionReference memoryCollection =
      FirebaseFirestore.instance.collection('memories');

   Future<void> addMemory(Memory memory) async {
    await memoryCollection.add({
      ...memory.toMap(),
      'mosque': memory.mosque, 
    });
  }

   Stream<List<Memory>> getMemories() {
    return memoryCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Memory.fromDocument(doc);
      }).toList();
    });
  }
}
