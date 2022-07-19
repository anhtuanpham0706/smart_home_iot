



import 'package:core_advn/common/ui/base_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/language_key.dart';
import 'package:smart_home_dev/common/model/device.dart';
import 'package:smart_home_dev/common/model/device_service.dart';
import 'package:smart_home_dev/common/model/room_service.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/icon_action.dart';
import 'package:smart_home_dev/common/ui/theme_textfield.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';

import '../../common/ui/base_page_state.dart';
import '../../common/ui/text_custom.dart';


class RoomDetailPage extends BasePage {
   String name_room;
   String key_room;
   int temp;
   int hum;
  final Function? funReloadHome;
  final bool isReloadHome;
  RoomDetailPage(this.name_room,{this.temp=28,this.hum=90,this.key_room = '',this.funReloadHome, this.isReloadHome = false, Key? key})
      : super(_RoomDetailPageState(), key:key);
   final deviceDao = DeviceDao();
}

class _RoomDetailPageState extends BasePageState {

  // final DatabaseReference _deviceRef =
  // FirebaseDatabase.instance.ref().child('smart_home/0929317227/room/${Constants.roomkey}/device');
  //
  // void saveDevice(Device device) {
  //   _deviceRef.push().set(device.toJson());
  // }
  //
  //
  // Query getDeviceQuery() {
  //   return _deviceRef;
  // }
  final TextEditingController _ctrDetailRoom = TextEditingController();
  final FocusNode _focusDetailRoom = FocusNode();
  ScrollController _scrollController = ScrollController();
  final _deviceRef = FirebaseDatabase.instance.reference();
  String _deviceName = '';
  String _deviceImage = '';
  String _type_device = '';
  List<DeviceAdd> _device = [
    DeviceAdd(name: 'Đèn ngủ', image: 'assets/images/table-lamp.png'),
    DeviceAdd(name: 'Đèn trần', image: 'assets/images/ceiling_light.png'),
    DeviceAdd(name: 'Tivi', image: 'assets/images/tv.png'),
    DeviceAdd(name: 'Quạt', image: 'assets/images/fan.png'),
    DeviceAdd(name: 'Cổng', image: 'assets/images/gate.png'),
    DeviceAdd(name: 'Rèm', image: 'assets/images/curtains.png'),
  ];




