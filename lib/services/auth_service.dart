import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_arguello_joel/services/firestone_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendVerificationCode(
      String phoneNumber, Function(String) onCodeSent) async {
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

  Future<bool> verifyCode(
      String verificationId, String smsCode, String name) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({'name': name});

        return true; 
      } else {
        return false; 
      }
    } catch (e) {
      print(e);
      return false; 
    }
  }
}
