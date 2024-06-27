import 'package:cloud_firestore/cloud_firestore.dart';

class Memory {
  String id;
  String name;
  String surname;
  String state;
  String city;
  String memory;
  String mosque;
  DateTime date;
  bool isApproved;
  List<String> imageUrls;
  String? email;

  Memory({
    required this.id,
    required this.name,
    required this.surname,
    required this.state,
    required this.city,
    required this.memory,
    required this.mosque,
    required this.date,
    this.isApproved = false,
    required this.imageUrls,
    this.email,
  });

  factory Memory.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Memory(
      id: doc.id,
      name: data['name'],
      surname: data['surname'],
      state: data['state'],
      city: data['city'],
      memory: data['memory'],
      mosque: data['mosque'],
      date: (data['date'] as Timestamp).toDate(),
      isApproved: data['isApproved'] ?? false,
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      email: data['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'state': state,
      'city': city,
      'memory': memory,
      'imageUrls': imageUrls,
      'mosque': mosque,
      'date': date,
      'isApproved': isApproved,
      'email': email,
    };
  }

  Memory copyWith({
    String? id,
    String? name,
    String? surname,
    String? state,
    String? city,
    String? memory,
    List<String>? imageUrls,
    String? mosque,
    DateTime? date,
    bool? isApproved,
    String? email,
  }) {
    return Memory(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      state: state ?? this.state,
      city: city ?? this.city,
      memory: memory ?? this.memory,
      imageUrls: imageUrls ?? this.imageUrls,
      mosque: mosque ?? this.mosque,
      date: date ?? this.date,
      isApproved: isApproved ?? this.isApproved,
      email: email ?? this.email,
    );
  }
}
