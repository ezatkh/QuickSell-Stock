import 'package:flutter/material.dart';
import '../../../../Constants/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool required;
  final IconData? prefixIcon;
  final int? maxLines;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.required = false,
    this.prefixIcon,
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / 390).clamp(0.85, 1.2);

    final fontSize = 14 * scale;
    final borderRadius = 8.0 * scale;
    final verticalPadding = 10.0 * scale;
    final horizontalPadding = 8.0 * scale;
    final iconSize = 20.0 * scale;

    return Padding(
      padding: EdgeInsets.only(bottom: verticalPadding),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.1),
              spreadRadius: 1 * scale,
              blurRadius: 2 * scale,
              offset: Offset(0, 3 * scale),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: AppColors.primaryTextColor, fontSize: fontSize),
          cursorColor: AppColors.primaryColor,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            labelText: labelText,
            labelStyle: TextStyle(
              color: AppColors.hintTextColor,
              fontSize: fontSize,
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: fontSize * 0.9,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: iconSize, color: AppColors.primaryColor)
                : null,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          validator: required
              ? (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          }
              : null,
        ),
      ),
    );
  }
}
