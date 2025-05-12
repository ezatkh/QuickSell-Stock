import 'package:flutter/material.dart';

class SmartLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color iconColor;
  final double buttonWidth; // Custom width parameter

  const SmartLoginButton({
    Key? key,
    required this.onPressed,
    required this.buttonColor,
    required this.iconColor,
    this.buttonWidth = 120.0, // Default fixed width is 150.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: buttonWidth, // Set maximum width to the provided value
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
          minimumSize: const Size(150, 60), // Minimum size to keep button consistent
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              size: 30,
              color: iconColor,
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.face,
              size: 30,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
