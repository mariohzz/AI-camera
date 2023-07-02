import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:python_project/auth/auth.dart';

class UserDatabase {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference _usersCollection_results = FirebaseFirestore.instance.collection('results');
  final Reference storageRef = FirebaseStorage.instance.ref().child('videos');
  Auth userAuth;
  UserDatabase(this.userAuth);

  //late final DocumentReference newUserRef;
  Future<void> createUser(String email, String password) async {
    try {
      DocumentReference newUserRef = await _usersCollection.add({
        'email': email,
        'password': password,
        // additional fields if needed
      });
      // Retrieve the user ID
      String? userId = userAuth.getCurrentUserId();
      print('User created successfully! ID: $userId');
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<void> saveResult(String userId, String result) async {
    try {
      // Create a reference to the "results" subcollection for the user
      CollectionReference resultsCollection =
      _usersCollection.doc(userId).collection('results');

      await resultsCollection.add({
        'result': result,
        // additional fields if needed
      });

      print('Result saved successfully!');
    } catch (e) {
      print('Error saving result: $e');
    }
  }





  Future<void> saveBabinski(String babinski) async {
    try {
      await _usersCollection_results.add({
        'babinski': babinski,
        // additional fields if needed
      });
      print('User created successfully!');
    } catch (e) {
      print('Error creating user: $e');
    }
  }
  Future<void> saveRooting(String rooting) async {
    try {
      await _usersCollection_results.add({
        'rooting': rooting,
        // additional fields if needed
      });
      print('User created successfully!');
    } catch (e) {
      print('Error creating user: $e');
    }
  }
  Future<void> saveGrasp(String grasp) async {
    try {
      await _usersCollection_results.add({
        'grasp': grasp,
        // additional fields if needed
      });
      print('User created successfully!');
    } catch (e) {
      print('Error creating user: $e');
    }
  }
  Future<void> savetonicNeck(String tonicNeck) async {
    try {
      await _usersCollection_results.add({
        'tonicneck': tonicNeck,
        // additional fields if needed
      });
      print('User created successfully!');
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<void> getUserById(String userId) async {
    try {
      DocumentSnapshot snapshot = await _usersCollection.doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        print('User Name: ${data['name']}');
        print('User Email: ${data['email']}');
      } else {
        print('User not found!');
      }
    } catch (e) {
      print('Error retrieving user: $e');
    }
  }

  Future<void> updateUser(String userId, String newName) async {
    try {
      await _usersCollection.doc(userId).update({
        'name': newName,
      });
      print('User updated successfully!');
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _usersCollection.doc(userId).delete();
      print('User deleted successfully!');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
