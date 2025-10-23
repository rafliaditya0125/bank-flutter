import 'package:bank/utilities/button.dart';
import 'package:bank/utilities/properties.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Properties.mainColor),
        title: Icon(Icons.savings, size: 40),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create New Account',
                    style: TextStyle(color: Properties.mainColor, fontSize: 20),
                  ),
                  const SizedBox(height: 40),
                  Properties.generateInputField(
                    'Email',
                    Icons.email,
                    usernameController,
                    false,
                    (text) {
                      setState(() {});
                    },
                  ),
                  Properties.generateInputField(
                    'Password',
                    Icons.lock,
                    passwordController,
                    true,
                    (text) {
                      setState(() {});
                    },
                  ),
                  Properties.generateInputField(
                    'Confirm Password',
                    Icons.lock,
                    confirmPasswordController,
                    true,
                    (text) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Button(
              label: 'Register',
              enabled: validateFormFields(),
              onTap: () async {
                String username = usernameController.value.text;
                String password = passwordController.value.text;

                bool accountCreated = await loginService
                    .createUserWithEmailAndPassword(username, password);
                if (accountCreated) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool validateFormFields() {
    return Properties.validateEmail(usernameController.value.text) &&
        usernameController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty &&
        confirmPasswordController.value.text.isNotEmpty &&
        (passwordController.value.text == confirmPasswordController.value.text);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
