import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final scale = (screenSize.width / 390).clamp(0.85, 1.2);

    final double logoWidth = 156 * scale;
    final double logoHeight = 172 * scale;


    return Center(
      child: Image.asset(
        'assets/images/img.png',  // Ensure the asset path is correct
        width: logoWidth,
        height: logoHeight,
      ),
    );
  }
}
