import 'package:authentication_ptcl/views/home/model/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
   DocumentSnapshot? lastDocument;
   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
   bool hasMore = false;

  /// Fetch initial data from Firestore
   Future<List<NoteModel>?> fetchInitialData({int size = 5}) async {
    try {
      Query query = fireStore
          .collection('notes')
          .orderBy('createdAt', descending: true)
          .limit(size);

      QuerySnapshot querySnapshot = await query.get();
      hasMore = querySnapshot.docs.length == 5;

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        final initialNotes = querySnapshot.docs
            .map(
              (doc) => NoteModel.fromJson(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ),
            )
            .toList();
        return initialNotes;
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching initial data: $e");
      return null;
    }
  }

   Future<List<NoteModel>?> fetchMoreData() async {
    try {
      if (!hasMore || lastDocument == null) return null;
      Query query = fireStore
          .collection('notes')
          .orderBy('createdAt', descending: true)
          .limit(5)
          .startAfterDocument(lastDocument!);

      QuerySnapshot querySnapshot = await query.get();
      hasMore = querySnapshot.docs.length == 5;
      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        final newNotes = querySnapshot.docs
            .map(
              (doc) => NoteModel.fromJson(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ),
            )
            .toList();
        return newNotes;
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching more data: $e");
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
