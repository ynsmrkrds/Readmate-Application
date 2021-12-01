import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  static Future<bool> signInWithGoogle() async {
    bool isSuccess = false;

    // signs in with account that choosen by user and gets user's basic account informations
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // if any account selected
    if (googleUser != null) {
      // gets the account auth details
      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // creates a new credential for firebase authentication
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      try {
        // if user is not exist in firebase, creates; else, signs in
        //final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

        isSuccess = true;
      } catch (e) {
        isSuccess = false;
      }
    }

    return isSuccess;
  }

  // returns information of user that signed in
  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<bool> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      return true;
    } catch (e) {
      return false;
    }
  }
}
