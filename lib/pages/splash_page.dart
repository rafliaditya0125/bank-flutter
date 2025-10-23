import 'package:flutter/material.dart';
import 'package:bank/utilities/properties.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
    return Container(
      color: Properties.mainColor,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          Center(child: Icon(Icons.savings, color: Colors.white, size: 60)),
        ],
      ),
    );
  }
}
