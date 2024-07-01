import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memory_app/models/memory_model.dart';
import 'package:memory_app/pages/memory_details_screen.dart';
import 'package:memory_app/pages/memory_entry_page.dart';
import 'package:memory_app/repo/memory_repository.dart';
import 'package:memory_app/theme/text_theme.dart';

class MemoryListPage extends StatelessWidget {
  final MemoryRepository memoryRepository = MemoryRepository();

  MemoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color(0xFF205761);
    Color backgroundColor = const Color(0xFFD4DBC3);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hatıralar',
          style: AppTextTheme.kAppBarTitleStyle,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF205761),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MemoryEntryPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/admin-login');
            },
            icon: const Icon(
              Icons.admin_panel_settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: StreamBuilder<List<Memory>>(
          stream: memoryRepository.getMemoriesOrderedByDate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Henüz onaylanmış bir hatıra yok.'),
              );
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  // Mobil görünüm
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Memory memory = snapshot.data![index];
                      return MemoryListItem(
                        memory: memory,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemoryDetailScreen(
                                memoryData: memory.toMap(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  // Web görünüm
                  return Center(
                    child: SizedBox(
                      width: 600,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Memory memory = snapshot.data![index];
                          return MemoryListItem(
                            memory: memory,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemoryDetailScreen(
                                    memoryData: memory.toMap(),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class MemoryListItem extends StatelessWidget {
  final Memory memory;
  final VoidCallback onTap;

  const MemoryListItem({
    required this.memory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          margin: const EdgeInsets.all(8),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: const Color(0xFFD4DBC3).withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${memory.name} ${memory.surname}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd.MM.yyyy HH:mm').format(memory.date),
                      style: const TextStyle(
                        color: Color(0xFF205761),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
