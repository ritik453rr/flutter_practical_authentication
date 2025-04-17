import 'package:authentication_ptcl/bottomsheet/add_bottomsheet.dart';
import 'package:authentication_ptcl/dialog/adaptive_dialog.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/services/firebase_services.dart';
import 'package:authentication_ptcl/services/firestore_services.dart';
import 'package:authentication_ptcl/views/home/model/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  var scrollController = ScrollController();
  var fireStoreService = FirestoreServices();

  var isFetchingMore = false.obs;
  var isLoading = true.obs;
  var pageSize = 5;
  
  final notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
    addListenersToScrollController();
  }

  @override
  void onClose() {
    titleController.dispose();
    subtitleController.dispose();
    super.onClose();
  }

  /// Fetch initial data from Firestore home change
  Future<void> fetchInitialData() async {
    final value = await fireStoreService.fetchHomeData(size: pageSize);
    if (value != null) {
      notes.assignAll(value);
      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  /// Fetch more data from Firestore for pagination
  Future<void> fetchMoreData() async {
    if (isFetchingMore.value) return;
    print("Called");
    isFetchingMore.value = true;
    final value = await fireStoreService.fetchMoreHomeData(size: pageSize);
    if (value != null) {
      notes.addAll(value);
    }
    isFetchingMore.value = false;
  }

  /// Add listeners to the scroll controller and page controller
  void addListenersToScrollController() {
    scrollController.addListener(() {
      //check first hasmore or not
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 150 &&fireStoreService.hasMore) {
        
          fetchMoreData();
        
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
                Get.back();
                // Close the bottom sheet
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
    AddNoteBottomsheet()
        .showSheet(
            titleController: titleController,
            subtitleController: subtitleController,
            isUpdation: true,
            onTapButton: () async {
              try {
                if (titleController.text.isEmpty) {
                  Get.snackbar("Error", "Title cannot be empty");
                  return;
                }
                Get.back();
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
}
