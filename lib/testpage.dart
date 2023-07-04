// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:python_project/testwidget.dart';
// import 'package:python_project/userCreate.dart';
//
// import 'auth/auth.dart';
// List<DocumentSnapshot> _testResults = [];
// class TestPage extends StatelessWidget {
//   final UserDatabase userDatabase;
//   final Auth userAuth;
//   TestPage(this.userDatabase,this.userAuth);
//   Future<void> _loadUserData() async {
//     String? userId = userAuth.getCurrentUserId();
//     if (userId != null) {
//       QuerySnapshot resultSnapshot = await userDatabase.get_userCollection
//           .doc(userId)
//           .collection('results')
//           .get();
//
//       QuerySnapshot testSnapshot = await userDatabase.get_userCollection
//           .doc(userId)
//           .collection('test')
//           .get();
//
//       setState(() {
//         _currentUser = userAuth.currentuser;
//         this._testResults = testSnapshot.docs;
//       });
//     }
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Test Page'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('user')
//             .doc('userId')
//             .collection('test')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final documents = snapshot.data!.docs;
//             return ListView.builder(
//               itemCount: documents.length,
//               itemBuilder: (context, index) {
//                 final data = documents[index].data();
//                 final ageInWeeks = data['ageInWeeks'] as String?;
//                 final weight = data['weight'] as String?;
//                 final closestGraph = data['closestGraph'] as String?;
//                 final imageUrl = data['imageUrl'] as String?;
//
//                 return TestItemWidget(
//                   ageInWeeks: ageInWeeks?.toString(),
//                   weight: weight?.toString(),
//                   closestGraph: closestGraph?.toString(),
//                   imageUrl: imageUrl?.toString(),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
//
//
//
//
//
//
//
//
// }
