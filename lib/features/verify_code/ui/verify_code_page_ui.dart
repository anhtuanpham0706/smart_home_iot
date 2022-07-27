



import 'package:core_advn/common/ui/button_custom_transparent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/language_key.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/header.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/features/verify_code/verify_code_bloc.dart';

import '../../../common/ui/base_page_state.dart';

class VerifyCodePageUI extends StatelessWidget {
  final TextEditingController ctrNum;
  final String phone;
  final int countDown;
  final Function back, confirm, resend;
  final VerifyCodeBloc bloc;

  const VerifyCodePageUI(this.ctrNum, this.phone, this.countDown, this.bloc,
      this.back, this.confirm, this.resend, {Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HeaderCustom(MultiLanguage.get(LanguageKey.ttlVerifyPhone),
          funBack: back),
      Padding(
          padding: EdgeInsets.only(
              top: 16.sp, bottom: 4.sp, left: 0.20.sw, right: 0.20.sw),
          child: TextCustom(MultiLanguage.get(LanguageKey.msgEnter6Digits),
              size: 14.sp,
              align: TextAlign.center,
              color: const Color(0xFF2A2929))),
      TextCustom(MultiLanguage.get(LanguageKey.lblSendTo) + phone,
          size: 12.sp, align: TextAlign.center, color: const Color(0xFF7B7B7B)),
      BlocBuilder(
          bloc: bloc,
          buildWhen: (oldState, newState) =>
              newState is ValidateNumVerifyCodeState,
          builder: (context, state) =>
              state is! ValidateNumVerifyCodeState || !state.invalid
                  ? SizedBox(height: 32.sp)
                  : Container()),
      BlocBuilder(bloc: bloc,
          buildWhen: (oldState, newState) => newState is ValidateNumVerifyCodeState,
          builder: (context, state) => state is ValidateNumVerifyCodeState && state.invalid
              ? Padding(padding: EdgeInsets.only(top: 25.sp, bottom: 16.sp),
              child: TextCustom(
                          MultiLanguage.get(LanguageKey.msgInvalidCode),
                          size: 12.sp,
                          align: TextAlign.center,
                          color: Colors.red))
              : Container()),
      Padding(padding: EdgeInsets.fromLTRB(20.sp, 0, 20.sp, 17.sp), child: TextField(controller: ctrNum,
          style: TextStyle(color: const Color(0xFF6B6B6B), fontSize: 18.sp, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center, keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done, onSubmitted: (value) => confirm(), maxLength: 6,
          decoration: InputDecoration(
              counterText: '', hintText: 'OTP',
              hintStyle: TextStyle(color: const Color(0xFF6B6B6B), fontSize: 18.sp, fontWeight: FontWeight.w500),
              contentPadding: const EdgeInsets.all(0),
              filled: true, fillColor: const Color(0xFFF7F8F9),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFF7F8F9)),
                  borderRadius: BorderRadius.circular(50.sp)
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.sp)),
              errorText: ctrNum.text.isNotEmpty && ctrNum.text.length != 6 ? '' : null
          )
      )),
      BlocBuilder(bloc: bloc,
          buildWhen: (oldState, newState) => newState is CountDownVerifyCodeState,
          builder: (context, state) {
            int count = countDown;
            if (state is CountDownVerifyCodeState) count = state.count;
            return TextCustom(
                count.toString() + MultiLanguage.get(LanguageKey.lblSecond),
                size: 14.sp,
                align: TextAlign.center,
                color: const Color(0xFF7B7B7B));
          }),
      Expanded(child: SizedBox(height: 24.sp)),
      BlocBuilder(bloc: bloc,
          buildWhen: (oldState, newState) => newState is ShowResendVerifyCodeState,
          builder: (context, state) => state is ShowResendVerifyCodeState && state.show ?
          TextCustom(MultiLanguage.get(LanguageKey.msgDidNotReceiveCode),
                  size: 14.sp,
                  align: TextAlign.center,
                  color: const Color(0xFF7B7B7B))
              : const SizedBox()),
      BlocBuilder(bloc: bloc,
          buildWhen: (oldState, newState) => newState is ShowResendVerifyCodeState,
          builder: (context, state) => state is ShowResendVerifyCodeState && state.show ?
          ButtonCustomTransparent(
                      resend,
                      TextCustom(MultiLanguage.get(LanguageKey.btnResend),
                          size: 14.sp, color: Colors.red),
                      padding: EdgeInsets.all(4.sp))
                  : const SizedBox()),
      Container(
          width: 1.sw,
          padding: EdgeInsets.all(20.sp),
          child: ButtonCustom(
            confirm,
            TextCustom(MultiLanguage.get(LanguageKey.btnConfirm),
                size: 16.sp, weight: FontWeight.w500),
            elevation: 0,
            color: SmartHomeStyle.primaryColor,
          ))
    ]);
    }
  }
