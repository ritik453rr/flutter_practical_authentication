import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var isSignedIn = false.obs;
  var user = Rx<User?>(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Google Sign-In method
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }

      // Obtain the authentication details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Update user state
      user.value = userCredential.user;
      isSignedIn.value = true;

      print("Signed in as ${user.value?.displayName}");
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }

  // Sign-out method
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    isSignedIn.value = false;
    user.value = null;
  }

}