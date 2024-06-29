import 'package:flutter/material.dart';
import 'package:memory_app/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final int? maxLines, minLines;
  final String? inputHint;
  final Widget? suffixIcon, prefixIcon;
  final bool? obscureText;
  final TextInputType? inputKeyBoardType;
  final Color? inputFillColor;
  final InputBorder? border, focusedBorder, enabledBorder;
  final Function()? pressMe;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final bool? filled; // Yeni eklendi

  const CustomTextField({
    Key? key,
    this.inputHint,
    this.suffixIcon,
    this.obscureText,
    this.inputKeyBoardType,
    this.inputFillColor,
    this.prefixIcon,
    this.border,
    this.pressMe,
    this.validator,
    this.controller,
    this.maxLines,
    this.minLines,
    this.hintStyle,
    this.focusedBorder,
    this.enabledBorder,
    this.onChanged,
    this.filled,
    required Color fillColor, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: inputKeyBoardType,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              hintText: inputHint,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              border: border ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF205761),
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
              focusedBorder: focusedBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.kGreenColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
              enabledBorder: enabledBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xffd1d8ff),
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
              filled: filled ?? false, 
              fillColor: filled!
                  ? Colors.white.withOpacity(0.5)
                  : null, // Yeni eklendi
            ),
            onChanged: onChanged,
            validator: validator,
            minLines: minLines,
            maxLines: maxLines,
            style: hintStyle,
          ),
        ],
      ),
    );
  }
}
