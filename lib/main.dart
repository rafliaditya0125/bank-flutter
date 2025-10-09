import 'package:flutter/material.dart';
import 'loading.dart';

class Properti {
  static const Color warnaUtama = Color(0xFF8700C3);
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanLoading(),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => HalamanLoading(),
        '/main': (context) => HalamanUtama(),
      },
    ),
  );
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
