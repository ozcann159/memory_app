import 'package:flutter/material.dart';
import 'package:memory_app/theme/text_theme.dart';

class MemoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> memoryData;

  const MemoryDetailScreen({Key? key, required this.memoryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color(0xFFFFFFFF);
    Color backgroundColor = const Color(0xFFD4DBC3);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hatıra Detayı',
          style: AppTextTheme.kAppBarTitleStyle,
        ),
        backgroundColor: const Color(0xFF205761),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SizedBox.expand(
        child: Container(
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
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
                _buildDetailText(
                  'Ad Soyad:',
                  memoryData['name'] != null && memoryData['surname'] != null
                      ? '${memoryData['name']} ${memoryData['surname']}'
                      : 'Bilinmiyor',
                  textColor,
                  backgroundColor,
                ),
                const SizedBox(height: 10.0),
                _buildDetailText(
                  'Eyalet:',
                  memoryData['state'] ?? 'Bilinmiyor',
                  textColor, // Sarı renk
                  backgroundColor,
                ),
                const SizedBox(height: 10.0),
                _buildDetailText(
                  'Şehir:',
                  memoryData['city'] ?? 'Bilinmiyor',
                  textColor, // Sarı renk
                  backgroundColor,
                ),
                const SizedBox(height: 10.0),
                _buildDetailText(
                  'Cami:',
                  memoryData['mosque'] ?? 'Bilinmiyor',
                  textColor, // Sarı renk
                  backgroundColor,
                ),
                const SizedBox(height: 10.0),
                _buildDetailText(
                  'Hatıra:',
                  memoryData['memory'] ?? 'Bilinmiyor',
                  textColor, // Sarı renk
                  backgroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailText(
      String label, String value, Color color, Color backgroundColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: color,
              fontFamily: 'Poppins'),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 18.0, color: backgroundColor, fontFamily: 'OpenSans'),
        ),
      ],
    );
  }
}
