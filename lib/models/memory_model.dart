import 'package:cloud_firestore/cloud_firestore.dart';

class Memory {
  String name;
  String surname;
  String state;
  String city;
  String memory;
  String imageUrl;
  String mosque;
  DateTime date;

  Memory({
    required this.name,
    required this.surname,
    required this.state,
    required this.city,
    required this.memory,
    required this.imageUrl,
    required this.mosque,
    required this.date,
  });

  factory Memory.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Memory(
      name: data['name'],
      surname: data['surname'],
      state: data['state'],
      city: data['city'],
      memory: data['memory'],
      imageUrl: data['imageUrl'],
      mosque: data['mosque'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'state': state,
      'city': city,
      'memory': memory,
      'imageUrl': imageUrl,
      'mosque': mosque,
      'date': date,
    };
  }
}
