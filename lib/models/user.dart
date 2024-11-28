import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String uid;
  final String? photoUrl;
  final String username;
  final bool? seller;
  final String? location;
  final DateTime? joiningDate;
  final double? rating;

  const User({
    required this.name,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    this.seller,
    this.location,
    this.joiningDate,
    this.rating,
  });

  Map<String, dynamic> toJson() => {
      "name": name,
      "username": username,
      "uid": uid,
      "email": email,
      "photoUrl": photoUrl,
      "seller": seller,
      "location": location,
      "joiningDate": joiningDate?.toIso8601String(),
      "rating": rating,
    };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot["name"],
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      seller: snapshot['seller'] ?? false,
      location: snapshot['location'],
      joiningDate: snapshot['joiningDate'] != null
          ? DateTime.parse(snapshot['joiningDate'])
          : null,
      rating: snapshot['rating']?.toDouble(),
    );
  }
}
