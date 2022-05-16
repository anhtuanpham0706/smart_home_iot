
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/common/ui/theme_textfield.dart';



class SignUpPageUI extends StatelessWidget {
  final TextEditingController ctrEmail, ctrPass;
  final FocusNode focusEmail, focusPass;
  final Function back, signUp;
  const SignUpPageUI(this.ctrEmail, this.ctrPass, this.focusEmail, this.focusPass,
      this.back, this.signUp,{Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:const BoxDecoration(
          color: Color(0xFFE5E5E5),
          // image: DecorationImage(
          // image: Image.asset('assets/images/theme3/bg_fruit.jpg').image, fit: BoxFit.fill)
        ),
        child: Column(children: [
          Expanded(child: Container(height: 1.sh,
              decoration: BoxDecoration(color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24.sp),
                      bottomRight: Radius.circular(24.sp))),
              child: Column(children: [
                Expanded(child: ListView(
                    padding: EdgeInsets.fromLTRB(24.sp, ScreenUtil().statusBarHeight + 84.sp, 24.sp, 0),
                    children: [
                      TextCustom('Đăng Ký', size: 24.sp, weight: FontWeight.bold,
                          color: const Color(0xFF4D3E09), fontFamily: 'Segoe UI', align: TextAlign.center),
                      SizedBox(height: 84.sp),
                      ThemeTextField(ctrEmail, focusEmail, Icons.phone_android_outlined, 'Số điện thoại', type: TextInputType.phone),
                      SizedBox(height: 16.sp),
                      ThemeTextField(ctrPass, focusPass, Icons.lock_outline, 'Mật khẩu',
                          password: true, action: TextInputAction.done, funDone: signUp),
                    ])),
                Container(width: 1.sw, padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 24.sp),
                    child: ButtonCustom(signUp, TextCustom('Đăng Ký',
                        size: 18.sp, color: Colors.white, fontFamily: 'Segoe UI',
                        weight: FontWeight.bold), padding: 10.sp, elevation: 0,color: Colors.red,))
              ])
          )),
          Padding(padding: EdgeInsets.only(top: 20.sp, bottom: 40.sp), child:
          TextButton(onPressed: () => back(),
              child: TextCustom('Đăng nhập', size: 14.sp,
                  color: const Color(0xFF383838), fontFamily: 'Segoe UI', weight: FontWeight.bold)))
        ])
    );

  }
}
