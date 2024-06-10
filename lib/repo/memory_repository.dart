import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_app/models/memory_model.dart';


class MemoryRepository {
  final CollectionReference memoryCollection =
      FirebaseFirestore.instance.collection('memories');

  Future<DocumentReference> addMemory(Memory memory) async {
    return memoryCollection.add(memory.toMap());
  }

  Stream<List<Memory>> getMemories() {
    return memoryCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Memory.fromDocument(doc);
      }).toList();
    });
  }
}
