import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';
import 'package:rider/models/user.dart' as model;

class AccountScreen extends StatelessWidget {
  final model.User user;

  const AccountScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        appBar: AppBar(
        title: Text('Account'),
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: true,
      ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                user.name,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                user.email,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                user.location ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                DateFormat("MMMM d, y").format(DateTime.tryParse(user
                                              ?.joiningDate!
                                              .toIso8601String() ??
                                          '')
                                      ?.toLocal() ??
                                  DateTime(0)) ==
                              "December 30, 1899"
                          ? "History unavailable"
                          : DateFormat("MMMM d, y").format(DateTime.tryParse(
                                      user?.joiningDate!.toIso8601String() ??
                                          '')
                                  ?.toLocal() ??
                              DateTime.now()),
                style: const TextStyle(fontSize: 16),
              ),
              
              user.email == FirebaseAuth.instance.currentUser!.email ?

              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text(
                  'Logout',
                  style: const TextStyle(fontSize: 16, color: Colors.yellow),
                ),
              ) : Container()
            ],
          ),
        ));
  }
}
