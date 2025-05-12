import 'package:flutter/material.dart';
import '../../../../Constants/app_color.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Function()? onClear;
  final Function(String)? onChanged;

  const SearchField({
    Key? key,
    this.controller,
    this.hintText = 'Search',
    this.onClear,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.backgroundColor, // Set fill color to white
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: controller != null && controller!.text.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            controller?.clear();
            if (onClear != null) onClear!();
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Use borderRadius here
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)), // Apply to enabled state
          borderSide: BorderSide(color: Colors.white), // Optional: Grey border when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)), // Apply to enabled state
          borderSide: BorderSide(color: Colors.white), // Optional: Grey border when not focused
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0), // Adjust vertical padding to control height
      ),
    );
  }
}
