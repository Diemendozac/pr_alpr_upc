
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pr_alpr_upc/src/utils/template_alert_constants.dart';

//Google Sign-In Code

class AuthService {

  AuthService._();

  static AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TemplateAlerts templateAlerts = TemplateAlerts.instance;

  Future<void> handleSignIn(BuildContext context) async {

    try{
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser != null) {
        if(!googleUser.email.endsWith('unicesar.edu.co')){
          handleSignOut();
          if(context.mounted) Navigator.pushNamed(context, 'alert', arguments: templateAlerts.notAllowedAcountError );
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