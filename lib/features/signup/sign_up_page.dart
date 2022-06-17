import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_home_dev/common/language_key.dart';
import 'package:smart_home_dev/common/model/item_list_model.dart';
import 'package:smart_home_dev/features/signup/sign_up_bloc.dart';
import 'package:smart_home_dev/features/signup/ui/sign_up_page_dev.dart';
import 'package:smart_home_dev/features/signup/ui/sign_up_page_ui.dart';
import 'package:smart_home_dev/features/verify_code/verify_code_page.dart';

import '../../common/ui/base_page_state.dart';

class SignUpPage extends BasePage {
  SignUpPage({Key? key}) : super(_SignUpPageState(), key: key);
}

class _SignUpPageState extends BasePageState {
  final TextEditingController _ctrEmail = TextEditingController();
  final TextEditingController _ctrPhone = TextEditingController();
  final TextEditingController _ctrPass = TextEditingController();
  final FocusNode _focusPhone = FocusNode();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();
  String deviceId = '';

  @override
  void dispose() {
    _focusEmail.dispose();
    _ctrEmail.dispose();
    _focusPhone.dispose();
    _ctrPhone.dispose();
    _focusPass.dispose();
    _ctrPass.dispose();
    super.dispose();
  }

  @override
  Widget createUI(BuildContext context) => SignUpPageDev(_ctrEmail, _ctrPass,
      _focusEmail, _focusPass, _ctrPhone, _focusPhone, back, _signUp);

  @override
  void initBloc() {
    bloc = SignUpBloc();
    bloc?.stream.listen((state) {
      // if (state is FinishSignUpState || state is SignUpOthersState)
      //   _handleSignUp(state);
      // else if (state is CheckDuplicatePhoneState && checkResponse(state.response, passString: true))
      //   CoreUtilUI.goToPage(context, VerifyCodePage(_ctrEmail.text), hasBack: true, callback: _finishSignUp);
    });
  }

  @override
  void initUI() {}

  void _signUp() {
    clearFocus();
    if (_ctrEmail.text.isEmpty) {
      CoreUtilUI.showCustomAlertDialog(
              context, MultiLanguage.get(LanguageKey.msgInputPhoneNumber))
          .then((value) => _focusEmail.requestFocus());
      return;
    }

    if (_ctrPass.text.isEmpty) {
      CoreUtilUI.showCustomAlertDialog(
              context, MultiLanguage.get(LanguageKey.msgInputPassword))
          .then((value) => _focusPass.requestFocus());
      return;
    }
    // bloc?.add(CheckDuplicatePhoneEvent(_ctrEmail.text));
    CoreUtilUI.goToPage(context, VerifyCodePage(_ctrPhone.text),
        hasBack: true, callback: _finishSignUp);
  }

  void _finishSignUp(dynamic result) {
    result != null &&
            result is ItemModel &&
            result.id.replaceFirst('+84', '0') == _ctrPhone.text
        ? _confirmSignUp(_ctrEmail.text, _ctrPass.text)
        : CoreUtilUI.showCustomAlertDialog(
            context, MultiLanguage.get(LanguageKey.msgVerifyFail));
  }

  void _confirmSignUp(String email, String pass) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      print("Created New Account");
      CoreUtilUI.showCustomAlertDialog(
              context, MultiLanguage.get(LanguageKey.msgSignUpSuccess),
              title: MultiLanguage.get(LanguageKey.ttlNotify))
          .then((value) => SharedPreferences.getInstance().then((prefs) {
                back();
              }));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  void _signUpWithGoogle() => bloc?.add(const SignUpOthersEvent('google'));

  void _signUpWithFacebook() => bloc?.add(const SignUpOthersEvent('facebook'));

  void _signUpWithAppleID() => bloc?.add(const SignUpOthersEvent('apple'));

  // void _signupSuccess() => UtilUI.showCustomAlertDialog(context,
  //     MultiLanguage.get(LanguageKey.msgSignUpSuccess),
  //     title: MultiLanguage.get(CoreLanguageKey.ttlInfo)).then((value) =>
  //     SharedPreferences.getInstance().then((prefs) {
  //       prefs.remove('hash');
  //       back();
  //     }));

  void _handleSignUp(dynamic state) {
    // if (checkResponse(state.response)) _signupSuccess();
  }
}
