import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:python_project/auth/auth.dart';
import 'package:path/path.dart';
class UserDatabase {

  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  //final CollectionReference _usersCollection_results = FirebaseFirestore.instance.collection('results');
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
  Future<Map<String, String>> getUser() async {
    String? userId = userAuth.getCurrentUserId();
    try {
      DocumentSnapshot snapshot = await _usersCollection.doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        // Access the fields of the user
        String city = data['city'];
        String clinic = data['clinic'];
        String name = data['name'];
        // Return the city, clinic, and name as a map
        return {
          'city': city,
          'clinic': clinic,
          'name': name,
        };
      } else {
        print('User not found!');
        return {};
      }
    } catch (e) {
      print('Error retrieving user: $e');
      return {};
    }
  }

  Future<String> getUserName() async {
    String? userId = userAuth.getCurrentUserId();
    try {
      DocumentSnapshot snapshot = await _usersCollection.doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        // Access the name field of the user
        String name = data['name'];
        return name;
      } else {
        print('User not found!');
        return '';
      }
    } catch (e) {
      print('Error retrieving user: $e');
      return '';
    }
  }

  Future<Map<String, String>> getUserById() async {
    String? userId = userAuth.getCurrentUserId();
    try {
      DocumentSnapshot snapshot = await _usersCollection.doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        // Access the fields of the user
        String city = data['city'];
        String clinic = data['clinic'];

        // Return the city name and clinic name as a map
        return {
          'city': city,
          'clinic': clinic,
        };
      } else {
        print('User not found!');
        return {};
      }
    } catch (e) {
      print('Error retrieving user: $e');
      return {};
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
  Future<void> updateEmail(String newEmail) async {
    try {
      String? userId = userAuth.getCurrentUserId();
      await _usersCollection.doc(userId).update({
        'email': newEmail,
      });
      print('Email updated successfully!');
    } catch (e) {
      print('Error updating email: $e');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      String? userId = userAuth.getCurrentUserId();
      await _usersCollection.doc(userId).update({
        'password': newPassword,
      });
      print('Password updated successfully!');
    } catch (e) {
      print('Error updating password: $e');
    }
  }

  Future<void> updateName(String newName) async {
    try {
      String? userId = userAuth.getCurrentUserId();
      await _usersCollection.doc(userId).update({
        'name': newName,
      });
      print('Name updated successfully!');
    } catch (e) {
      print('Error updating name: $e');
    }
  }

  Future<void> updateCity(String newCity) async {
    try {
      String? userId = userAuth.getCurrentUserId();
      await _usersCollection.doc(userId).update({
        'city': newCity,
      });
      print('City updated successfully!');
    } catch (e) {
      print('Error updating city: $e');
    }
  }

  Future<void> updateClinic(String newClinic) async {
    try {
      String? userId = userAuth.getCurrentUserId();
      await _usersCollection.doc(userId).update({
        'clinic': newClinic,
      });
      print('Clinic updated successfully!');
    } catch (e) {
      print('Error updating clinic: $e');
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

  Future<void> saveGraphAndImage(
      String closestGraph, File plotImageFile, double ageInWeeks, double weight) async {
    try {
      String? userId = userAuth.getCurrentUserId();
      if (userId != null) {
        // Create a reference to the "test" collection for the user
        CollectionReference testCollection =
        _usersCollection.doc(userId).collection('test');

        // Upload the plot image to Firebase Storage
        String imageName = basename(plotImageFile.path);
        TaskSnapshot imageSnapshot = await _storageRef
            .child('images/$imageName')
            .putFile(plotImageFile);

        // Retrieve the download URL of the uploaded image
        String imageUrl = await imageSnapshot.ref.getDownloadURL();

        // Save the closest graph, age in weeks, weight, and the associated image URL in a new document
        DocumentReference graphAndImageDocRef = await testCollection.add({
          'closestGraph': closestGraph,
          'imageUrl': imageUrl,
          'ageInWeeks': ageInWeeks,
          'weight': weight,
        });

        print(
            'Graph, image, age, and weight saved successfully! Document ID: ${graphAndImageDocRef.id}');
      } else {
        print('No authenticated user.');
      }
    } catch (e) {
      print('Error saving graph, image, age, and weight: $e');
    }
  }



  // Future<void> getUserById(String userId) async {
  //   try {
  //     DocumentSnapshot snapshot = await _usersCollection.doc(userId).get();
  //     if (snapshot.exists) {
  //       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //       print('User Name: ${data['name']}');
  //       print('User Email: ${data['email']}');
  //     } else {
  //       print('User not found!');
  //     }
  //   } catch (e) {
  //     print('Error retrieving user: $e');
  //   }
  // }

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



