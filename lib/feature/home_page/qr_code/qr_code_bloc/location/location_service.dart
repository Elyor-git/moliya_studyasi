
import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  late LocationData _locationData;

  Future<void> takePermission() async {
    bool serviceEnable;
    PermissionStatus permissionStatus;

    serviceEnable = await location.serviceEnabled();

    if(!serviceEnable){
      serviceEnable = await location.requestService();
      if(!serviceEnable){
        return;
      }
    }

    permissionStatus = await location.hasPermission();
    if(permissionStatus == PermissionStatus.denied){
      permissionStatus = await location.requestPermission();
      if(permissionStatus != PermissionStatus.granted){
        return;
      }
    }

  }


  Future<double?> getLatitude()async {
_locationData = await location.getLocation();
   return _locationData.latitude;
  }

  Future<double?> getLongitude()async {
    _locationData = await location.getLocation();
    return _locationData.longitude;
  }

}