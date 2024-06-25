// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:memory_app/theme/text_theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final VoidCallback onTap;
  final double? size;
  const CustomButton({
    Key? key,
    required this.buttonText,
    this.buttonColor,
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
          color: buttonColor ?? const Color(0xFFE9C522),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: AppTextTheme.kLabelStyle
                .copyWith(color: Colors.black, fontSize: size ?? 16),
          ),
        ),
      ),
    );
  }
}
