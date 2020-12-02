import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart';

class Biometric {
  authen({String message = ''}) async {
    try {
      var localAuth = new LocalAuthentication();

      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
          localizedReason: message, useErrorDialogs: false);
      return didAuthenticate;
    } on PlatformException catch (e) {
      switch (e.code) {
        case notAvailable:
          return BiometricError.notAvailable;
        case passcodeNotSet:
          return BiometricError.passcodeNotSet;
        case notEnrolled:
          return BiometricError.notEnrolled;
        case otherOperatingSystem:
          return BiometricError.otherOperatingSystem;
        case lockedOut:
          return BiometricError.lockedOut;
        case permanentlyLockedOut:
          return BiometricError.permanentlyLockedOut;
        default:
          return BiometricError.otherOperatingSystem;
      }
    }
  }

  Future<BiometricType> getAvailableBiometric() async {
    var auth = new LocalAuthentication();
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.face)) {
      return BiometricType.face;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return BiometricType.fingerprint;
    }
    return BiometricType.iris;
  }

  getBiometricError({@required BiometricError error}) async {
    final type = await getAvailableBiometric();
    print('Biometric type $type');
    final typeName = (type == BiometricType.fingerprint)
        ? 'Vân tay'
        : (type == BiometricType.face ? 'Face ID' : 'Nhận dạng sinh trắc học');
    switch (error) {
      case BiometricError.notAvailable:
        return typeName + ' không khả dụng trên thiết bị';
      case BiometricError.passcodeNotSet:
        return ' Passcode chưa được cài đặt trên thiết bị';
      case BiometricError.notEnrolled:
        return typeName + ' chưa được cài đặt trên thiết bị';
      case BiometricError.otherOperatingSystem:
        return typeName + ' không khả dụng trên thiết bị';
      case BiometricError.lockedOut:
        return typeName + ' bị khoá';
      case BiometricError.permanentlyLockedOut:
        return typeName + ' bị khoá';
      default:
        return typeName + ' không khả dụng trên thiết bị';
    }
  }
}

enum BiometricError {
  notAvailable,
  passcodeNotSet,
  notEnrolled,
  otherOperatingSystem,
  lockedOut,
  permanentlyLockedOut
}
