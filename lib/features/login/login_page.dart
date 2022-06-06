
import 'package:core_advn/common/ui/base_page.dart';
import 'package:smart_home_dev/common/ui/base_page_state.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';
import 'package:smart_home_dev/features/login/login_bloc.dart';
import 'package:smart_home_dev/features/login/ui/login_page_dev.dart';
import 'package:smart_home_dev/features/login/ui/login_page_ui.dart';
import 'package:smart_home_dev/features/main/main_page.dart';
import 'package:smart_home_dev/features/signup/sign_up_page.dart';
import 'package:smart_home_dev/features/test_features/test_notifine.dart';


class LoginPage extends BasePage {
  LoginPage({Key? key}) : super(_LoginPageState(), key: key);
}

class _LoginPageState extends BasePageState {
  final TextEditingController _ctrEmail = TextEditingController();
  final TextEditingController _ctrPass = TextEditingController();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();







  void _signUp() {
    UtilUI.goToPage(context, SignUpPage(), hasBack: true);
  }

  void _forgotPassword({String initValue = ''}) {
    // UtilUI.showConfirmDialog(context, initValue: initValue, title: MultiLanguage.get(LanguageKey.msgForgetPass), isActionCancel: true).then((value) {
    //   if (value != null && value is String) {
    //     if (value.isEmpty)
    //       UtilUI.showCustomAlertDialog(context, MultiLanguage.get(LanguageKey.msgPhoneEmpty)).then((value) => _forgotPassword());
    //     else {
    //       UtilUI.goToPage(context, VerifyCodePage(value, type: widget.runtimeType.toString()),
    //           hasBack: true, callback: _forgetPasswordVerifyCallback);
    //     }
    //   }
    // });
  }


  void _forgetPasswordVerifyCallback(dynamic value) {
    // if(value != null && value is ItemModel) UtilUI.goToPage(context, PasswordPage(update: value), hasBack: true);
  }

  void _login() {
    // if (_lock) return;
    //
    // clearFocus();
    // if (_ctrEmail.text.isEmpty) {
    //   UtilUI.showCustomAlertDialog(
    //       context, MultiLanguage.get(LanguageKey.msgInputPhoneNumber))
    //       .then((value) => _focusEmail.requestFocus());
    //   return;
    // }
    //
    // if (_ctrPass.text.isEmpty) {
    //   UtilUI.showCustomAlertDialog(
    //       context, MultiLanguage.get(LanguageKey.msgInputPassword))
    //       .then((value) => _focusPass.requestFocus());
    //   return;
    // }
    // _lock = true;
    // Util.getDeviceInfo().then((info) {
    //   deviceId = info['device']!;
    //   if (deviceId.isEmpty || info['token']!.isEmpty) {
    //     _lock = false;
    //     UtilUI.showCustomAlertDialog(
    //         context, MultiLanguage.get(LanguageKey.msgErrorGetDeviceId));
    //     Util.clearFirebaseToken();
    //   } else bloc?.add(SaveDeviceLoginEvent(info));
    // });
  }

  // void _nextPage() => UtilUI.goToPage(context, MainPage());
  //
  // void _signInWithAppleID() => bloc?.add(const SignInOthersEvent('apple'));
  // void _signInWithGoogle() => bloc?.add(const SignInOthersEvent('google'));
  // void _signInWithFaceBook() => bloc?.add(const SignInOthersEvent('facebook'));
  //
  // void _handleSignInWith(dynamic state) {
  //   if (checkResponse(state.response)) UtilUI.saveInfo(state.response.data, saveAccount: true, context: context, nextPage: MainPage());
  // }


  // @override
  // Widget build(BuildContext context, {Color color = Colors.white}) =>
  //     Container(child: LoginPageUI(_ctrEmail, _ctrPass, _focusEmail, _focusPass,
  //         bloc as LoginBloc, _signUp, _login, _forgotPassword, _nextPage, _signInWithAppleID,
  //         _signInWithGoogle, _signInWithFaceBook), color: color);

  @override
  Widget createUI(BuildContext context) =>
      LoginPageDev(_ctrEmail, _ctrPass, _focusEmail, _focusPass,
      bloc as LoginBloc, _signUp, _login, _forgotPassword, _nextPage
      );


  @override
  void initBloc() {
    bloc = LoginBloc();
    // bloc?.stream.listen((state) {
    //   if (state is SaveDeviceLoginState) {
    //     if (checkResponse(state.response))
    //       bloc?.add(ContinueLoginEvent(_ctrEmail.text, _ctrPass.text, deviceId));
    //     else _lock = false;
    //   } else if (state is FinishLoginState) {
    //     _lock = false;
    //     if (checkResponse(state.response)) {
    //       state.response.data.key_login = _ctrEmail.text;
    //       state.response.data.password = _ctrPass.text;
    //       UtilUI.saveInfo(state.response.data, saveAccount: true, context: context, nextPage: MainPage());
    //     }
    //   } else if (state is SignInOthersState) _handleSignInWith(state);
    // });
  }
  void _nextPage() => CoreUtilUI.goToPage(context, TestNotification());

  @override
  void initUI() {
    // TODO: implement initUI
  }



}
