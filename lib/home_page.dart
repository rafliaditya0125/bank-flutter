import 'package:bank/properties.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Properties.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Properties.mainColor),
        backgroundColor: Colors.transparent,
        title: Icon(Icons.savings, size: 40),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.account_balance_wallet,
                  color: Properties.mainColor,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'My Accounts',
                  style: TextStyle(color: Properties.mainColor, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<BankService>(
                builder: (context, bankService, child) {
                  return FutureBuilder(
                    future: bankService.getAccounts(context),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.done ||
                          !snapshot.hasData) {
                        return Text('Loading');
                      }

                      List<Account> accounts = snapshot.data as List<Account>;

                      if (accounts.isEmpty) {
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.account_balance_wallet,
                                color: Properties.mainColor,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'You don\'t have any accounts\nassociated with your profile.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Properties.mainColor),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          var acct = accounts[index];
                          return Text(acct.type!);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final Account? account;
  const AccountCard({this.account, super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
