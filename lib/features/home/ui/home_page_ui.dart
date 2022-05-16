


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/icon_action.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/features/home/home_bloc.dart';

import '../../../common/ui/base_page_state.dart';

class HomePageUI extends StatelessWidget {

  final HomeBloc bloc;
  final Function menuAction;
  const HomePageUI(this.bloc,
       this.menuAction,
       {Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: EdgeInsets.fromLTRB(16.sp, ScreenUtil().statusBarHeight + 27.sp, 16.sp, 10.sp),
              color: SmartHomeStyle.primaryColor,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: TextCustom('Home',
                    size: 20.sp, weight: SmartHomeStyle.mediumWeight)),
                Row(children: [
                  IconAction(menuAction, 'assets/images/theme/ic_menu.png',
                      width: 22.sp, height: 22.sp, padding: 3.sp, color: Colors.white)
                ])
              ])),
          Container(
            color: Colors.blue,
            width: 360.sp,
            height: 200.sp,
            child: Column(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      TextCustom('Nhiệt độ hiện tại',
                        size: 17.sp, weight: SmartHomeStyle.mediumWeight,color: Colors.black,),
                      TextCustom('29*C',
                          size: 20.sp, weight: SmartHomeStyle.mediumWeight),

                    ],
                  ),
                )


              ],
            ),
          ),

          // Expanded(child: page)
        ]);

  }
}