import 'package:flutter/material.dart';
import 'package:memory_app/theme/text_theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anı Defteri',
          style: AppTextTheme.kAppBarTitleStyle,
        ),
        backgroundColor: Color(0xFF205761),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/memory-form');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    backgroundColor: Color(0xFF205761),
                  ),
                  child: const Text(
                    'Hatıra Ekle',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin-login');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    backgroundColor: const Color(0xFF205761),
                  ),
                  child: const Text(
                    'Admin Girişi',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/memories');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    backgroundColor: const Color(0xFF205761),
                  ),
                  child: const Text(
                    'Onaylanan Hatıralar',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
