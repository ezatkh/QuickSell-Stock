import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/LocalizationService.dart';
import 'MainScreen.dart';
import 'LoginScreen/LoginScreen.dart';
import '../States/LoginState.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoOpacity;
  late Animation<double> _backgroundLighten;
  late Animation<double> _logoScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));

    _logoOpacity = Tween(begin: 0.7, end: 0.0).animate(_controller);
    _backgroundLighten = Tween(begin: 0.2, end: 1.0).animate(_controller);
    _logoScale = Tween(begin: 0.9, end: 0.6).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Provider.of<LocalizationService>(context, listen: false).initLocalization();
        _handleNavigation();
      }
    });
  }

  void _handleNavigation() {
    final loginState = Provider.of<LoginState>(context, listen: false);
    if (loginState.loginSccessful) {
      Navigator.of(context).pushReplacement(
        _createRoute(MainScreen()), // Navigate to DashboardScreen on successful login
      );
    } else {
      Navigator.of(context).pushReplacement(
        _createRoute(LoginScreen()), // Navigate to LoginScreen if not logged in
      );
    }
  }

  Route _createRoute(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionDuration: Duration(seconds: 2), // Increase duration for a slower transition
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.5;
        const end = 1.0;
        const curve = Curves.easeInOut; // You can change the curve to adjust the timing of the fade

        // Define a fade animation with a slower duration
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(_backgroundLighten.value),
            ),
            child: Center(
              child: Opacity(
                opacity: _logoOpacity.value,
                child: Transform.scale(
                  scale: _logoScale.value,
                  child: Image.asset('assets/images/animatedLogo.gif'), // Updated to use animated GIF
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
