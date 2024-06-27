import 'package:carousel_slider/carousel_slider.dart';
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
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 200,
                    child: _buildImageSlider(),
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
                  textColor,
                  backgroundColor,
                ),
                const SizedBox(height: 10.0),
                _buildDetailText(
                  'Şehir:',
                  memoryData['city'] ?? 'Bilinmiyor',
                  textColor,
                  backgroundColor,
                ),
                const SizedBox(height: 10.0),
                _buildDetailText(
                  'Cami:',
                  memoryData['mosque'] ?? 'Bilinmiyor',
                  textColor,
                  backgroundColor,
                ),
                const SizedBox(height: 10.0),
                _buildDetailText(
                  'Hatıra:',
                  memoryData['memory'] ?? 'Bilinmiyor',
                  textColor,
                  backgroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
  List<String> imageUrls = memoryData['imageUrls'] ?? [];
  if (imageUrls.isEmpty) {
    return const Icon(Icons.image_not_supported, size: 50);
  } else {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: imageUrls.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
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
