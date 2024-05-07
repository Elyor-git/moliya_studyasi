import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moliya_studyasi/common/const/app_consts.dart';


class LoginRepository {


  Future<void> loginUser(String employeeId, String password) async {
    try {
      QuerySnapshot employeeSnapId = await FirebaseFirestore.instance
          .collection("Employees")
          .where("id", isEqualTo: employeeId)
          .where("password", isEqualTo: password)
          .get();

      await $storage.setString(StorageKeys.name.name, employeeSnapId.docs[0]["name"]);
      await $storage.setString(StorageKeys.surname.name, employeeSnapId.docs[0]["surname"]);
      await $storage.setString(StorageKeys.employeeId.name, employeeSnapId.docs[0]["id"]);
      await $storage.setString(StorageKeys.firebaseId.name, employeeSnapId.docs[0].id);

      print(" ********************************* ${StorageKeys.name.name} *****************************");

      print(
          "--------------------${employeeSnapId.docs[0]["name"]}   -------------------");
      print(
          "--------------------${employeeSnapId.docs[0]["password"]}   -------------------");
      print(
          "--------------------${employeeSnapId.docs[0].id}   -------------------");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
