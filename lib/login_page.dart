import 'package:bank/button.dart';
import 'package:bank/properties.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool validateEmailAndPassword() {
    return usernameController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty &&
        Properties.validateEmail(usernameController.value.text);
  }

  @override
  Widget build(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Properties.backgroundColor,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(width: 7, color: Properties.mainColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.savings, color: Properties.mainColor, size: 45),
            ),
            SizedBox(height: 30),
            Text(
              'Welcome to',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            Text(
              'Flutter\nBank App',
              style: TextStyle(color: Properties.mainColor, fontSize: 30),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Sign Into Your Bank Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 20,
                            bottom: 11,
                            top: 11,
                            right: 15,
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Properties.mainColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Email",
                        ),
                        style: TextStyle(fontSize: 16),
                        controller: usernameController,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {});
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 20,
                            bottom: 11,
                            top: 11,
                            right: 15,
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Properties.mainColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Password",
                        ),
                        style: TextStyle(fontSize: 16),
                        controller: passwordController,
                      ),
                    ),
                    Consumer<LoginService>(
                      builder: (context, lService, child) {
                        String errorMsg = lService.getErrorMessage();

                        if (errorMsg.isEmpty) {
                          return const SizedBox(height: 40);
                        }

                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Row(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Button(
              label: "Sign In",
              enabled: validateEmailAndPassword(),
              onTap: () async {
                var email = usernameController.value.text;
                var password = passwordController.value.text;

                bool isLoggedIn = await loginService.signInWithEmailAndPassword(
                  email,
                  password,
                );

                if (isLoggedIn) {
                  usernameController.clear();
                  passwordController.clear();
                  Navigator.pushNamed(context, '/home');
                }
              },
            ),
            SizedBox(height: 10),
            Button(
              label: 'Register',
              icon: Icons.account_circle,
              backgroundColor: Properties.mainColor.withValues(alpha: 0.2),
              iconColor: Properties.mainColor,
              labelColor: Properties.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginService extends ChangeNotifier {
  String _userId = '';
  String _errorMessage = '';

  String getUserId() {
    return _userId;
  }

  String getErrorMessage() {
    return _errorMessage;
  }

  void setLoginErrorMessage(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    setLoginErrorMessage('');
    try {
      UserCredential credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _userId = credentials.user!.uid;
      return true;
    } on FirebaseAuthException catch (ex) {
      setLoginErrorMessage('Error during sign in: ' + ex.message!);
      return false;
    }
  }
}
