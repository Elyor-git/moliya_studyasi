import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../../common/const/app_consts.dart';

class TodayStatusRepository {
  Future<String> todayCheckIn() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Employees")
          .doc($storage.getString(StorageKeys.firebaseId.name))
          .collection("Davomat")
          .doc(DateFormat("dd MM yyyy").format(DateTime.now()))
          .get();
      return snapshot["kirish"];
    } catch (e) {
      throw Exception();
    }
  }

  Future<String> todayCheckOut() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Employees")
          .doc($storage.getString(StorageKeys.firebaseId.name))
          .collection("Davomat")
          .doc(DateFormat("dd MM yyyy").format(DateTime.now()))
          .get();
      return snapshot["chiqish"];
    } catch (e) {
      throw Exception();
    }
  }
}
