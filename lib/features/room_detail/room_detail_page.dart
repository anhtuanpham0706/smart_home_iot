



import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/model/device.dart';
import 'package:smart_home_dev/common/model/device_service.dart';
import 'package:smart_home_dev/common/model/room_service.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/icon_action.dart';

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
  ScrollController _scrollController = ScrollController();
  final _deviceRef = FirebaseDatabase.instance.reference();




  @override
  Widget build(BuildContext context, {Color color = Colors.white}) =>
      Scaffold(
        body: Container(child: Stack(
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

                        Row(children: [
                          IconAction(_back, 'assets/images/theme/ic_arrow_back.png',
                              width: 22.sp, height: 22.sp, padding: 3.sp, color: Colors.white)
                        ]),
                        Expanded(child: TextCustom((widget as RoomDetailPage).name_room,
                            size: 20.sp, weight: SmartHomeStyle.mediumWeight)),
                      ])),
                  GestureDetector(
                    onTap: (){
                      _sendMessage();
                    },
                    child: Container(
                      child: Text('send device'),

                    ),
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
  void initUI() {

  }
  void _back() {
    CoreUtilUI.goBack(context, true);
  }
  void _sendMessage() {

    final device = Device(name: 'Fan',
        image: 'assets/images/theme/air_conditioner1.png',state: 1,button: 'assets/images/theme/button_on_off.png', connect: false);
    (widget as RoomDetailPage).deviceDao.saveDevice(device);

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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: device.state == 0 ? Colors.white54: Colors.blue,
                  border: Border.all(
                    width: 2,
                    color: Colors.black12,
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 120,
                        child: Image.asset(device.image.toString()),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(device.state == 0){
                              _deviceRef.child('smart_home/0929317227/room/${Constants.roomkey}/device/$key/state').set(1);
                            } else {
                              _deviceRef.child('smart_home/0929317227/room/${Constants.roomkey}/device/$key/state').set(0);
                            }

                          });
                        },
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(device.button.toString(),
                            color: device.state == 0 ? Colors.black : Colors.indigo,),
                        ),
                      ),
                      SizedBox(width: 10,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(device.name.toString(),style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                  )


                ],
              ),

            ),
          );
        },
      ),
    );
  }

   // void _addRoom() {
   //   final room = Room(name: 'Living Room',
   //       image: 'assets/images/theme/air_conditioner1.png',temp: 29.1,hum: 80.1,connect: false);
   //   (widget as RoomDetailPage).roomService.saveRoom(room);
   //   setState(() {});
   // }

}