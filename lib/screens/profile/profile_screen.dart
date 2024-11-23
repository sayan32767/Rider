import 'package:flutter/material.dart';
import 'package:rider/utils/gradient_scaffold.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: Text(
          'Account Screen'
        ),
      ),
    );
  }
}
