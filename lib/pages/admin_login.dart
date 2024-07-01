import 'package:flutter/material.dart';
import 'package:memory_app/pages/memory_approval_page.dart';
import 'package:memory_app/theme/text_theme.dart';
import 'package:memory_app/widgets/custom_textfield.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Girişi',
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
      ),
      backgroundColor: Colors.white,
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 600,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: emailController,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF205761),
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      inputHint: 'E-posta adresinizi giriniz',
                      fillColor: Colors.white.withOpacity(0.5),
                      filled: true,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: passwordController,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF205761),
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      inputHint: 'Parola',
                      fillColor: Colors.white.withOpacity(0.5),
                      filled: true,
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      buttonText: 'Giriş',
                      onTap: _login,
                      size: 16,
                    ),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Color(0xFFE9C522),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MemoryApprovalPage(),
        ),
      );
    } else {
      setState(() {
        errorMessage = 'E-posta ve şifre alanları boş olamaz.';
      });
    }
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double size;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFE9C522),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: AppTextTheme.kLabelStyle.copyWith(
              color: Colors.black,
              fontSize: size,
            ),
          ),
        ),
      ),
    );
  }
}
