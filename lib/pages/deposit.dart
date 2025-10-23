import 'package:bank/utilities/loading.dart';
import 'package:bank/utilities/properties.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepositService extends ChangeNotifier {
  double amountToDeposit = 0;

  void setAmountToDeposit(double amount) {
    amountToDeposit = amount;
    notifyListeners();
  }

  void resetDepositService() {
    amountToDeposit = 0;
    notifyListeners();
  }

  bool checkAmountToDeposit() {
    return amountToDeposit > 0;
  }
}

class BankDeposit extends StatelessWidget {
  const BankDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Properties.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Properties.mainColor),
        backgroundColor: Colors.transparent,
        title: const Icon(Icons.savings, size: 40),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AccountActionHeader(headerTitle: 'Deposit', icon: Icons.login),
            Expanded(child: AccountActionSelection(actionTypeLabel: 'To')),
          ],
        ),
      ),
    );
  }
}

class AccountActionHeader extends StatelessWidget {
  final String? headerTitle;
  final IconData? icon;

  const AccountActionHeader({super.key, this.headerTitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: Properties.mainColor, size: 30),
          const SizedBox(width: 10),
          Text(
            headerTitle!,
            style: TextStyle(color: Properties.mainColor, fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class AccountActionSelection extends StatelessWidget {
  final String? actionTypeLabel;
  const AccountActionSelection({super.key, this.actionTypeLabel});

  @override
  Widget build(BuildContext context) {
    return Consumer<BankService>(
      builder: (context, service, child) {
        return FutureBuilder(
          future: service.getAccounts(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            }
            if (snapshot.hasError) {
              return Error();
            }
            var selectedAccount = service.getSelectedAccount();
            List<Account> accounts = snapshot.data as List<Account>;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actionTypeLabel!,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(height: 10),
                AccountActionCard(
                  selectedAccount: selectedAccount,
                  accounts: accounts,
                ),
                Expanded(
                  child: Visibility(
                    visible: selectedAccount != null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            'Current Balance',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.monetization_on,
                              color: Properties.mainColor,
                              size: 20,
                            ),
                            Text(
                              selectedAccount != null
                                  ? '\$' +
                                      selectedAccount.balance!.toStringAsFixed(
                                        2,
                                      )
                                  : '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.warning_outlined, color: Colors.red, size: 80),
          SizedBox(height: 20),
          Text(
            'Error fetching data',
            style: TextStyle(color: Properties.mainColor, fontSize: 20),
          ),
          Text(
            'Please try again',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class AccountActionCard extends StatelessWidget {
  final List<Account>? accounts;
  final Account? selectedAccount;
  const AccountActionCard({super.key, this.accounts, this.selectedAccount});

  @override
  Widget build(BuildContext context) {
    BankService bankService = Provider.of<BankService>(context, listen: false);
    return Row(
      children: List.generate(accounts!.length, (index) {
        var currentAccount = accounts![index];

        return Expanded(
          child: GestureDetector(
            onTap: () {
              bankService.setSelectedAccount(currentAccount);
            },
            child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
                border: Border.all(
                  width: 5,
                  color:
                      selectedAccount != null &&
                              selectedAccount!.id == currentAccount.id
                          ? Properties.mainColor
                          : Colors.transparent,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentAccount.type!.toUpperCase()} ACCT',
                    style: TextStyle(color: Properties.mainColor),
                  ),
                  Text(currentAccount.accountNumber!),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class AccountDepositSlider extends StatelessWidget {
  const AccountDepositSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DepositService>(
      builder: (context, depositService, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        );
      },
    );
  }
}
