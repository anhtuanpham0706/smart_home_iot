class Device {
  String name;
  String image;
  String button;
  int state;
  bool connect;
  Device({required this.name,required this.image,required this.state,required this.button,required this.connect});

  Device.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'] as String,
        image = json['image'] as String,
        button = json['button'] as String,
        connect = json['connect'] as bool,
        state = json['state'] as int;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'image': image,
    'button': button,
    'state': state,
    'connect': connect
  };
}
class DeviceAdd {
  String name;
  String image;
  DeviceAdd({required this.name,required this.image});
}







