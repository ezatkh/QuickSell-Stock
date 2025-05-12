import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double logoWidth = MediaQuery.of(context).size.width * 0.4;
    final double logoHeight = MediaQuery.of(context).size.height * 0.25;

    return Center(
      child: Image.asset(
        'assets/images/img.png',  // Ensure the asset path is correct
        width: logoWidth,
        height: logoHeight,
      ),
    );
  }
}
