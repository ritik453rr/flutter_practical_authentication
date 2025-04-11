import 'package:authentication_ptcl/bottomsheet/add_bottomsheet.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/services/firebase_services.dart';
import 'package:authentication_ptcl/views/home/model/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  var scrollController = ScrollController();
  final updateTitle = TextEditingController();
  final updateSubtitle = TextEditingController();

  var isPageLoading = false.obs;
  var isLoading = true.obs;
  var isFetchingMore = false.obs;
  DocumentSnapshot? lastDocument;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Observable list of notes
  final notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    addListenersToScrollController();
  }

  @override
  void onClose() {
    titleController.dispose();
    subtitleController.dispose();
    updateTitle.dispose();
    updateSubtitle.dispose();
    super.onClose();
  }

  /// Fetch users from Firestore with pagination
  Future<void> fetchUsers({bool isNextPage = false}) async {
    try {
      if (isNextPage) {
        isFetchingMore.value = true; 
      } else {
        isLoading.value = true; 
      }
      Query query = fireStore
          .collection('notes')
          .orderBy('createdAt', descending: true)
          .limit(5);

      if (isNextPage && lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;

        final newUsers = querySnapshot.docs
            .map(
              (doc) => NoteModel.fromJson(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ),
            )
            .toList();

        isNextPage ? notes.addAll(newUsers) : notes.assignAll(newUsers);
      }
    } catch (e) {
      debugPrint("Error fetching users: $e");
    } finally {
      if (isNextPage) {
        isFetchingMore(false);
      } else {
        isLoading(false);
      }
    }
  }

  /// Add listeners to the scroll controller and page controller
  void addListenersToScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isFetchingMore.value) {
        fetchUsers(isNextPage: true);
      }
    }); // Fetch initial data
  }

  /// Fetch notes from Firestore (with real-time updates)
  // void fetchAllNotes() {
  //   FirebaseFirestore.instance
  //       .collection('notes')
  //       .orderBy('createdAt', descending: true) // Newest first
  //       .snapshots()
  //       .listen(
  //     (snapshot) {
  //       // Efficient batch update using assignAll
  //       notes.assignAll(
  //         snapshot.docs.map((doc) => NoteModel.fromJson(doc.data(), doc.id)),
  //       );
  //     },
  //     onError: (e) {
  //       Get.snackbar("Error", "Failed to fetch notes");
  //       debugPrint("Error fetching notes: $e");
  //     },
  //   );
  // }

  /// Add a new noto to firestore set the note id to the document id
  Future<void> onTapAddNote() async {
    try {
      if (titleController.text.isEmpty) {
        Get.snackbar(
          "Error",
          "Title cannot be empty",
          margin: const EdgeInsets.all(10),
        );
        return;
      }
      Get.back(); // Close the bottom sheet
      final newNote = NoteModel(
        id: DateTime.now().toString(), // Generate a unique ID
        title: titleController.text,
        subtitle: subtitleController.text,
        createdAt: DateTime.now().toString(),
      );

      await FirebaseFirestore.instance
          .collection('notes')
          .doc(newNote.id)
          .set(newNote.toJson());

      titleController.clear();
      subtitleController.clear();
    } catch (e) {
      Get.snackbar("Error", "Failed to add note");
      print("Error adding note: $e");
    }
  }

  /// Delete a note from Firestore on id base
  void deleteNote(String id) async {
    try {
      await FirebaseFirestore.instance.collection('notes').doc(id).delete();

      // Remove the note from the local list
      notes.removeWhere((note) => note.id == id);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete note");
      print("Error deleting note: $e");
    }
  }

  /// Update an existing note
  void updateNote(String id) async {
    try {
      if (updateTitle.text.isEmpty) {
        Get.snackbar("Error", "Title cannot be empty");
        return;
      }

      final updatedNote = NoteModel(
        id: id,
        title: updateTitle.text,
        subtitle: updateSubtitle.text,
        createdAt: DateTime.now().toString(),
      );

      await FirebaseFirestore.instance
          .collection('notes')
          .doc(id)
          .update(updatedNote.toJson());

      // Update the local list
      final index = notes.indexWhere((note) => note.id == id);
      if (index != -1) {
        notes[index] = updatedNote;
      }

      // Clear fields and close the dialog
      updateTitle.clear();
      updateSubtitle.clear();
      Get.back();
    } catch (e) {
      Get.snackbar("Error", "Failed to update note");
      print("Error updating note: $e");
    }
  }

  void onTapLogout() {
    Get.defaultDialog(
      title: "Logout",
      content: const Text("Are you sure you want to logout?"),
      onConfirm: () async {
        Get.back();
        await FirebaseServices.signOut();
        Get.offNamed(AppRoutes.login);
      },
      onCancel: () {
        Get.back(); // Close the dialog
      },
    );
  }

  void onTapAddButton() {
    AddNoteBottomsheet().showSheet(
        onTapAdd: () async {
          await onTapAddNote();
        },
        titleController: titleController,
        subtitleController: subtitleController);
  }
}
