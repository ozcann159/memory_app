import 'package:flutter/material.dart';

class MemoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> memoryData;

  MemoryDetailScreen({required this.memoryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hatıra Detayı'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ad Soyad:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              memoryData['name'] != null && memoryData['surname'] != null
                  ? '${memoryData['name']} ${memoryData['surname']}'
                  : 'Bilinmiyor',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Eyalet:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              memoryData['state'] ?? 'Bilinmiyor',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Şehir:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              memoryData['city'] ?? 'Bilinmiyor',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Cami:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              memoryData['mosque'] ?? 'Bilinmiyor',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Hatıra:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              memoryData['memory'] ?? 'Bilinmiyor',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            if (memoryData.containsKey('imageUrl'))
              Image.network(
                memoryData['imageUrl'],
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
