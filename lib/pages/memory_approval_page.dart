import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memory_app/models/memory_model.dart';
import 'package:memory_app/repo/memory_repository.dart';

class MemoryApprovalPage extends StatelessWidget {
  final MemoryRepository memoryRepository = MemoryRepository();

  MemoryApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Onaylanmamış Hatıralar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF205761),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<List<Memory>>(
          stream: memoryRepository.getUnapprovedMemories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
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
        margin: const EdgeInsets.all(8),
        elevation: 3,
        color: const Color(0xFFD4DBC3).withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                memory.mosque,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF205761),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                memory.memory,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, color: Color(0xFF205761)),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy HH:mm').format(memory.date),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white),
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
  final MemoryRepository memoryRepository = MemoryRepository();

  MemoryApprovalDetailScreen({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hatıra Onay Detayı',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF205761),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/background_image.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${memory.name} ${memory.surname}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF205761),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    memory.memory,
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xFF205761)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await memoryRepository.approveMemory(memory.id);
                            Navigator.pop(context);
                          },
                          child: const Text('Onayla',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF205761),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Hatıra Reddedildi'),
                                content: const Text(
                                    'Hatıra yazma koşullarına uymadığınız için hatıranız reddedilmiştir.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Tamam'),
                                  ),
                                ],
                              ),
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Reddet',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('dd.MM.yyyy HH:mm').format(memory.date),
                        style: const TextStyle(
                          color: Color(0xFF205761),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
