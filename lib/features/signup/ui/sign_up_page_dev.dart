
import 'package:core_advn/common/multi_language.dart';
import 'package:core_advn/common/ui/button_custom_transparent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/header.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/common/ui/theme_textfield.dart';

import '../../../common/smarthome_style.dart';



class SignUpPageDev extends StatelessWidget {
  final TextEditingController ctrEmail, ctrPass, ctrPhone;
  final FocusNode focusEmail, focusPass, focusPhone;
  final Function back, signUp;

  const SignUpPageDev(this.ctrEmail, this.ctrPass, this.focusEmail,
      this.focusPass, this.ctrPhone, this.focusPhone, this.back, this.signUp,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = SmartHomeStyle.getStyle(size: 14.sp, color: Colors.black);
    final hintStyle =
        SmartHomeStyle.getStyle(size: 14.sp, color: const Color(0xFFA3A3A3));
    return Stack(children: [
      SizedBox(width: 1.sw, height: 0.6.sh, child:
      Image.asset('assets/images/theme/6230154.png', fit: BoxFit.fill)
      ),
      ListView(padding: EdgeInsets.zero, children: [
        const HeaderCustom('', color: Colors.white, top: 0),
        Container(
            height: 1.sh - 0.36.sh - ScreenUtil().statusBarHeight - 38.sp,
            margin: EdgeInsets.only(top: 0.36.sh),
            padding: EdgeInsets.fromLTRB(48.sp, 32.sp, 48.sp, 26.sp),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32.sp), topRight: Radius.circular(32.sp))
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextCustom(MultiLanguage.get('btn_sign_up'),
                  size: 24.sp,
                  weight: FontWeight.w500,
                  color: const Color(0xFF434343)),
              SizedBox(height: 16.sp),
              ThemeTextField(ctrPhone, focusPhone, Icons.phone_android, 'Phone',
                  type: TextInputType.phone),
              SizedBox(height: 16.sp),
              ThemeTextField(
                  ctrEmail, focusEmail, Icons.mail_outline_outlined, 'Email',
                  type: TextInputType.emailAddress),
              SizedBox(height: 16.sp),
              ThemeTextField(ctrPass, focusPass, Icons.lock_outline,
                  MultiLanguage.get('lbl_password'),
                  password: true,
                  action: TextInputAction.done,
                  funDone: signUp),
              Container(
                  width: 1.sw,
                  padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 24.sp),
                  child: ButtonCustom(
                    signUp,
                    TextCustom(MultiLanguage.get('btn_sign_up'),
                        size: 18.sp,
                        color: Colors.white,
                        fontFamily: 'Segoe UI',
                        weight: FontWeight.bold),
                    padding: 10.sp,
                    elevation: 0,
                    color: const Color(0xFFCB7120),
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: ButtonCustomTransparent(
                      back,
                      TextCustom(MultiLanguage.get('btn_login'),
                          size: 14.sp,
                          color: SmartHomeStyle.primaryColor,
                          weight: FontWeight.w500),
                      padding: EdgeInsets.all(5.sp))
              )
            ])
        )
      ])
    ]);

  }
}
