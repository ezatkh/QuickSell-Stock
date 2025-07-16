import 'package:flutter/material.dart';

class ResponsiveSizes {
  static double titleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 300) return 10;
    if (screenWidth < 360) return 12;
    if (screenWidth < 600) return 14;
    return 16;
  }

  static double priceFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 300) return 9;
    if (screenWidth < 360) return 11;
    if (screenWidth < 600) return 13;
    return 15;
  }

  static double subFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 300) return 8;
    if (screenWidth < 360) return 10;
    if (screenWidth < 600) return 11;
    return 12;
  }

  static double padding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 300) return 6;
    if (screenWidth < 360) return 8;
    if (screenWidth < 600) return 12;
    return 16;
  }

  static double borderRadius(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 300) return 6;
    if (screenWidth < 360) return 8;
    if (screenWidth < 600) return 10;
    return 12;
  }
}
