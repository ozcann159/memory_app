import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memory_app/models/memory_model.dart';
import 'package:memory_app/repo/memory_repository.dart';
import 'package:memory_app/widgets/custom_button.dart';

class MemoryApprovalPage extends StatelessWidget {
  final MemoryRepository memoryRepository = MemoryRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Onaylanmamış Hatıralar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF205761),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<List<Memory>>(
          stream: memoryRepository.getUnapprovedMemories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text('Onaylanmamış hatıra yok.',
                      style: TextStyle(color: Colors.white)));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Memory memory = snapshot.data![index];
                return buildMemoryCard(context, memory);
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildMemoryCard(BuildContext context, Memory memory) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MemoryApprovalDetailScreen(
              memory: memory,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 3,
        color: const Color(0xFFD4DBC3).withOpacity(0.7),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                memory.mosque,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF205761),
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 8),
              Text(
                memory.memory,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: const Color(0xFF205761)),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy HH:mm').format(memory.date),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MemoryApprovalDetailScreen extends StatelessWidget {
  final Memory memory;

  const MemoryApprovalDetailScreen({Key? key, required this.memory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hatıra Onay Detayı',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF205761),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                memory.name + ' ' + memory.surname,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                memory.memory,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    buttonText: 'Onayla',
                    onTap: () {
                      // Onayla işlemi
                    },
                    size: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Reddet işlemi
                    },
                    child:
                        Text('Reddet', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
