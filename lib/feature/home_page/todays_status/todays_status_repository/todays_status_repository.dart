import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../../common/const/app_consts.dart';

class TodayStatusRepository {
  Future<(String, String)> todayInfo() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Employees")
          .doc($storage.getString(StorageKeys.firebaseId.name))
          .collection("Davomat")
          .doc(DateFormat("dd MM yyyy").format(DateTime.now()))
          .get();
        String checkIn = snapshot["kirish"];
        String checkOut = snapshot["chiqish"];
      return (checkIn, checkOut);
    } catch (e) {
      throw Exception();
    }
  }

}
