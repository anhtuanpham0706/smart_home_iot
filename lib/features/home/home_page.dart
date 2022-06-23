
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_home_dev/common/model/room.dart';
import 'package:smart_home_dev/common/model/room_service.dart';
import 'package:smart_home_dev/common/model/weather.dart';

import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/icon_action.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/common/ui/theme_textfield.dart';
import 'package:smart_home_dev/features/home/home_bloc.dart';
import 'package:smart_home_dev/features/room_detail/room_detail_page.dart';


import '../../common/ui/base_page_state.dart';

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
  //late Position _currentPosition;
  Weather? _weather;
  String _dropName = '';
  String _dropImage = '';
  String _type_room = '';
  List<RoomAdd> _room = [
    RoomAdd(name: 'Ngoài trời', image: 'assets/images/theme/house.png'),
    RoomAdd(name: 'Phòng Khách', image: 'assets/images/theme/living-room.png'),
    RoomAdd(name: 'Phòng Ngủ', image: 'assets/images/theme/beds.png'),
    RoomAdd(name: 'Bếp', image: 'assets/images/theme/kitchen.png'),
  ];

  @override
  Widget build(BuildContext context, {Color color = Colors.white}) =>
      Container(child: Stack(
        children: [
          SizedBox(width: 1.sw, height: 1.sh, child:
          Image.asset('assets/images/theme/ic_livingroom3.png', fit: BoxFit.fill)
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(padding: EdgeInsets.fromLTRB(16.sp, ScreenUtil().statusBarHeight + 27.sp, 16.sp, 10.sp),
                    color: SmartHomeStyle.primaryColor,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(child: TextCustom('Home',
                          size: 20.sp, weight: SmartHomeStyle.mediumWeight)),
                      Row(children: [
                        IconAction(_menuAction, 'assets/images/theme/ic_menu.png',
                            width: 22.sp, height: 22.sp, padding: 3.sp, color: Colors.white)
                      ])
                    ])),
                TextCustom('Thời tiết hiện tại',
                  size: 20.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.black,),
                Container(
                  width: 360.sp,
                  height: 200.sp,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(const Radius.circular(20)),
                      color: Colors.lightBlue,
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      )
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 25.sp,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom('Nhiệt độ',
                                size: 15.sp,color: Colors.black,),
                              if(_weather!=null)TextCustom('${(_weather!.main.temp - 273.15).toInt()}°',
                                size: 50.sp,color: Colors.white,),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom('Độ ẩm',
                                  size: 15.sp,color: Colors.black,),
                                Row(
                                  children: [
                                    if(_weather!=null)TextCustom(
                                        _weather!.main.humidity.toString(),
                                        size: 50.sp,
                                        weight: SmartHomeStyle.mediumWeight),
                                    TextCustom('%',
                                        size: 15.sp, weight: SmartHomeStyle.mediumWeight),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          SizedBox(width: 20.sp,)
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
                                child: Image.asset('assets/images/theme/sun_cloud.png'),
                              ),
                              if(_weather!=null) TextCustom(_weather!.weather[0].description,
                                  size: 20.sp,
                                  weight: SmartHomeStyle.mediumWeight),
                              Row(
                                children: [
                                  if(_weather!=null)TextCustom('H:${(_weather!.main.tempMax - 273.15).toInt()}°',
                                    size: 17.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.red,),
                                  SizedBox(width: 10.sp,),
                                  if(_weather!=null)TextCustom('L:${(_weather!.main.tempMin - 273.15).toInt()}°',
                                    size: 17.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.indigo,),
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
                                if(_weather!=null)TextCustom(
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
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 15.sp,),
                    TextCustom('Các phòng:',
                      size: 20.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.black,),
                    Spacer(),
                    IconAction(_open_opision, 'assets/images/theme/more.png',
                        width: 22.sp, height: 22.sp, padding: 3.sp, color: Colors.black),
                    SizedBox(width: 15.sp,),
                  ],
                ),
                _getDeviceList()

                // Expanded(child: page)
              ])
        ],
      ), color: color);



  @override
  Widget createUI(BuildContext context) => const SizedBox();

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
                  color: room.connect == false ? Colors.white54: Colors.blue,
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(room.name.toString(),
                          style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                        const SizedBox(width: 40,),
                        Column(
                          children: [
                            const Text('Nhiệt độ: ',
                              style: TextStyle(fontSize: 15,color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold),),
                            Text('${room.temp.toInt()}*C',
                              style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(width: 40,),
                        Column(
                          children: [
                            Text('Độ ẩm: ',
                              style: TextStyle(fontSize: 15,color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold),),
                            Text('${room.hum.toInt()}%',
                              style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 120,
                        child: Image.asset(room.image.toString()),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          SizedBox(height: 55.sp,),
                          TextCustom('Trạng thái: Chưa Kết nối',size: 12.sp,color: Colors.black,),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Constants.roomkey = key.toString();
                          CoreUtilUI.goToPage(context, RoomDetailPage(room.name,
                              ),hasBack: true);
                        },
                        child: SizedBox(
                          height: 40,
                          width: 80,
                          child: TextCustom('Chi Tiết',size: 15.sp,color: Colors.black,weight: FontWeight.bold,),
                        ),
                      ),
                      SizedBox(width: 10,)
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
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
                children: <Widget>[
                  TextCustom('Chọn Thông số phòng',color: Colors.red,size: 18.sp,),
                  ThemeTextField(_ctrRoom, _focusRoom, Icons.phone_android_outlined, 'Name Room',type: TextInputType.name),
                  SizedBox(
                    width: 160,
                    child: DropdownButton(
                      hint: _dropName == null
                          ? Text('Chọn kiểu phòng')
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
                  ButtonCustom(_addRoom,TextCustom('Thêm Phòng',color: Colors.blue,)),
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
    final room = Room(name: _ctrRoom.text,
        image: _type_room,temp: 28.1,hum: 85.1,connect: false);
    (widget as HomePage).roomService.saveRoom(room);
    setState(() {});
    Navigator.pop(context);
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