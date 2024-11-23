import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(MingCute.left_line, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 35,
        titleSpacing: 10,
        backgroundColor: AppColors.primary,
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('Notifications will go here'),
      ),
    );
  }
}
