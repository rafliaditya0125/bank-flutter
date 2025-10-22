import 'package:bank/properties.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Properties.mainColor,
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.savings, color: Colors.white, size: 60),
          const SizedBox(height: 40),
          Material(
            color: Colors.transparent,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Properties.signOutDialog(context);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.white.withValues(alpha: 0.1),
                ),
              ),
              child: Text(
                'Sign Out',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
