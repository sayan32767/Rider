import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VehicleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getLocation() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection('user').doc(_auth.currentUser!.uid).get();

      if (docSnapshot.exists) {
        var data = docSnapshot.data();
        if (data != null && data['location'] != null) {
          return data['location'] as String? ?? '';
        }
      }
      return '';
    } catch (_) {
      return '';
    }
  }

  Future<void> updateLocation(String location) async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .update({'location': location});
    } catch (_) {}
  }

  Future<DocumentSnapshot?> fetchSellerDetails(String sellerId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('user').doc(sellerId).get();

      if (userSnapshot.exists) {
        return userSnapshot;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
