import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUserService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUserInFirestore(User user, {String? name}) async {
    try {
      await usersCollection.doc(user.uid).set({
        'name': name ?? user.displayName ?? 'No name provided',
        'email': user.email ?? 'No email provided',
        'uid': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save user to Firestore: $e');
    }
  }
}
