import 'package:flutter/material.dart';
import '../../../../Constants/app_color.dart'; // Make sure the app colors are imported

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool required; // Add required field flag
  final IconData? prefixIcon; // Add prefixIcon parameter
  final int? maxLines; // Add maxLines parameter

  // Constructor for the CustomTextField widget
  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text, // Default to TextInputType.text if not specified
    this.required = false, // Default to false if not specified
    this.prefixIcon, // Optional prefixIcon
    this.maxLines = 1, // Default to 1 line if not specified
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: AppColors.primaryTextColor), // Text color from AppColors
          cursorColor: AppColors.primaryColor, // Cursor color to match the theme
          maxLines: maxLines, // Set max lines dynamically
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent, // Transparent background (since we already have a box decoration)
            labelText: labelText,
            hintStyle: TextStyle(
              color: Colors.grey, // Grey hint text
              fontSize: 12, // Smaller hint text size
            ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null, // Prefix icon if provided
            border: InputBorder.none,// No border here, since we are using box decoration
            enabledBorder: InputBorder.none, // Ensures no border is visible when the field is enabled
            focusedBorder: InputBorder.none, // Ensures no border is visible when the field is focused
            errorBorder: InputBorder.none, // Ensures no border is visible when there is an error
            focusedErrorBorder: InputBorder.none, // Ensures no border is visible when the field has error while focused
          ),
        ),
      ),
    );
  }
}
