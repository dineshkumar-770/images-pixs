import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/common/toast.dart';
import 'package:wallpaper_pix/core/shared_prefs.dart';

class DataBaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveUserInfo(
      {required String email,
      required String name,
      required String profileUrl}) async {
    try {
      String userID = Prefs.getString(ConstantsString.userID);
      Map<String, dynamic> userInfo = {
        "email": email,
        "name": name,
        "profileUrl": profileUrl
      };
      await firestore.collection('users').doc(userID).set(userInfo);
    } on FirebaseException catch (e) {
      FlutterToast.showToast(message: e.message.toString());
    }
  }
}
