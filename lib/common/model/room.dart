class Room {
  String name;
  String image;
  double temp;
  double hum;
  bool connect;
  Room({required this.name,required this.image,required this.temp,required this.hum,required this.connect});

  Room.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'] as String,
        image = json['image'] as String,
        temp = json['temp'] as double,
        hum = json['hum'] as double,
        connect = json['connect'] as bool;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'image': image,
    'temp': temp,
    'hum': hum,
    'connect': connect
  };
}
class RoomAdd {
  String name;
  String image;

  RoomAdd({required this.name,required this.image});


}