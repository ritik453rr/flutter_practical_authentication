import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Firebase Services class to handle authentication and user state
class FirebaseServices {
  static User? user;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static var isLoading = false.obs;

  /// Google Sign-In method
  static Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }
      isLoading.value = true;
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
          await _auth.signInWithCredential(credential);

      // Update user state
      user = userCredential.user;
      AppSrorage.setUserData(data: {
        "name": user?.displayName ?? "",
        "email": user?.email ?? "",
        "uid": user?.uid ?? "",
        "photoUrl": user?.photoURL ?? "",
      });
      isLoading.value = false;
      AppSrorage.setLoginStatus(true);
      debugPrint("Signed in as ${user?.displayName ?? ""}");
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Sign in failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint("Error signing in with Google: $e");
    }
  }

  // Sign-out method
  static Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    AppSrorage.clear();
  }
}
