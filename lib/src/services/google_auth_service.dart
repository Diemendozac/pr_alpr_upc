
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pr_alpr_upc/src/providers/token_provider.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';
import 'package:pr_alpr_upc/src/utils/template_alert_constants.dart';

class GoogleAuthService {

  GoogleAuthService._();

  static GoogleAuthService instance = GoogleAuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: '718421263049-cukdqhhc8u34l5bb251jet8nql7aa7si.apps.googleusercontent.com');
  final TemplateAlerts templateAlerts = TemplateAlerts.instance;
  final UserService userService = UserService();
  final TokenProvider tokenProvider = TokenProvider();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> handleSignUp(BuildContext context) async {

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

  Future<bool> handleLogIn(BuildContext context) async {

    try{
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser != null) {
        if(!googleUser.email.endsWith('unicesar.edu.co')){
          handleSignOut();
          if(context.mounted) Navigator.pushNamed(context, 'alert', arguments: templateAlerts.notAllowedAcountError);
          return false;
        }
        print(googleUser.id);
        String? token = await tokenProvider.saveToken(
            googleUser.email,
            googleUser.id,
        );
        if( token == null) return false;
        await _storage.write(key: 'token', value: token);
        return true;

      }
    } catch (e) {
      print('Error sign in with Google $e');
    } finally {
      handleSignOut();
    }
    return false;

  }

  Future<void> handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch(e) {
      print('Error al salir: $e');
    }
  }

  Future<void> eraseUserData() async {
    await _storage.delete(key: 'token');
  }

}