
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/common/ui/theme_textfield.dart';
import 'package:smart_home_dev/features/login/login_bloc.dart';




class LoginPageUI extends StatelessWidget {
  final TextEditingController ctrEmail, ctrPass;
  final FocusNode focusEmail, focusPass;
  final LoginBloc bloc;
  final Function signUp, login, forgotPassword, nextPage;
  const LoginPageUI(this.ctrEmail, this.ctrPass, this.focusEmail, this.focusPass, this.bloc,
      this.signUp, this.login, this.forgotPassword, this.nextPage, {Key? key}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFE5E5E5),
          // image: DecorationImage(
          //     image: Image.asset('assets/images/theme3/bg_fruit.jpg').image,
          //     fit: BoxFit.fill
          // )
        ),
        child: Stack(children: [
          Column(children: [
            Expanded(child: Container(height: 1.sh,
                decoration: BoxDecoration(color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24.sp),
                        bottomRight: Radius.circular(24.sp))),
                child: Column(children: [
                  Expanded(child: ListView(
                      padding: EdgeInsets.fromLTRB(24.sp, ScreenUtil().statusBarHeight + 84.sp, 24.sp, 0),
                      children: [
                        TextCustom('Đăng Nhập', size: 24.sp, weight: FontWeight.bold,
                            color: const Color(0xFF4D3E09), fontFamily: 'Segoe UI', align: TextAlign.center),
                        SizedBox(height: 84.sp),
                        ThemeTextField(ctrEmail, focusEmail, Icons.phone_android_outlined, 'Số điện thoại', type: TextInputType.phone),
                        SizedBox(height: 16.sp),
                        ThemeTextField(ctrPass, focusPass, Icons.lock_outline, 'Mật Khẩu',
                            password: true, action: TextInputAction.done, funDone: login),
                        SizedBox(height: 16.sp),
                        FlatButton(onPressed: () => forgotPassword(),
                            child: TextCustom('Quên mật khẩu', size: 14.sp,
                                color: const Color(0xFF515151), fontFamily: 'Segoe UI')),
                      ])),
                  Container(width: 1.sw, padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 0),
                      child: ButtonCustom(login, TextCustom('Đăng Nhập',
                          size: 18.sp, color: Colors.white, fontFamily: 'Segoe UI',
                          weight: FontWeight.bold), padding: 10.sp, elevation: 0,color: Colors.red,)),
                  TextButton(onPressed: () => nextPage(), child: TextCustom('Bỏ qua', size: 14.sp, color: Colors.black))
                ])
            )),
            Padding(padding: EdgeInsets.only(top: 20.sp, bottom: 40.sp), child: TextButton(onPressed: () => signUp(),
                child: TextCustom('Đăng Ký', size: 14.sp,
                    color: const Color(0xFF383838), fontFamily: 'Segoe UI', weight: FontWeight.bold)))
          ]),
          // Constants.showShop ? Padding(padding: EdgeInsets.only(left: 16.sp, top: ScreenUtil().statusBarHeight + 10.sp), child: IconAction(() => CoreUtilUI.goToPage(context, ShopPage()), 'assets/images/ic_arrow_back.png',
          //     width: 22.sp, height: 20.sp, padding: 3.sp, color: ECommerceStyle.color8B, bgColor: Colors.black12)) : const SizedBox()
        ])
    );
  }
}
