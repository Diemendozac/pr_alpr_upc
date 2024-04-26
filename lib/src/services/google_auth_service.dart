
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pr_alpr_upc/src/http/response/local_response.dart';
import 'package:pr_alpr_upc/src/providers/token_provider.dart';
import 'package:pr_alpr_upc/src/services/user_service.dart';
import 'package:pr_alpr_upc/src/utils/template_alert_constants.dart';

class GoogleAuthService {

  GoogleAuthService._();

  static GoogleAuthService instance = GoogleAuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: '718421263049-cukdqhhc8u34l5bb251jet8nql7aa7si.apps.googleusercontent.com');
  final UserService userService = UserService();
  final TokenProvider tokenProvider = TokenProvider();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<dynamic> handleSignUp(BuildContext context) async {

    try{
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser != null) {
        if(!googleUser.email.endsWith('unicesar.edu.co')){
          handleSignOut();
          if(context.mounted) Navigator.pushNamed(context, 'alert', arguments: TemplateAlerts.notAllowedAcountError );
          return LocalResponse(406);

        }

        dynamic test = await userService.saveUser(
          googleUser.email,
          googleUser.id,
          googleUser.displayName!,
          googleUser.photoUrl
        );
        return test;

      }
    } catch (e) {
      print('Error sign in with Google $e');
    } finally {
      handleSignOut();
    }

    return LocalResponse(500);

  }

  Future<dynamic> handleLogIn(BuildContext context) async {

    dynamic response;
    const FlutterSecureStorage storage = FlutterSecureStorage();

    try{
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if(googleUser != null) {
        if(!googleUser.email.endsWith('unicesar.edu.co')){
          handleSignOut();
          //if(context.mounted) Navigator.pushNamed(context, 'alert', arguments: TemplateAlerts.notAllowedAcountError);
          return LocalResponse(406);
        }
        response = await tokenProvider.saveToken(
            googleUser.email,
            googleUser.id,
        );
        return response;

      }
    } catch (e) {
      print('Error sign in with Google $e');
    } finally {
      handleSignOut();
      if (response == null || response.statusCode != 200) {
        await storage.write(key: 'token', value: null);
      }

    }
    return response;

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