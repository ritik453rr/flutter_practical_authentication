import 'package:authentication_ptcl/bottomsheet/add_bottomsheet.dart';
import 'package:authentication_ptcl/dialog/adaptive_dialog.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/services/firebase_services.dart';
import 'package:authentication_ptcl/views/home/model/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  var scrollController = ScrollController();

  var isLoading = true.obs;
  var isFetchingMore = false.obs;
  DocumentSnapshot? lastDocument;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Observable list of notes
  final notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsersWithPagination();
    addListenersToScrollController();
  }

  @override
  void onClose() {
    titleController.dispose();
    subtitleController.dispose();
    super.onClose();
  }

  /// Fetch users from Firestore with pagination
  Future<void> fetchUsersWithPagination({bool isNextPage = false}) async {
    try {
      if (isNextPage) {
        isFetchingMore.value = true;
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
        fetchUsersWithPagination(isNextPage: true);
      }
    });
  }

  /// Show the bottom sheet for adding a new note
  void addNote() {
    AddNoteBottomsheet()
        .showSheet(
            onTapButton: () async {
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

                // Add the new note to Firestore
                await FirebaseFirestore.instance
                    .collection('notes')
                    .doc(newNote.id)
                    .set(newNote.toJson());
                // Add the new note to the local list at the beginning
                notes.insert(0, newNote);
              } catch (e) {
                Get.snackbar("Error", "Failed to add note");
                debugPrint("Error adding note: $e");
              }
            },
            titleController: titleController,
            subtitleController: subtitleController)
        .whenComplete(() {
      titleController.clear();
      subtitleController.clear();
    });
  }

  /// Delete a note from Firestore on id base
  void deleteNote({required String noteId}) async {
    AdaptiveDialog.showDialog(
      title: "Delete Note",
      content: "Are you sure to delete note?",
      onPressedYes: () async {
        try {
          Get.back(); // Close the dialog
          await FirebaseFirestore.instance
              .collection('notes')
              .doc(noteId)
              .delete();
          // Remove the note from the local list
          notes.removeWhere((note) => note.id == noteId);
        } catch (e) {
          Get.back();
          Get.snackbar("Error", "Failed to delete note");
          debugPrint("Error deleting note: $e");
        }
      },
    );
  }

  /// Show a bottom sheet to update an existing note
  void updateNote({required NoteModel note}) {
    titleController.text = note.title;
    subtitleController.text = note.subtitle;
    // show
    AddNoteBottomsheet()
        .showSheet(
            titleController: titleController,
            subtitleController: subtitleController,
            isUpdation: true,
            onTapButton: () async {
              try {
                // Validate that the title is not empty
                if (titleController.text.isEmpty) {
                  Get.snackbar("Error", "Title cannot be empty");
                  return;
                }
                Get.back();
                // Create an updated note object
                final updatedNote = NoteModel(
                  id: note.id,
                  title: titleController.text,
                  subtitle: subtitleController.text,
                  createdAt: DateTime.now().toString(),
                );

                // Update the note in Firestore
                await FirebaseFirestore.instance
                    .collection('notes')
                    .doc(note.id)
                    .update(updatedNote.toJson());

                // Update the local list of notes
                final index = notes.indexWhere((item) => item.id == note.id);
                if (index != -1) {
                  notes[0] = updatedNote;
                }
              } catch (e) {
                // Handle errors and show a snackbar
                Get.snackbar("Error", "Failed to update note");
                debugPrint("Error updating note: $e");
              }
            })
        .whenComplete(() {
      titleController.clear();
      subtitleController.clear();
    });
  }

  /// Logout the user from the app
  void logout() {
    AdaptiveDialog.showDialog(
      title: "Logout",
      content: "Are you sure you want to logout?",
      onPressedYes: () async {
        Get.back(); // Close the dialog
        await FirebaseServices.signOut();
        Get.offNamed(AppRoutes.login);
      },
    );
  }

  //Fetch All notes at once from Firestore (with real-time updates)
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
}
