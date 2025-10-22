import 'dart:async';
import 'package:bank/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Properties {
  static const Color mainColor = Color(0xFF8700C3);
  static const Color backgroundColor = Colors.white;

  static bool validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);

    return (value != null || value!.isNotEmpty || regex.hasMatch(value));
  }

  static Widget generateInputField(
    String hintText,
    IconData iconData,
    TextEditingController controller,
    bool isPasswordField,
    Function onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        onChanged: (text) {
          onChanged(text);
        },
        obscureText: isPasswordField,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 20,
            bottom: 11,
            top: 11,
            right: 15,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(iconData, color: Properties.mainColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText,
        ),
        controller: controller,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  static List<BottomBarItem> getBottomBarItems() {
    return [
      BottomBarItem(label: 'Wirthdaw', icon: Icons.logout, action: () {}),
      BottomBarItem(label: 'Deposit', icon: Icons.login, action: () {}),
      BottomBarItem(label: 'Expenses', icon: Icons.payment, action: () {}),
    ];
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

  Future<bool> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException {
      return false;
    }
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

class Account {
  String? id;
  String? type;
  String? accountNumber;
  double? balance;

  Account({this.id, this.type, this.accountNumber, this.balance});

  factory Account.fromJson(Map<String, dynamic> json, String docId) {
    return Account(
      id: docId,
      type: json['type'],
      accountNumber: json['account_number'],
      balance: json['balance'],
    );
  }
}

class BankService extends ChangeNotifier {
  Future<List<Account>> getAccounts(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(
      context,
      listen: false,
    );
    String userId = loginService.getUserId();

    List<Account> accounts = [];

    Completer<List<Account>> accountsCompleter = Completer();

    FirebaseFirestore.instance
        .collection('accounts')
        .doc(userId)
        .collection('user_accounts')
        .get()
        .then((QuerySnapshot collection) {
          for (var doc in collection.docs) {
            var acctDoc = doc.data() as Map<String, dynamic>;
            var acct = Account.fromJson(acctDoc, doc.id);
            accounts.add(acct);
          }

          Future.delayed(Duration(seconds: 1), () {
            accountsCompleter.complete(accounts);
          });
        })
        .catchError((error) {
          accountsCompleter.complete([]);
        });
    return accountsCompleter.future;
  }
}
