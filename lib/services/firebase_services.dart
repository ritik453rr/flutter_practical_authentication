import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/model/user_model.dart';
import 'package:authentication_ptcl/services/firestore_services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Firebase Services class to handle authentication and user state
class FirebaseServices {
  static User? user;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final firebaseAnalytics = FirebaseAnalytics.instance;
  static var isSigning = false.obs;

  /// init firebase method
  static Future<void> initFirebase() async {
    try {
      await Firebase.initializeApp();
      firebaseAnalytics.setAnalyticsCollectionEnabled(true);
      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);
    } catch (e) {
      debugPrint("Error initializing Firebase: $e");
    }
  }

  /// Google Sign-In method
  static Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return false; // User canceled the sign-in
      isSigning.value = true;
      // Obtain the authentication details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      // Update user state
      user = userCredential.user;
      AppStorage.setUid(val: user?.uid ?? "");
      await FirestoreServices.addUserToFirestore(
          newUser: UserModel(
        uid: user?.uid ?? "",
        name: user?.displayName ?? "",
        email: user?.email ?? "",
        profileUrl: user?.photoURL ?? "",
      ));
      return true;
    } catch (e) {
      isSigning.value = false;
      debugPrint("Error signing in with Google: $e");
      return false;
    }
  }

  // Sign-out method
  static Future<void> signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
    AppStorage.clear();
  }

  ///  Delete Account method
  static Future<void> deleteAccount() async {
    try {
      await auth.currentUser?.delete();
      await googleSignIn.signOut();
    } catch (e) {
      debugPrint("Error deleting account: $e");
    }
  }
}
