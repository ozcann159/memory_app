import 'package:cloud_firestore/cloud_firestore.dart';

class Memory {
  String id; // Eklenen alan
  String name;
  String surname;
  String state;
  String city;
  String memory;
  String imageUrl;
  String mosque;
  DateTime date;
  bool isApproved;

  Memory({
    required this.id, // Güncellendi
    required this.name,
    required this.surname,
    required this.state,
    required this.city,
    required this.memory,
    required this.imageUrl,
    required this.mosque,
    required this.date,
    this.isApproved = false,
  });

  factory Memory.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Memory(
      id: doc.id, // Güncellendi
      name: data['name'],
      surname: data['surname'],
      state: data['state'],
      city: data['city'],
      memory: data['memory'],
      imageUrl: data['imageUrl'],
      mosque: data['mosque'],
      date: (data['date'] as Timestamp).toDate(),
      isApproved: data['isApproved'] ?? false,
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
      'isApproved': isApproved,
    };
  }

  Memory copyWith({
    String? id,
    String? name,
    String? surname,
    String? state,
    String? city,
    String? memory,
    String? imageUrl,
    String? mosque,
    DateTime? date,
    bool? isApproved,
  }) {
    return Memory(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      state: state ?? this.state,
      city: city ?? this.city,
      memory: memory ?? this.memory,
      imageUrl: imageUrl ?? this.imageUrl,
      mosque: mosque ?? this.mosque,
      date: date ?? this.date,
      isApproved: isApproved ?? this.isApproved,
    );
  }

}

