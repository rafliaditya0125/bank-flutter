import 'package:flutter/material.dart';
import 'main.dart';

class HalamanLoading extends StatelessWidget {
  const HalamanLoading({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/main');
    });
    return Container(
      color: Properti.warnaUtama,
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
