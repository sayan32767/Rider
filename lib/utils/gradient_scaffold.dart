import 'package:flutter/material.dart';
import 'package:rider/utils/colors.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? bottomNavigationBar;

  const GradientScaffold({Key? key, required this.body, this.appBar, this.bottomNavigationBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 58, 11, 55),
            Color.fromARGB(255, 7, 30, 49)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
