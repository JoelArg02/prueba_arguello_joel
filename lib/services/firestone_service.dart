import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_arguello_joel/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void storeUserInfo(User? user) async {
    if (user != null) {
      UserModel userModel = UserModel(
        uid: user.uid,
        phone: user.phoneNumber!,
        name: 'Nombre del Usuario', 
      );

      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
    }
  }

  void storeOrUpdateUserInfo(User? user, String name) {}
}
