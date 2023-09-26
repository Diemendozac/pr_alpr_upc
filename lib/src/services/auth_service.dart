
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Google Sign-In Code

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> handleSignIn() async {

    try{
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser != null) {
        if(!googleUser.email.endsWith('unicesar.edu.co')){
          handleSignOut();
          return;
        }
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);

      }
    } catch (e) {
      print('Error sign in with Google $e');
    }

  }

  Future<void> handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch(e) {
      print('Error al salir: $e');
    }

  }


}