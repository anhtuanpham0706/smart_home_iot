
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_home_dev/common/model/room.dart';
import 'package:smart_home_dev/common/model/room_service.dart';
import 'package:smart_home_dev/common/model/weather.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/base_page_state.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/icon_action.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/common/ui/theme_textfield.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';
import 'package:smart_home_dev/features/home/home_bloc.dart';
import 'package:smart_home_dev/features/room_detail/room_detail_page.dart';


class HomePage extends BasePage {
  final Function funOpenDrawer;
  HomePage(this.funOpenDrawer,
      {Key? key}) : super(_HomePageState(), key:key);
  final roomService = RoomService();
}




class _HomePageState extends BasePageState {

  final TextEditingController _ctrRoom = TextEditingController();
  final FocusNode _focusRoom = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final _roomRef = FirebaseDatabase.instance.ref();

  Weather? _weather;
  String _dropName = '';

  String _type_room = '';
  List<RoomAdd> _room = [
    RoomAdd(name: 'Ngoài trời', image: 'assets/images/theme/house.png'),
    RoomAdd(name: 'Phòng Khách', image: 'assets/images/theme/living-room.png'),
    RoomAdd(name: 'Phòng Ngủ', image: 'assets/images/theme/beds.png'),
    RoomAdd(name: 'Bếp', image: 'assets/images/theme/kitchen.png'),
  ];

