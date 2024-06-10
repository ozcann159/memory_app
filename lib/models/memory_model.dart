import 'package:cloud_firestore/cloud_firestore.dart';

class Memory {
  final String name;
  final String surname;
  final String state;
  final String city;
  final String memory;
  final String imageUrl;

  Memory({
    required this.name,
    required this.surname,
    required this.state,
    required this.city,
    required this.memory,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'state': state,
      'city': city,
      'memory': memory,
      'imageUrl': imageUrl,
    };
  }

  static Memory fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Memory(
      name: data['name'] ?? '',
      surname: data['surname'] ?? '',
      state: data['state'] ?? '',
      city: data['city'] ?? '',
      memory: data['memory'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
