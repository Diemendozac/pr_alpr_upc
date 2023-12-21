
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';
import 'package:pr_alpr_upc/src/utils/template_alert_constants.dart';

class AuthService {

  AuthService._();

  static AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TemplateAlerts templateAlerts = TemplateAlerts.instance;
  final UserService userService = UserService();

  Future<void> handleSignIn(BuildContext context) async {

    try{
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser != null) {
        if(!googleUser.email.endsWith('unicesar.edu.co')){
          handleSignOut();
          if(context.mounted) Navigator.pushNamed(context, 'alert', arguments: templateAlerts.notAllowedAcountError );
          return;
        }

        bool test = await userService.saveUser(
          googleUser.email,
          googleUser.id,
          googleUser.displayName!,
          googleUser.photoUrl
        );
        print(test);

      }
    } catch (e) {
      print('Error sign in with Google $e');
    } finally {
      handleSignOut();
    }

  }

  Future<void> handleLogIn(BuildContext context) async {

    try{
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();


      if(googleUser != null) {
        if(!googleUser.email.endsWith('unicesar.edu.co')){
          handleSignOut();
          if(context.mounted) Navigator.pushNamed(context, 'alert', arguments: templateAlerts.notAllowedAcountError );
          return;
        }

        await userService.loginUser(
            googleUser.email,
            googleUser.id,
        );

      }
    } catch (e) {
      print('Error sign in with Google $e');
    } finally {
      handleSignOut();
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