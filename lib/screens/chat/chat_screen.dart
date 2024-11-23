import 'package:flutter/material.dart';
import 'package:rider/utils/gradient_scaffold.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: Text(
          'Chat Screen'
        ),
      ),
    );
  }
}
