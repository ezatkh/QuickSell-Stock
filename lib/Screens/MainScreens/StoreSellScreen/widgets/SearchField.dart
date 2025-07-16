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
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / 390).clamp(0.85, 1.2); // Base width 390

    final fontSize = 14 * scale;
    final borderRadius = 12.0 * scale;
    final paddingV = 12.0 * scale;
    final paddingH = 14.0 * scale;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: fontSize,
        color: AppColors.primaryTextColor,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: fontSize - 1, color: Colors.grey),
        filled: true,
        fillColor: AppColors.backgroundColor, // Set fill color to white
        prefixIcon: Icon(Icons.search, color: Colors.grey, size: 22 * scale),
        suffixIcon: controller != null && controller!.text.isNotEmpty
            ? IconButton(
          icon: Icon(Icons.close, color: Colors.grey, size: 20 * scale),
          onPressed: () {
            controller?.clear();
            if (onClear != null) onClear!();
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: paddingV,
          horizontal: paddingH,
        ),
      ),
    );
  }
}
