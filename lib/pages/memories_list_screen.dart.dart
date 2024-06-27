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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black45,
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Memory memory = snapshot.data![index];
                return GestureDetector(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: backgroundColor.withOpacity(0.7),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${memory.name} ${memory.surname}',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            SizedBox(height: 8),
                            Text(
                              memory.mosque,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
                                  DateFormat('dd.MM.yyyy HH:mm')
                                      .format(memory.date),
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
              },
            );
          },
        ),
      ),
    );
  }
}
