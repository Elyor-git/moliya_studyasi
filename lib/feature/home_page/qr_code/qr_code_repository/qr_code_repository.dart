import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';
import 'package:moliya_studyasi/feature/home_page/qr_code/qr_code_bloc/location/location_service.dart';

class QRCodeRepository {

  Future<String> _getLocation() async {
    String place = "";
   double? longitude = await LocationService().getLongitude();
   double? latitude = await LocationService().getLatitude();

   try {
   List<Placemark> placemark = await placemarkFromCoordinates(latitude!, longitude!);
     place = "${placemark[0].street} ${placemark[0].name} ${placemark[0].administrativeArea}";
   }catch(e){
    place = "";
   }
   return place;
  }


  Future<void> setAndUpdateDateTime({required String barcodeRes}) async {
    String place = await _getLocation();
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
          "place" : place,
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
