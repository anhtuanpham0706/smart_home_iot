
class DeviceAdd {
  late String name;
  late String image_device;

  DeviceAdd({required this.name,required this.image_device});

}

List<DeviceAdd> add_device = [
  DeviceAdd(name: 'Đèn', image_device: 'assets/images/light.png'),
  DeviceAdd(name: 'Tivi', image_device: 'assets/images/tivi.png'),
  DeviceAdd(name: 'Điều Hòa', image_device: 'assets/images/aircondition.png'),
  DeviceAdd(name: 'Quạt', image_device: 'assets/images/fan.png'),
  DeviceAdd(name: 'Cửa', image_device: 'assets/images/door.png'),
];


