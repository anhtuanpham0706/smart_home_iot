


import 'package:core_advn/common/ui/base_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/ui/icon_action.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';

class HeaderCustom extends StatelessWidget {
  final String keyTitle;
  final Color? color, bgColor;
  final Function? funBack, funMenu;
  final double? size, top;
  final Widget? menu;
  final bool hasBack, hasMenu;
  const HeaderCustom(this.keyTitle, {this.color, this.bgColor, this.funBack, this.funMenu, this.size, this.menu,
    this.hasBack = true, this.hasMenu = false, this.top, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(color: bgColor,
      padding: EdgeInsets.fromLTRB(16.sp, ScreenUtil().statusBarHeight + (top??20.sp), 16.sp, 16.sp),
      child: Row(children: [
        hasBack ? IconAction(funBack??() => CoreUtilUI.goBack(context, false),
            'assets/images/theme/ic_arrow_back.png', width: 22.sp, height: 22.sp, padding: 3.sp, color: color) : const SizedBox(),
        Expanded(child: Container(
            padding: EdgeInsets.only(left: hasBack ? 10.sp : 0),
            child: TextCustom(keyTitle, weight: FontWeight.w500,
                size: size??18.sp, color: color??const Color(0xFF414141), maxLine: 1))),
        hasMenu ? (menu??IconAction(funMenu!, 'assets/images/theme/ic_menu.png',
            width: 22.sp, height: 22.sp, padding: 3.sp, color: color??const Color(0xFF414141))) : const SizedBox()
      ]));
}