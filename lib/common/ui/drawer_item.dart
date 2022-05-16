
import 'package:core_advn/common/ui/button_custom_transparent.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';

import 'text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DrawerItem extends StatelessWidget {
  final String asset, title;
  final bool isActive;
  final Function function;
  const DrawerItem(this.function, this.asset, this.title, this.isActive, {Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {

        return ButtonCustomTransparent(function, Column(children:[
          Row(children: [
            Padding(padding: EdgeInsets.only(left: 26.sp, right: 18.sp), child: Image.asset(asset,
                width: 16.sp, height: 16.sp, color: SmartHomeStyle.primaryColor)),
            Expanded(child: TextCustom(title, size: 14.sp, weight: FontWeight.w500,
                color: isActive ? SmartHomeStyle.primaryColor : const Color(0xFF3A3A3A))),
            SizedBox(width: 24.sp)
          ]),
          Container(padding: EdgeInsets.fromLTRB(60.sp, 16.sp, 24.sp, 0),
              child: const Divider(height: 1, color: Color(0xFFE8E8E8)))
        ]), padding: EdgeInsets.only(top: 16.sp));
    }

}
