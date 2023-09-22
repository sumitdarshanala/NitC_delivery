// import 'dart:js_interop';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class GetProfile extends StatelessWidget{
//   const GetProfile({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//     return StreamBuilder(stream: FirebaseFirestore.instance
//         .collection('user_images/${user.email}')
//         .snapshots(), builder: (ctx,chatsnapshot){
//       if (chatsnapshot.connectionState == ConnectionState.waiting) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//       if (!chatsnapshot.hasData || chatsnapshot.data!.docs.isEmpty) {
//         return const Center(
//           child: Text('No message found.'),
//         );
//       }
//       if (chatsnapshot.hasError) {
//         return const Center(
//           child: Text('Something Went Wrong.'),
//         );
//       }
//       final loadImage = chatsnapshot.data!.docs;
//       print(loadImage);
//       return const CircleAvatar(radius:50);
//     });
//   }
// }