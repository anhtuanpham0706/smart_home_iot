


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
        return Stack(
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
                          IconAction(menuAction, 'assets/images/theme/ic_menu.png',
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
                        color: Colors.blue,
                        border: Border.all(
                          width: 2,
                          color: Colors.black12,
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
                      IconAction(menuAction, 'assets/images/theme/ic_news.png',
                          width: 22.sp, height: 22.sp, padding: 3.sp, color: Colors.white)
                    ],
                  ),

                  // Expanded(child: page)
                ])
          ],
        );

  }

}