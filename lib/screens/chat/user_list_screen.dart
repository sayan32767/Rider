import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';
import 'chat_screen.dart';

class UsersListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: Text('Users Available'),
        backgroundColor: AppColors.primary
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').where('seller', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primary
              ),
            );
          }

          final users = snapshot.data!.docs;
          List<ListTile> userTiles = [];

          for (var user in users) {
            final username = user['username'];
            final email = user['email'];

            if (email == FirebaseAuth.instance.currentUser?.email) continue;

            userTiles.add(
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(username, style: TextStyle(fontSize: 18.0)),
                subtitle: Text(email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        recipientEmail: email,
                        recipientUsername: username,
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return ListView(
            children: userTiles,
          );
        },
      ),
    );
  }
}
