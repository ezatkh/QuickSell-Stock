import 'package:flutter/material.dart';
import '../../../../Constants/app_color.dart'; // Make sure the app colors are imported

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool required; // Add required field flag

  // Constructor for the CustomTextField widget
  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text, // Default to TextInputType.text if not specified
    this.required = false, // Default to false if not specified
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: AppColors.primaryTextColor), // Text color from AppColors
        cursorColor: AppColors.primaryColor, // Cursor color to match the theme
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.cardBackgroundColor, // White background from AppColors
          labelText: labelText,
          labelStyle: TextStyle(
            color: AppColors.hintTextColor, // Label color from AppColors
            fontSize: 14, // Larger label text
          ),
          hintStyle: TextStyle(
            color: Colors.grey, // Grey hint text
            fontSize: 14, // Smaller hint text size
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
            borderSide: BorderSide(
              color: AppColors.primaryColor, // Border color from AppColors
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners when focused
            borderSide: BorderSide(
              color: AppColors.primaryColor, // Focused border color
              width: 2, // Thicker border on focus
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners for enabled state
            borderSide: BorderSide(
              color: AppColors.primaryColor, // Enabled border color
              width: 1,
            ),
          ),
        ),
        validator: (value) {
          if (required && (value == null || value.isEmpty)) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }
}
