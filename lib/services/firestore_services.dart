import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  /// Instances
  static late UserModel currentUser;
  DocumentSnapshot? lastDocument;
  static final fireStore = FirebaseFirestore.instance;

  /// variables
  bool hasMore = false;
  static String currentUserUid = AppStorage.getUid();

  /// Method to add new user to firestore
  static Future<void> addUserToFirestore({required UserModel newUser}) async {
    // final user = AppSrorage.getUser();
    // final newUser = UserModel(
    //   uid: user['uid'] ?? "",
    //   name: user['name'] ?? "",
    //   email: user['email'] ?? "",
    //   profileUrl: user['photoUrl'] ?? "",
    // );
    // Add the new note to Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(newUser.uid)
        .set(newUser.toJson());
  }

  /// method to Delete the user from firestore users collection
  static Future<void> deleteUserFromFirestore() async {
    await fireStore.collection('users').doc(AppStorage.getUid()).delete();
  }

  /// method to get user from firestore based on uid
  static Future<UserModel?> getUser({required String uid}) async {
    try {
      final doc = await fireStore.collection('users').doc(uid).get();
      if (doc.exists) {
        if (uid == currentUserUid) {
          currentUser = UserModel.fromJson(doc.data()!);
          return null;
        } else {
          return UserModel.fromJson(doc.data()!);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
    }
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
