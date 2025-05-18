import 'package:authentication_ptcl/bottomsheet/add_bottomsheet.dart';
import 'package:authentication_ptcl/dialog/adaptive_dialog.dart';
import 'package:authentication_ptcl/navigation/app_routes.dart';
import 'package:authentication_ptcl/services/firebase_services.dart';
import 'package:authentication_ptcl/pages/dashboard/home/model/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Controllers
  late TextEditingController titleController;
  late TextEditingController subtitleController;
  late ScrollController scrollController;
  late ScrollController bodyScrollController;
  late PageController? pageController;

  // Firebase
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument;

  // State Management
  var isFetchingMore = false.obs;
  var isLoading = true.obs;
  final notes = <NoteModel>[].obs;
  bool hasMore = false;
  final int pageSize = 5;

  // Collection reference

  @override
  void onInit() {
    super.onInit();
    initControllers();
    _addScrollListeners();
    fetchInitialData();
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  // Initialize controllers
  void initControllers() {
    titleController = TextEditingController();
    subtitleController = TextEditingController();
    scrollController = ScrollController();
    bodyScrollController = ScrollController();
    pageController = PageController(initialPage: 0, keepPage: true);
  }

  // Dispose controllers
  void _disposeControllers() {
    titleController.dispose();
    subtitleController.dispose();
    scrollController.dispose();
    bodyScrollController.dispose();
    pageController?.dispose();
  }

  // Add scroll listeners
  void _addScrollListeners() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 150 &&
          hasMore) {
        fetchMoreData();
      }
    });

    bodyScrollController.addListener(() {
      if (bodyScrollController.position.pixels >=
              bodyScrollController.position.maxScrollExtent - 150 &&
          hasMore) {
        fetchMoreData();
      }
    });
    pageController?.addListener(() {
      if (pageController?.position.pixels != null &&
          pageController!.position.pixels >=
              pageController!.position.maxScrollExtent - 150 &&
          hasMore) {
        fetchMoreData();
      }
    });
  }

  /// Fetch initial data from Firestore
  Future<void> fetchInitialData() async {
    try {
      final query = fireStore
          .collection('notes')
          .orderBy('createdAt', descending: true)
          .limit(pageSize);

      final querySnapshot = await query.get();
      hasMore = querySnapshot.docs.length == pageSize;

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        final initialNotes = querySnapshot.docs
            .map((doc) => NoteModel.fromJson(
                  doc.data(),
                  doc.id,
                ))
            .toList();
        notes.assignAll(initialNotes);
        if (scrollController.hasClients) {
          scrollController.jumpTo(0);
        }
        if (pageController?.hasClients == true) {
          pageController?.jumpTo(0);
        }
      }
    } catch (e) {
      debugPrint("Error in fetchInitialData: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Fetch more data for pagination
  Future<void> fetchMoreData() async {
    if (isFetchingMore.value || !hasMore || lastDocument == null) return;

    try {
      isFetchingMore(true);
      final query = fireStore
          .collection('notes')
          .orderBy('createdAt', descending: true)
          .limit(pageSize)
          .startAfterDocument(lastDocument!);

      final querySnapshot = await query.get();
      hasMore = querySnapshot.docs.length == pageSize;

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        final newNotes = querySnapshot.docs
            .map((doc) => NoteModel.fromJson(
                  doc.data(),
                  doc.id,
                ))
            .toList();
        notes.addAll(newNotes);
      }
    } catch (e) {
      debugPrint("Error in fetchMoreData: $e");
    } finally {
      isFetchingMore(false);
    }
  }

  /// Add a new note
  void addNote() {
    _showNoteBottomSheet(
      onSave: () async {
        if (!_validateTitle()) return;
        final newNote = _createNote();
        await _saveNoteToFirestore(newNote);
        notes.insert(0, newNote);
        Get.back();
      },
    );
  }

  /// Update existing note
  void updateNote({required NoteModel note}) {
    titleController.text = note.title;
    subtitleController.text = note.subtitle;

    _showNoteBottomSheet(
      isUpdate: true,
      onSave: () async {
        if (!_validateTitle()) return;

        final updatedNote = _createNote();
        await _updateNoteInFirestore(updatedNote);
        _updateLocalNote(updatedNote);
        Get.back();
      },
    );
  }

  // Show note bottom sheet
  void _showNoteBottomSheet(
      {required Function() onSave, bool isUpdate = false}) {
    AddNoteBottomsheet()
        .showSheet(
          titleController: titleController,
          subtitleController: subtitleController,
          isUpdation: isUpdate,
          onTapButton: () async {
            try {
              await onSave();
            } catch (e) {
              Get.snackbar(
                  "Error", "Failed to ${isUpdate ? 'update' : 'add'} note");
              debugPrint("Error ${isUpdate ? 'updating' : 'adding'} note: $e");
            }
          },
        )
        .whenComplete(_clearControllers);
  }

  // Validate title
  bool _validateTitle() {
    if (titleController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Title cannot be empty",
        margin: const EdgeInsets.all(10),
      );
      return false;
    }
    return true;
  }

  NoteModel _createNote() {
    return NoteModel(
      id:  DateTime.now().toString(),
      title: titleController.text,
      subtitle: subtitleController.text,
      createdAt: DateTime.now().toString(),
    );
  }

  // Save note to Firestore
  Future<void> _saveNoteToFirestore(NoteModel note) async {
    await fireStore.collection('notes').doc(note.id).set(note.toJson());
  }

  // Update note in Firestore
  Future<void> _updateNoteInFirestore(NoteModel note) async {
    await fireStore.collection('notes').doc(note.id).update(note.toJson());
  }

  // Update local note
  void _updateLocalNote(NoteModel note) {
    final index = notes.indexWhere((item) => item.id == note.id);
    if (index != -1) {
      notes[0] = note;
    }
  }

  void _clearControllers() {
    titleController.clear();
    subtitleController.clear();
  }

  /// Delete note
  void deleteNote({required String noteId}) {
    AdaptiveDialog.showDialog(
      title: "Delete Note",
      content: "Are you sure to delete note?",
      onPressedYes: () => _handleDelete(noteId),
    );
  }

  Future<void> _handleDelete(String noteId) async {
    try {
      Get.back();
      await fireStore.collection('notes').doc(noteId).delete();
      notes.removeWhere((note) => note.id == noteId);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Failed to delete note");
      debugPrint("Error deleting note: $e");
    }
  }

 
}
