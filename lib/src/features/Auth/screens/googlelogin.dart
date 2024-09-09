import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/User.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add a user to Firestore
  Future<void> addUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
      print('User added successfully: ${user.uid}');
    } catch (e) {
      print('Error adding user: $e');
      throw e;
    }
  }

  // Method to get all users from Firestore
  Future<List<User>> getAllUsers() async {
    List<User> users = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collection('users').get();

      querySnapshot.docs.forEach((doc) {
        users.add(User.fromMap(doc.data()));
      });

      return users;
    } catch (e) {
      print('Error getting users: $e');
      throw e;
    }
  }
}
