import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  static var user = Rx<User?>(null);

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Google Sign-In method
  static Future<void> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }

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
      user.value = userCredential.user;
      AppSrorage.setvalue(AppSrorage.isLogin, true);

      print("Signed in as ${user.value?.displayName}");
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }

  // Sign-out method
  static Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    AppSrorage.setvalue(AppSrorage.isLogin, false);
    user.value = null;
  }
}
