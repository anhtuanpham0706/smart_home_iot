


import 'package:firebase_database/firebase_database.dart';
import 'package:smart_home_dev/common/constants.dart';
import 'package:smart_home_dev/common/model/device.dart';

class DeviceDao {
  final DatabaseReference _deviceRef = FirebaseDatabase.instance
      .ref()
      .child('smart_home/0929317227/room/${Constants.roomkey}/device');

  void saveDevice(Device device) {
    _deviceRef.push().set(device.toJson());
  }

  void deleteDevice(String key) {
    _deviceRef.push().child('/$key').remove();
  }

  Query getDeviceQuery() {
    return _deviceRef;
  }
}