import 'package:bank/utilities/bottom_bar.dart';
import 'package:bank/utilities/drawer.dart';
import 'package:bank/utilities/loading.dart';
import 'package:bank/utilities/properties.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
                        return Loading();
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
                          return AccountCard(account: acct);
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
      bottomNavigationBar: BottomBar(),
      drawer: Drawer(child: AppDrawer()),
    );
  }
}

class AccountCard extends StatelessWidget {
  final Account? account;
  const AccountCard({this.account, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                '${account!.type!.toUpperCase()} ACCT',
                textAlign: TextAlign.left,
                style: TextStyle(color: Properties.mainColor, fontSize: 12),
              ),
              Text('**** ${account!.accountNumber}'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Balance',
                textAlign: TextAlign.left,
                style: TextStyle(color: Properties.mainColor, fontSize: 12),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: Properties.mainColor,
                    size: 30,
                  ),
                  Text(
                    '\$${account!.balance!.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.black, fontSize: 35),
                  ),
                ],
              ),
              Text(
                'As of ${DateFormat.yMd().add_jm().format(DateTime.now())}',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
