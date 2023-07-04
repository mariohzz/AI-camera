import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:python_project/auth/auth.dart';

class UserDatabase {

  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference _usersCollection_results = FirebaseFirestore.instance.collection('results');
  final Reference _storageRef = FirebaseStorage.instance.ref().child('videos');
  Auth userAuth;
  get get_userCollection => this._usersCollection;
  UserDatabase(this.userAuth);
  CollectionReference get_users_collection(){
    return this._usersCollection;
  }
  //late final DocumentReference newUserRef;
  Future<void> createUser(String email, String password,String name,String city,String clinic) async {
    try {
      String? userId = userAuth.getCurrentUserId();
      if (userId != null) {
        // Create a document reference with the user ID
        DocumentReference userRef = _usersCollection.doc(userId);

        // Set the document data with the user information
        await userRef.set({
          'email': email,
          'password': password,
          'name':name,
          'city':city,
          'clinic':clinic,
          'photo':'',
          // additional fields if needed
        });

        print('User created successfully! ID: $userId');
      } else {
        print('No authenticated user.');
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<String> uploadPhoto(File? photoFile) async {
    try {
      String? userId = userAuth.getCurrentUserId();
      if (userId != null) {
        // Upload the photo to Firebase Storage
        String photoPath =
            'photos/${DateTime.now().millisecondsSinceEpoch}.jpg';
        TaskSnapshot photoSnapshot =
        await _storageRef.child(photoPath).putFile(photoFile!);

        // Retrieve the download URL of the uploaded photo
        String photoDownloadUrl = await photoSnapshot.ref.getDownloadURL();

        // Update the photo URL in the user document
        await _usersCollection.doc(userId).update({'photo': photoDownloadUrl});

        return photoDownloadUrl;
      } else {
        print('No authenticated user.');
        return '';
      }
    } catch (e) {
      print('Error uploading photo: $e');
      return '';
    }
  }


  Future<void> saveResult(String result, File videoFile) async {
    try {
      String? userId = userAuth.getCurrentUserId();
      if (userId != null) {
        // Create a reference to the "results" subcollection for the user
        CollectionReference resultsCollection = _usersCollection.doc(userId).collection('results');

        // Upload the video to Firebase Storage
        String videoPath = 'videos/${DateTime.now().millisecondsSinceEpoch}.mp4';
        TaskSnapshot videoSnapshot = await _storageRef.child(videoPath).putFile(videoFile);

        // Retrieve the download URL of the uploaded video
        String videoDownloadUrl = await videoSnapshot.ref.getDownloadURL();

        // Save the result and the associated video URL in a new document
        DocumentReference resultDocRef = await resultsCollection.add({
          'result': result,
          'videoUrl': videoDownloadUrl,
          // additional fields if needed
        });

        print('Result saved successfully! Document ID: ${resultDocRef.id}');
      } else {
        print('No authenticated user.');
      }
    } catch (e) {
      print('Error saving result: $e');
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






// Future<void> saveBabinski(String babinski) async {
//     try {
//       await _usersCollection_results.add({
//         'babinski': babinski,
//         // additional fields if needed
//       });
//       print('User created successfully!');
//     } catch (e) {
//       print('Error creating user: $e');
//     }
//   }
//   Future<void> saveRooting(String rooting) async {
//     try {
//       await _usersCollection_results.add({
//         'rooting': rooting,
//         // additional fields if needed
//       });
//       print('User created successfully!');
//     } catch (e) {
//       print('Error creating user: $e');
//     }
//   }
//   Future<void> saveGrasp(String grasp) async {
//     try {
//       await _usersCollection_results.add({
//         'grasp': grasp,
//         // additional fields if needed
//       });
//       print('User created successfully!');
//     } catch (e) {
//       print('Error creating user: $e');
//     }
//   }
//   Future<void> savetonicNeck(String tonicNeck) async {
//     try {
//       await _usersCollection_results.add({
//         'tonicneck': tonicNeck,
//         // additional fields if needed
//       });
//       print('User created successfully!');
//     } catch (e) {
//       print('Error creating user: $e');
//     }
//   }



