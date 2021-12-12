import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:readmate_app/core/models/user.dart';
import 'package:readmate_app/core/services/account_service.dart';

class AccountProvider extends ChangeNotifier {
  Future<bool> signIn() async {
    return await AccountService.signInWithGoogle();
  }

  Future<bool> signOut() async {
    return await AccountService.signOut();
  }

  User? get user {
    firebase.User? firebaseUser = AccountService.getUser();

    if (firebaseUser == null) {
      return null;
    } else {
      return User(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName!,
        email: firebaseUser.email!,
        photoUrl: firebaseUser.photoURL!,
      );
    }
  }
}

AccountProvider accountProvider = AccountProvider();
