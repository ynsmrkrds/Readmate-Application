import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/* this service class provides methods 
  for authenticating users. it uses 
  firebase authentication. */

class AccountService {
  // instance of firebase auth
  static final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;

  // authenticates users with their google account
  static Future<bool> signInWithGoogle() async {
    bool isSuccess = false;

    // signs in with account that choosen by user and gets user's basic account informations
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // if any account selected
    if (googleUser != null) {
      // gets the account auth details
      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // creates a new credential for firebase authentication
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      try {
        // if user is not exist in firebase, creates; else, signs in
        await _firebaseAuthInstance.signInWithCredential(credential);

        isSuccess = true;
      } catch (e) {
        isSuccess = false;
      }
    }

    return isSuccess;
  }

  // provides users to sign out of their accounts
  static Future<bool> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _firebaseAuthInstance.signOut();

      return true;
    } catch (e) {
      return false;
    }
  }

  // returns current user
  static User? getUser() {
    return _firebaseAuthInstance.currentUser;
  }
}
