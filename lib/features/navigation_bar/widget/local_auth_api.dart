import 'dart:developer';

import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;

      return await _auth.authenticate(
          localizedReason: 'Unlock to see your API key',
          options: const AuthenticationOptions(
            stickyAuth: true,
            useErrorDialogs: true,
          ));
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
