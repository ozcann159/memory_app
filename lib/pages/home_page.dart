import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hoş Geldiniz',
          style: TextStyle(
            fontFamily: 'Poppins', // Yeni font
            fontSize: 20, // Yeni font boyutu
            color: Colors.white, // Yeni metin rengi
          ),
        ),
        backgroundColor: Color(0xFF205761), // Yeni app bar rengi
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_image.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/memory-form');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE9C522),
                  ),
                  child: Text(
                    'Hatıra Ekle',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin-login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE9C522),
                  ),
                  child: Text(
                    'Admin Girişi',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
