import 'package:flutter/material.dart';
import 'loading.dart';
import 'login.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
      },
    ),
  );
}
