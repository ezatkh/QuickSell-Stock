import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    final screenWidth = ScreenUtil().screenWidth;
    final scale = (screenWidth / 390).clamp(0.70, 1.2);

    final scaledButtonWidth = buttonWidth * scale;
    final scaledVerticalPadding = 14.0 * scale;
    final scaledHorizontalPadding = 24.0 * scale;
    final iconSize = 30.0 * scale;
    final iconSpacing = 12.0 * scale;
    final borderRadius = 12.0 * scale;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: scaledButtonWidth,
        minWidth: scaledButtonWidth,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: EdgeInsets.symmetric(
            vertical: scaledVerticalPadding,
            horizontal: scaledHorizontalPadding,
          ),
          minimumSize: Size(scaledButtonWidth, 60 * scale),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              size: iconSize,
              color: iconColor,
            ),
            SizedBox(width: iconSpacing),
            Icon(
              Icons.face,
              size: iconSize,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
