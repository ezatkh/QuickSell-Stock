import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Constants/app_color.dart';
import '../Services/LocalizationService.dart';

class CustomPopups {

  static void showCustomDialog({
    required BuildContext context,
    required Icon icon,
    required String title,
    required String message,
    required String deleteButtonText,
    required VoidCallback onPressButton,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(Provider.of<LocalizationService>(context, listen: false).getLocalizedString('cancel'), style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
              ),
              child: Text(deleteButtonText),
              onPressed: () {
                Navigator.of(context).pop();
                onPressButton();

              },
            ),
          ],
        );
      },
    );
  }

  static void showCustomResultPopup({
    required BuildContext context,
    required Icon icon,
    required String message,
    required String buttonText,
    required VoidCallback onPressButton,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: Colors.white, // White background for the dialog
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Black text color for readability
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF7F7F7), // Set light red button color
                    elevation: 0, // Remove shadow for a flat button effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding for a larger button
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black, // Black text for contrast
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPressButton();
                  },
                ),
              ),
            ],
          );
        },
      );
    });


  }

}
