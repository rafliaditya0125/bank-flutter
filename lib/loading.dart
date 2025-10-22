import 'package:bank/properties.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          children: const [
            Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Properties.mainColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Icon(Icons.savings, color: Properties.mainColor, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}
