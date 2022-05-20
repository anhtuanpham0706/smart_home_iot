


import 'package:firebase_database/firebase_database.dart';
import 'package:smart_home_dev/common/model/room.dart';

class RoomService {
  final DatabaseReference _roomRef =
  FirebaseDatabase.instance.ref().child('smart_home/0929317227/room');

  void saveRoom(Room room) {
    _roomRef.push().set(room.toJson());
  }

  Query getRoomQuery() {
    return _roomRef;
  }
}