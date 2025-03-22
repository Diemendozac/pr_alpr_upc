
import 'package:local_auth/local_auth.dart';

class DeviceAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      bool canAuthenticate = await _localAuth.canCheckBiometrics || await _localAuth.isDeviceSupported();
      if (!canAuthenticate) return false;

      return await _localAuth.authenticate(
        localizedReason: 'Authenticate to delete the vehicle',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
