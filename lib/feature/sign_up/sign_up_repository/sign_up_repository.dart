
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/const/app_consts.dart';

class SignUpRepository {
  Future<void> signUpUser({
    required String employeeId,
    required String password,
    required String name,
    required String surname,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("Employees").doc().set({
        "name": name,
        "surname": surname,
        "id": employeeId,
        "password": password,
      }).then((value) async {
        QuerySnapshot employeeSnapId = await FirebaseFirestore.instance
            .collection("Employees")
            .where("id", isEqualTo: employeeId)
            .where("password", isEqualTo: password)
            .get();
        await $storage.setString(
            StorageKeys.name.name, employeeSnapId.docs[0]["name"]);
        await $storage.setString(
            StorageKeys.surname.name, employeeSnapId.docs[0]["surname"]);
        await $storage.setString(
            StorageKeys.employeeId.name, employeeSnapId.docs[0]["id"]);
        await $storage.setString(
            StorageKeys.firebaseId.name, employeeSnapId.docs[0].id);
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
