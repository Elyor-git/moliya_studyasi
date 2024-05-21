import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';

class QRCodeRepository {




  Future<void> setAndUpdateDateTime({required String barcodeRes}) async {

    try {
      if (barcodeRes == "Hello welcome to Moliya studyasi") {
        await FirebaseFirestore.instance
            .collection("Employees")
            .doc($storage.getString(StorageKeys.firebaseId.name))
            .collection("Davomat")
            .doc(DateFormat("dd MM yyyy").format(DateTime.now()))
            .set({
          "kirish": DateFormat("HH:mm").format(DateTime.now()),
          "chiqish": "--:--",
          "date" : Timestamp.now(),
        });
      } else if (barcodeRes == "Goodbye see you soon") {
        await FirebaseFirestore.instance
            .collection("Employees")
            .doc($storage.getString(StorageKeys.firebaseId.name))
            .collection("Davomat")
            .doc(DateFormat("dd MM yyyy").format(DateTime.now()))
            .update({
          "chiqish": DateFormat("HH:mm").format(DateTime.now()),
        });
      }
    } catch (e) {
      throw Exception();
    }
  }
}
