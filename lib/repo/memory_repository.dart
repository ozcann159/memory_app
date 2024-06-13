import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_app/models/memory_model.dart';

class MemoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference memoryCollection =
      FirebaseFirestore.instance.collection('memories');

  Stream<List<Memory>> getMemoriesOrderedByDate() {
    return _firestore
        .collection('memories')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Memory.fromDocument(doc))
            .toList());
  }

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
