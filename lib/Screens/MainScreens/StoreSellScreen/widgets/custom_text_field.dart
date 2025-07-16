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
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / 390).clamp(0.85, 1.2);

    final fontSize = 14 * scale;
    final borderRadius = 10.0 * scale;
    final paddingV = 12.0 * scale;

    return Padding(
      padding: EdgeInsets.only(bottom: paddingV),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: fontSize,
        ),
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.cardBackgroundColor,
          labelText: labelText,
          labelStyle: TextStyle(
            color: AppColors.hintTextColor,
            fontSize: fontSize,
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: fontSize - 1,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
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
