import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/core/shared_prefs.dart';

class AuthRepositary {
  static final googleSignInApi = GoogleSignIn();

  Future<GoogleSignInAccount?> googleSignIn() async {
    try {
      GoogleSignInAccount? user = await googleSignInApi.signIn();
      final userAuth = await user?.authentication;
      final token = userAuth?.accessToken;
      await Prefs.setString(ConstantsString.googleSignInToken, token ?? '');
      await Prefs.setString(ConstantsString.userID, user?.id ?? '');
      await Prefs.setString(ConstantsString.userDisplayName, user?.displayName ?? '');
      await Prefs.setString(ConstantsString.userEmail, user?.email ?? '');
      await Prefs.setString(ConstantsString.userProfileUrl, user?.photoUrl ?? '');
      return user;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
