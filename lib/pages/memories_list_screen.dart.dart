import 'package:flutter/material.dart';
import 'package:memory_app/models/memory_model.dart';
import 'package:memory_app/pages/memory_details_screen.dart';
import 'package:memory_app/pages/memory_entry_page.dart';
import 'package:memory_app/repo/memory_repository.dart';

class MemoryListPage extends StatelessWidget {
  final MemoryRepository memoryRepository = MemoryRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hatıralar'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemoryEntryPage()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<List<Memory>>(
        stream: memoryRepository.getMemories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Henüz bir hatıra yok.'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Memory memory = snapshot.data![index];
              return ListTile(
                title: Text(memory.city),
                subtitle: Text(memory.memory),
                leading: Image.network(memory.imageUrl),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MemoryDetailScreen(
                                memoryData: memory.toMap(),
                              )));
                },
              );
            },
          );
        },
      ),
    );
  }
}
