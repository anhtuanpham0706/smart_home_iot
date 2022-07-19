


import 'package:core_advn/common/multi_language.dart';
import 'package:core_advn/common/ui/button_custom_transparent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/language_key.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/header.dart';
import 'package:smart_home_dev/common/ui/theme_textfield.dart';
import 'package:smart_home_dev/features/login/login_bloc.dart';

import '../../../common/ui/text_custom.dart';

class LoginPageDev extends StatelessWidget {
  final TextEditingController ctrEmail, ctrPass;
  final FocusNode focusEmail, focusPass;
  final LoginBloc bloc;
  final Function signUp, login, forgotPassword, nextPage;
  const LoginPageDev(this.ctrEmail, this.ctrPass, this.focusEmail, this.focusPass, this.bloc,
      this.signUp, this.login, this.forgotPassword, this.nextPage, {Key? key}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    final textStyle = SmartHomeStyle.getStyle(size: 14.sp, color: Colors.black);
    final hintStyle =
    SmartHomeStyle.getStyle(size: 14.sp, color: const Color(0xFFA3A3A3));
    return Stack(children: [
      SizedBox(width: 1.sw, height: 0.6.sh, child:
      Image.asset('assets/images/theme/6230147.png', fit: BoxFit.fill)
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
              TextCustom('Đăng nhập',
                  size: 24.sp,
                  weight: FontWeight.w500,
                  color: const Color(0xFF434343)),
              SizedBox(height: 16.sp),
              ThemeTextField(ctrEmail, focusEmail, Icons.email, 'Email',
                  type: TextInputType.emailAddress),
              SizedBox(height: 16.sp),
              ThemeTextField(ctrPass, focusPass, Icons.lock_outline, 'Mật Khẩu',
                  password: true, action: TextInputAction.done, funDone: login),
              Container(
                  width: 1.sw,
                  padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 0),
                  child: ButtonCustom(
                    login,
                    TextCustom(MultiLanguage.get(LanguageKey.btnLogin),
                        size: 18.sp,
                        color: Colors.white,
                        fontFamily: 'Segoe UI',
                        weight: FontWeight.bold),
                    padding: 10.sp,
                    elevation: 0,
                    color: SmartHomeStyle.primaryColor,
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ButtonCustomTransparent(
                    forgotPassword,
                    TextCustom(MultiLanguage.get(LanguageKey.btnForgot),
                        size: 14.sp,
                        color: SmartHomeStyle.primaryColor,
                        weight: FontWeight.w500),
                    padding: EdgeInsets.all(5.sp)),
                ButtonCustomTransparent(
                    signUp,
                    TextCustom(MultiLanguage.get('btn_sign_up'),
                        size: 14.sp,
                        color: SmartHomeStyle.primaryColor,
                        weight: FontWeight.w500),
                    padding: EdgeInsets.all(5.sp)),
                // TextButton(
                //     onPressed: () => nextPage(),
                //     child: TextCustom('Bỏ qua',
                //         size: 14.sp, color: SmartHomeStyle.primaryColor))
              ]),
              // LoginWithOthers(signInWithFaceBook, signInWithGoogle, signInWithAppleID,
              //     title: TextCustom(MultiLanguage.get('lbl_or_food'), size: 14.sp,
              //         color: const Color(0xFFABABAB)), top: 24.sp, size: 34.sp)
            ])
        )
      ])
    ]);
  }
}
