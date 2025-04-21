import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/pages/home/model/note_model.dart';
import 'package:authentication_ptcl/pages/home/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  DocumentSnapshot? lastDocument;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool hasMore = false;

  /// Method to add new user to firestore
  Future<void> addUserToFirestore() async {
    final user = AppSrorage.getUser();
    final newUser = UserModel(
      uid: user['uid'] ?? "",
      userName: user['name'] ?? "",
      email: user['email'] ?? "",
      profilePicture: user['photoUrl'] ?? "",
    );

    // Add the new note to Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user['uid'])
        .set(newUser.toJson());
  }

  

  /// Fetch requests for the current user
  // static Future<List<RequestModel>?> loadRequests() async {
  //   try {
  //     final querySnapshot =
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(AppStorage().getFirebaseUUiD())
  //             .collection('requests')
  //             .get();

  //     return querySnapshot.docs.map((doc) {
  //       return RequestModel.fromJson(doc.data());
  //     }).toList();
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load requests: $e');
  //   }
  // }

  /// Delete a request by its ID
  // static Future<bool>deleteRequest({required String requestId}) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(AppStorage().getFirebaseUUiD())
  //         .collection('requests')
  //         .doc(requestId)
  //         .delete();
  //     return true;
  //   } catch (e) {
  //     debugPrint('Error deleting request: $e');
  //     return false;
  //   }
  // }

  /// Accept a friend request
  // static Future<bool>acceptRequest({ required RequestModel request})async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(AppStorage().getFirebaseUUiD())
  //         .collection('friends')
  //         .doc(request.senderId) // Assuming senderId is the friend's UID
  //         .set(FriendModel(
  //       name: request.senderName,
  //       uid: request.senderId,
  //       imageUrl: '',
  //     ).toJson());
  //     return true;
  //   } catch (e) {
  //     debugPrint('Error accepting request: $e');
  //     return false;
  //   }
  // }
}
