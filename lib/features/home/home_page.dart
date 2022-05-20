

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/model/room.dart';
import 'package:smart_home_dev/common/model/room_service.dart';


import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/icon_action.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
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

  final ScrollController _scrollController = ScrollController();
  final _roomRef = FirebaseDatabase.instance.ref();




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
                      color: Colors.white54,
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      )
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                TextCustom('29*C',
                                    size: 20.sp, weight: SmartHomeStyle.mediumWeight),
                                TextCustom('Nhiệt độ hiện tại',
                                  size: 17.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.black,),
                              ],
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            child: Column(
                              children: [
                                TextCustom('80%',
                                    size: 20.sp, weight: SmartHomeStyle.mediumWeight),
                                TextCustom('Độ ẩm',
                                  size: 17.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.black,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                TextCustom('29*C/27*C',
                                    size: 20.sp, weight: SmartHomeStyle.mediumWeight),
                                TextCustom('Nhiệt độ cao nhất/thấp nhất',
                                  size: 17.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.black,),
                              ],
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            child: Column(
                              children: [
                                TextCustom('Có mưa',
                                    size: 20.sp, weight: SmartHomeStyle.mediumWeight),
                                TextCustom('Thủ Đức',
                                  size: 17.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.black,),
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
                    TextCustom('Các phòng:',
                      size: 20.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.black,),
                    IconAction(_addRoom, 'assets/images/theme/ic_news.png',
                        width: 22.sp, height: 22.sp, padding: 3.sp, color: Colors.white)
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

  }

  @override
  void initUI() {

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
                      GestureDetector(
                        onTap: (){
                          Constants.roomkey = key.toString();
                          CoreUtilUI.goToPage(context, RoomDetailPage(room.name,
                              ),hasBack: true);
                          // setState(() {
                          //   if(room.connect == false){
                          //     _deviceRef.child('device/$key/state').set(1);
                          //   } else {
                          //     _deviceRef.child('device/$key/state').set(0);
                          //   }
                          //
                          // });
                        },
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(room.image.toString(),
                            color: room.connect == false ? Colors.black : Colors.indigo,),
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
  void _addRoom() {
    final room = Room(name: 'Living Room',
        image: 'assets/images/theme/air_conditioner1.png',temp: 29.1,hum: 80.1,connect: false);
    (widget as HomePage).roomService.saveRoom(room);
    setState(() {});
  }

}