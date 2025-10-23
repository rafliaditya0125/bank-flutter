import 'package:bank/pages/home_page.dart';
import 'package:bank/pages/deposit.dart';
import 'package:bank/utilities/properties.dart';
import 'package:bank/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utilities/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => BankService()),
        ChangeNotifierProvider(create: (_) => DepositService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BankDeposit(),
        /*initialRoute: '/deposit',
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/register': (context) => RegisterPage(),
          '/deposit': (context) => BankDeposit(),
        },*/
      ),
    ),
  );
}