  @override
  Widget build(BuildContext context, {Color color = Colors.white}) =>
      Scaffold(
        body: Container(child: Stack(
          children: [
            SizedBox(width: 1.sw, height: 1.sh, child:
            Image.asset('assets/images/theme/ic_livingroom.png', fit: BoxFit.fill)
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(padding: EdgeInsets.fromLTRB(16.sp, ScreenUtil().statusBarHeight + 27.sp, 16.sp, 10.sp),
                          color: SmartHomeStyle.primaryColor,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  IconAction(_back,
                                      'assets/images/theme/ic_arrow_back.png',
                                      width: 22.sp,
                                      height: 22.sp,
                                      padding: 3.sp,
                                      color: Colors.white)
                                ]),
                                Expanded(
                                    child: TextCustom(
                                        (widget as RoomDetailPage).name_room,
                                        size: 20.sp,
                                        weight: SmartHomeStyle.mediumWeight)),
                              ])),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCustom(
                            MultiLanguage.get('btn_add_device'),
                            color: Colors.white,
                            size: 15.sp,
                            weight: FontWeight.bold,
                          ),
                          IconAction(
                              _open_opision, 'assets/images/theme/more.png',
                              width: 22.sp,
                              height: 22.sp,
                              padding: 3.sp,
                              color: Colors.white),
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      _getDeviceList(),

                      // Expanded(child: page)
                    ])

          ],
        ), color: color),
      );


  @override
  void initBloc() {
    var key_room = (widget as RoomDetailPage).key_room;

  }
  @override
  Widget createUI(BuildContext context) => const SizedBox();

  @override
  void initUI() {}

  void _back() {
    CoreUtilUI.goBack(context, true);
  }

  void _add_device() {
    final device = Device(
        name: _deviceName,
        image: _type_device,
        state: 0,
        button: 'assets/images/theme/button_on_off.png',
        connect: false);
    if (_deviceName == '') {
      UtilUI.showCustomAlertDialog(
              context, MultiLanguage.get('lbl_choose_type_device'),
              isActionCancel: false)
          .then((value) {});
    } else {
      (widget as RoomDetailPage).deviceDao.saveDevice(device);
      setState(() {});
      Navigator.pop(context);
    }
  }

  void removeDevice(String key) {
    (widget as RoomDetailPage).deviceDao.deleteDevice(key);
    setState(() {});
  }

  Widget _getDeviceList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: (widget as RoomDetailPage).deviceDao.getDeviceQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          dynamic key = snapshot.key;
          final device = Device.fromJson(json);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(top: 5.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                  color: device.state == 0 ? Colors.white54 : Colors.blue,
                  border: Border.all(
                    width: 2,
                    color: Colors.black12,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          device.name.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextCustom(
                        '${MultiLanguage.get('ttl_state_device')} ${device.state == 0 ? MultiLanguage.get('ttl_state_off') : MultiLanguage.get('ttl_state_on')}',
                        color: Colors.black,
                        size: 15.sp,
                      ),
                      SizedBox(
                        width: 30.sp,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 120,
                        child: Image.asset(device.image.toString()),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (device.state == 0) {
                                  _deviceRef
                                      .child(
                                          'smart_home/${Constants.housekey}/room/${Constants.roomkey}/device/$key/state')
                                      .set(1);
                                } else {
                                  _deviceRef
                                      .child(
                                          'smart_home/${Constants.housekey}/room/${Constants.roomkey}/device/$key/state')
                                      .set(0);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  100.sp, 10.sp, 5.sp, 15.sp),
                              child: TextCustom(
                                device.state == 0
                                    ? MultiLanguage.get('btn_on')
                                    : MultiLanguage.get('btn_off'),
                                color: Colors.black,
                                size: 25.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20.sp,
                              ),
                              TextCustom(
                                ' ${device.connect ? MultiLanguage.get('ttl_connected') : MultiLanguage.get('ttl_not_connected')}',
                                size: 15.sp,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 85.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if(device.connect){
                                    UtilUI.showCustomAlertDialog(
                                        context,
                                        MultiLanguage.get(
                                            'lbl_remove_device'),
                                        isActionCancel: false)
                                        .then((value) {
                                    });
                                  }else {
                                    UtilUI.showCustomAlertDialog(
                                        context,
                                        MultiLanguage.get(
                                            'lbl_delete_device'),
                                        isActionCancel: true)
                                        .then((value) {
                                      if (value == true) {
                                        _deviceRef
                                            .child(
                                            'smart_home/${Constants.housekey}/room/${Constants.roomkey}/device/$key')
                                            .remove();
                                      }
                                    });
                                  }

                                },
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                      'assets/images/theme/bin.png',
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 10.sp,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.sp,
                      )
                    ],
                  ),
                ],
              ),

            ),
          );
        },
      ),
    );
  }
  Widget bottomSheet() {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
      return Container(
        height: 300.0,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
            children: <Widget>[
          TextCustom(
            MultiLanguage.get('ttl_type_device'),
            color: Colors.red,
            size: 18.sp,
          ),
          SizedBox(
            width: 160,
            child: DropdownButton(
              hint: _deviceName == null
                  ? Text(MultiLanguage.get('ttl_type_device'))
                  : Text(
                      _deviceName,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
                  style: TextStyle(color: Colors.black),
                  items: _device.map(
                        (DeviceAdd list) {
                      return DropdownMenuItem<String>(
                        value: list.name,
                        child: Text(list.name),
                      );
                    },
                  ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    _deviceName = val.toString();
                    _change_image(_deviceName);
                  },
                );
              },
            ),
          ),
          ButtonCustom(
              _add_device,
              TextCustom(
                MultiLanguage.get('btn_add_device'),
                color: Colors.blue,
                size: 13.sp,
              )),
        ]),

      );
    });
  }
  void _change_image(String typedevice){
    int index = 0;
    for (index = 0; index < _device.length; index++) {
      if(_device[index].name == typedevice) {
        _type_device = _device[index].image;
      }
    }
  }
  void _open_opision(){
    showModalBottomSheet(
      context: context,
      builder: ((builder) => bottomSheet()),
    );
  }

   // void _addRoom() {
   //   final room = Room(name: 'Living Room',
   //       image: 'assets/images/theme/air_conditioner1.png',temp: 29.1,hum: 80.1,connect: false);
   //   (widget as RoomDetailPage).roomService.saveRoom(room);
   //   setState(() {});
   // }

}