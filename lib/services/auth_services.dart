import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('user').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }
  
  Future<String>signUpUser({required String name, required String email, required String password, required String username, Uint8List? file}) async {
    String res = "Random error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        
        model.User user = model.User(
          name: name,
          username: username,
          uid: cred.user!.uid,
          email: email,
          photoUrl: null,
          location: null,
          seller: false,
          joiningDate: DateTime.now(),
        );

        print(cred.user?.displayName);

        await _firestore.collection('user').doc(cred.user!.uid).set(user.toJson());
        
        res = 'success';
      } else {
        res = 'Please fill the form';
      }
    } catch(e) {
      print(e.toString());
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({required String email, required String password}) async {
    String res = 'Random error occurred.';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        res = 'success';
      } else {
        res = 'Please enter all the fields.';
      }
    } catch(e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> checkAndAddUsername(String username) async {
    String res = 'Random error occurred.';

    try {
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('username', isEqualTo: username)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isEmpty) {
        res = 'success';
      } else if (documents.first.id == _auth.currentUser!.uid) {
        res = 'success';
      } else {
        'Username already taken. Please choose another.';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