  @override
  Widget createUI(BuildContext context) => Stack(
        children: [
          SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: Image.asset('assets/images/theme/ic_livingroom3.png',
                  fit: BoxFit.fill)),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(16.sp,
                        ScreenUtil().statusBarHeight + 27.sp, 16.sp, 10.sp),
                    color: SmartHomeStyle.primaryColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: TextCustom(MultiLanguage.get('ttl_home'),
                                  size: 20.sp,
                                  weight: SmartHomeStyle.mediumWeight)),
                          Row(children: [
                            IconAction(
                                _menuAction, 'assets/images/theme/ic_menu.png',
                                width: 22.sp,
                                height: 22.sp,
                                padding: 3.sp,
                                color: Colors.white)
                          ])
                        ])),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: TextCustom(
                    MultiLanguage.get('ttl_weather'),
                    size: 20.sp,
                    weight: SmartHomeStyle.mediumWeight,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: 360.sp,
                  height: 200.sp,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(const Radius.circular(20)),
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: const [
                          0.15,
                          0.85,
                        ],
                        colors: [
                          Colors.blueAccent.withOpacity(0.7),
                          Colors.lightBlueAccent.withOpacity(0.1)
                        ],
                      )),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25.sp,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                MultiLanguage.get('ttl_temp'),
                                size: 15.sp,
                                color: Colors.black,
                              ),
                              if (_weather != null)
                                TextCustom(
                                  '${(_weather!.main.temp - 273.15).toInt()}°',
                                  size: 50.sp,
                                  color: Colors.white,
                                ),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  MultiLanguage.get('ttl_hum'),
                                  size: 15.sp,
                                  color: Colors.black,
                                ),
                                Row(
                                  children: [
                                    if (_weather != null)
                                      TextCustom(
                                          _weather!.main.humidity.toString(),
                                          size: 50.sp,
                                          weight: SmartHomeStyle.mediumWeight),
                                    TextCustom('%',
                                        size: 15.sp,
                                        weight: SmartHomeStyle.mediumWeight),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.sp,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20.sp,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30.sp,
                                width: 30.sp,
                                child: Image.asset(
                                    'assets/images/theme/sun_cloud.png'),
                              ),
                              if (_weather != null)
                                TextCustom(_weather!.weather[0].description,
                                    size: 20.sp,
                                    weight: SmartHomeStyle.mediumWeight),
                              Row(
                                children: [
                                  if (_weather != null)
                                    TextCustom(
                                      'H:${(_weather!.main.tempMax - 273.15).toInt()}°',
                                      size: 17.sp,
                                      weight: SmartHomeStyle.mediumWeight,
                                      color: Colors.red,
                                    ),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  if (_weather != null)
                                    TextCustom(
                                      'L:${(_weather!.main.tempMin - 273.15).toInt()}°',
                                      size: 17.sp,
                                      weight: SmartHomeStyle.mediumWeight,
                                      color: Colors.indigo,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 25.sp,
                                  width: 25.sp,
                                  child: Image.asset(
                                      'assets/images/theme/location.png'),
                                ),
                                if (_weather != null)
                                  TextCustom(
                                    _weather!.name,
                                    size: 15.sp,
                                    weight: SmartHomeStyle.mediumWeight,
                                    color: Colors.white,
                                    maxLine: 1,
                                  ),
                                SizedBox(
                                  width: 20.sp,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5.sp,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15.sp,
                    ),
                    TextCustom(
                      MultiLanguage.get('ttl_room'),
                      size: 20.sp,
                      weight: SmartHomeStyle.mediumWeight,
                      color: Colors.black,
                    ),
                    Spacer(),
                    TextCustom(
                      MultiLanguage.get('btn_add_room'),
                      size: 20.sp,
                      weight: SmartHomeStyle.mediumWeight,
                      color: Colors.black,
                    ),
                    IconAction(_open_opision, 'assets/images/theme/more.png',
                        width: 22.sp,
                        height: 22.sp,
                        padding: 3.sp,
                        color: Colors.black),
                    SizedBox(
                      width: 15.sp,
                    ),
                  ],
                ),
                _getDeviceList()

                // Expanded(child: page)
              ])
        ],
      );

  @override
  void initBloc() {
    bloc = HomeBloc();
    bloc?.stream.listen((state) {
      if (state is GetValueWeatherState) {
        setState(() {
          _weather = state.data;
        });
      }
    });
  }

  @override
  void initUI() {
    // _determinePosition();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        //_currentPosition = position;
        bloc?.add(GetValueWeatherEvent(
            position.longitude.toString(), position.latitude.toString()));
        // print(_currentPosition.longitude);
        // print(_currentPosition.latitude);
      });
    }).catchError((e) {
      print(e);
    });
  }


  void _menuAction() => (widget as HomePage).funOpenDrawer();
  Widget _getDeviceList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: (widget as HomePage).roomService.getRoomQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          dynamic key = snapshot.key;
          final room = Room.fromJson(json);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFEAECF6).withOpacity(0.9),
                  border: Border.all(
                    width: 1,
                    color: Color(0xFF464646),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(room.name.toString(),
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Column(
                          children: [
                            Text(
                              MultiLanguage.get('ttl_temp'),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.deepOrangeAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            room.connect
                                ? Text(
                                    '${room.temp.toInt()}*C',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                              '',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40.sp,
                        ),
                        Column(
                          children: [
                            Text(
                              MultiLanguage.get('ttl_hum'),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.deepOrangeAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            room.connect
                                ? Text(
                                    '${room.hum.toInt()}%',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(
                              '',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 120,
                        child: Image.asset(room.image.toString()),
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 65.sp,
                          ),
                          TextCustom(
                            '${MultiLanguage.get('ttl_state')} ${room.connect ? MultiLanguage.get('ttl_connected') : MultiLanguage.get('ttl_not_connected')}',
                            size: 12.sp,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 40.sp,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Constants.roomkey = key.toString();
                              CoreUtilUI.goToPage(
                                  context,
                                  RoomDetailPage(
                                    room.name,
                                  ),
                                  hasBack: true);
                            },
                            child: SizedBox(
                              child: TextCustom(
                                MultiLanguage.get('ttl_detail'),
                                size: 15.sp,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.sp,
                          ),
                          GestureDetector(
                            onTap: () {
                              if(room.connect){
                                UtilUI.showCustomAlertDialog(context,
                                    MultiLanguage.get('lbl_remove_room'),
                                    isActionCancel: false)
                                    .then((value) {
                                });
                              } else {
                                UtilUI.showCustomAlertDialog(context,
                                    MultiLanguage.get('lbl_delete_room'),
                                    isActionCancel: true)
                                    .then((value) {
                                  if (value == true) {
                                    _roomRef
                                        .child(
                                        'smart_home/${Constants.housekey}/room/$key')
                                        .remove();
                                  }
                                });

                              }

                            },
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset('assets/images/theme/bin.png',
                                  color: Colors.black),
                            ),
                          )
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
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          return Container(
            height: 300.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
            child: Column(
                children: <Widget>[
          TextCustom(
            MultiLanguage.get('ttl_info_room'),
            color: Colors.red,
            size: 18.sp,
          ),
          ThemeTextField(_ctrRoom, _focusRoom, Icons.phone_android_outlined,
              MultiLanguage.get('ttl_name_room'),
              type: TextInputType.name),
          SizedBox(
            width: 160,
            child: DropdownButton(
              hint: _dropName == null
                  ? Text(MultiLanguage.get('ttl_type_room'))
                  : Text(
                      _dropName,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: _room.map(
                            (RoomAdd list) {
                          return DropdownMenuItem<String>(
                            value: list.name,
                            child: Text(list.name),
                          );
                        },
                      ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    _dropName = val.toString();
                    _change_image(_dropName);
                  },
                );
              },
            ),
          ),
          ButtonCustom(
              _addRoom,
              TextCustom(
                MultiLanguage.get('btn_add_room'),
                color: Colors.blue,
              )),
        ]),

          );
        });
  }
  void _open_opision(){
    showModalBottomSheet(
      context: context,
      builder: ((builder) => bottomSheet()),
    );
  }
  void _addRoom() {
    final room = Room(
        name: _ctrRoom.text,
        image: _type_room,
        temp: 0.0,
        hum: 0.0,
        connect: false);
    if (_type_room == '') {
      UtilUI.showCustomAlertDialog(
              context, MultiLanguage.get('lbl_choose_type_room'),
              isActionCancel: false)
          .then((value) {});
    } else {
      (widget as HomePage).roomService.saveRoom(room);
      setState(() {});
      Navigator.pop(context);
    }
  }

  void _change_image(String typeroom){
    int index = 0;
    for (index = 0; index < _room.length; index++) {
      if(_room[index].name == typeroom) {
        _type_room = _room[index].image;
      }
    }
  }

}