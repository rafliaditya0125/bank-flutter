import 'package:bank/home_page.dart';
import 'package:bank/properties.dart';
import 'package:bank/register_page.dart';
import 'package:flutter/material.dart';
import 'splash_page.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => BankService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/register': (context) => RegisterPage(),
        },
      ),
    ),
  );
}
