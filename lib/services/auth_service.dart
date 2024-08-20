import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_arguello_joel/services/firestone_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendVerificationCode(String phoneNumber, Function(String) onCodeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Error al enviar el código: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyCode(String verificationId, String smsCode, String name) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      FirestoreService().storeOrUpdateUserInfo(userCredential.user, name);
    } catch (e) {
      print('Error al verificar el código: ${e.toString()}');
    }
  }
}
