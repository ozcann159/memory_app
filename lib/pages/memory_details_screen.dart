import 'package:flutter/material.dart';

class MemoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> memoryData;

  const MemoryDetailScreen({super.key, required this.memoryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hatıra Detayı'),
        backgroundColor: Colors.green[200],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: memoryData.containsKey('imageUrl')
                      ? Image.network(
                          memoryData['imageUrl'],
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Ad Soyad:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.green[400],
              ),
            ),
            Text(
              memoryData['name'] != null && memoryData['surname'] != null
                  ? '${memoryData['name']} ${memoryData['surname']}'
                  : 'Bilinmiyor',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Eyalet:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.green[400],
              ),
            ),
            Text(
              memoryData['state'] ?? 'Bilinmiyor',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Şehir:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.green[400],
              ),
            ),
            Text(
              memoryData['city'] ?? 'Bilinmiyor',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Cami:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.green[400],
              ),
            ),
            Text(
              memoryData['mosque'] ?? 'Bilinmiyor',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Hatıra:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.green[400],
              ),
            ),
            Text(
              memoryData['memory'] ?? 'Bilinmiyor',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
