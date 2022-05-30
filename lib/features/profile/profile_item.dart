

import 'package:core_advn/common/ui/button_custom_transparent.dart';
import 'package:core_advn/common/ui/import_base_ui_lib.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';

class ProfileItem extends StatelessWidget {
  final String assetIcon, title;
  final Function function;
  final bool hasLine, hasArrow;
  final Color color;

  const ProfileItem(this.assetIcon, this.title, this.function, {this.hasLine = true,
    this.color = SmartHomeStyle.color2A29, this.hasArrow = true, Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) => ButtonCustomTransparent(
      function,
      Row(children: [
        Image.asset(assetIcon, width: 15.sp, height: 15.sp),
        Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 11.sp, left: 16.sp),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hasArrow ? Row(children: [
                            Expanded(child:TextCustom(MultiLanguage.get(title), size: 14.sp, color: color)),
                            ButtonCustomTransparent(
                                function,
                                Image.asset('assets/images/theme/ic_arrow_next.png',
                                    height: 15.sp, width: 7.sp),
                                sizeRadius: 15.sp,
                                padding: EdgeInsets.only(
                                    top: 5.sp,
                                    bottom: 5.sp,
                                    left: 9.sp,
                                    right: 9.sp))
                          ]) : TextCustom(MultiLanguage.get(title), size: 14.sp, color: color),
                      SizedBox(height: 11.sp),
                      hasLine ? Divider(height: 5.sp) : Container()
                    ])))
      ]),
      padding: EdgeInsets.only(left: 16.sp, right: 16.sp));
}
