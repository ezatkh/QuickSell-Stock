import 'package:flutter/material.dart';
import '../../../../Constants/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.color,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / 390).clamp(0.70, 1.2);
    double buttonWidth = screenWidth * 0.9;

    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.primaryColor, // Default to primary color
            foregroundColor: textColor ?? Colors.white, // Default to white text
            padding: EdgeInsets.symmetric(vertical: 12 * scale),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20 * scale),
            ),
            elevation: 4,
            textStyle: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16 * scale,
              fontFamily: 'NotoSansUI',
            ),
          ),
          child: isLoading
              ? SizedBox(
            height: 24 * scale,
            width: 24 * scale,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : Text(text),
        ),
      ),
    );
  }
}
