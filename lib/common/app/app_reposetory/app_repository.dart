import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';

class AppRepository {
  Future<bool> checkUserInFireStore() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Employees')
          .doc($storage.getString(StorageKeys.firebaseId.name))
          .get();
      return userSnapshot.exists;
    } catch (e) {
      throw Exception('Error checking user in Firestore: $e');
    }
  }
}
