


import 'package:firebase_database/firebase_database.dart';
import 'package:smart_home_dev/common/constants.dart';
import 'package:smart_home_dev/common/model/room.dart';

class RoomService {
  final DatabaseReference _roomRef = FirebaseDatabase.instance
      .ref()
      .child('smart_home/${Constants.housekey}/room');

  void saveRoom(Room room) {
    _roomRef.push().set(room.toJson());
  }

  void deleteRoom(String hashkey) {
    _roomRef.push().child('/$hashkey').remove();
  }

  Query getRoomQuery() {
    return _roomRef;
  }
}