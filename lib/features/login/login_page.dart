import 'package:core_advn/common/ui/base_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_home_dev/common/language_key.dart';
import 'package:smart_home_dev/common/ui/base_page_state.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';
import 'package:smart_home_dev/features/login/login_bloc.dart';
import 'package:smart_home_dev/features/login/ui/login_page_dev.dart';
import 'package:smart_home_dev/features/login/ui/login_page_ui.dart';
import 'package:smart_home_dev/features/main/main_page.dart';
import 'package:smart_home_dev/features/signup/sign_up_page.dart';
import 'package:smart_home_dev/features/test_notification/test_noti_page.dart';

class LoginPage extends BasePage {
  LoginPage({Key? key}) : super(_LoginPageState(), key: key);
}

class _LoginPageState extends BasePageState {
  final TextEditingController _ctrEmail = TextEditingController();
  final TextEditingController _ctrPass = TextEditingController();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();

  @override
  void dispose() {
    _focusEmail.dispose();
    _ctrEmail.dispose();
    _focusPass.dispose();
    _ctrPass.dispose();
    super.dispose();
  }

  void _signUp() {
    UtilUI.goToPage(context, SignUpPage(), hasBack: true);
  }

  void _forgotPassword({String initValue = ''}) {
    UtilUI.showConfirmDialog(context,
            initValue: initValue,
            title: MultiLanguage.get(LanguageKey.msgForgetPass),
            isActionCancel: true)
        .then((value) {
      if (value != null && value is String) {
        if (value.isEmpty) {
          UtilUI.showCustomAlertDialog(
                  context, MultiLanguage.get(LanguageKey.msgPhoneEmpty))
              .then((value) => _forgotPassword());
        }
      }
    });
  }

  void _forgetPasswordVerifyCallback(dynamic value) {
    // if(value != null && value is ItemModel) UtilUI.goToPage(context, PasswordPage(update: value), hasBack: true);
  }

  void _login() {
    clearFocus();
    if (_ctrEmail.text.isEmpty) {
      UtilUI.showCustomAlertDialog(
              context, MultiLanguage.get(LanguageKey.msgInputPhoneNumber))
          .then((value) => _focusEmail.requestFocus());
      return;
    }

    if (_ctrPass.text.isEmpty) {
      UtilUI.showCustomAlertDialog(
              context, MultiLanguage.get(LanguageKey.msgInputPassword))
          .then((value) => _focusPass.requestFocus());
      return;
    }
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _ctrEmail.text, password: _ctrPass.text)
        .then((value) {
          print(value.toString());
          UtilUI.saveInfo('state.response.data',
              saveAccount: true, context: context, nextPage: MainPage());
        })
        .catchError((error) {})
        .onError((error, stackTrace) {});
  }

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
    _ctrEmail.text = ' ';
    _ctrPass.text = ' ';
    SharedPreferences.getInstance().then((prefs) {
      _ctrEmail.text = '';
      _ctrPass.text = '';
      prefs.setBool(Constants.isRemember, true);
      if (prefs.containsKey(Constants.isRemember)) {
        bool remember = prefs.getBool(Constants.isRemember)!;
        bloc?.add(ChangeRememberLoginEvent(remember));
        if (remember) {
          if (prefs.containsKey(Constants.keyLogin))
            _ctrEmail.text = prefs.getString(Constants.keyLogin)!;
          if (prefs.containsKey(Constants.keyPassword))
            _ctrPass.text = prefs.getString(Constants.keyPassword)!;
        }
      }
    });
  }
}
