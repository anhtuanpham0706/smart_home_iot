




import 'package:smart_home_dev/features/signup/sign_up_bloc.dart';
import 'package:smart_home_dev/features/signup/ui/sign_up_page_dev.dart';
import 'package:smart_home_dev/features/signup/ui/sign_up_page_ui.dart';

import '../../common/ui/base_page_state.dart';


class SignUpPage extends BasePage {
  SignUpPage({Key? key}) : super(_SignUpPageState(), key: key);
}

class _SignUpPageState extends BasePageState {
  final TextEditingController _ctrEmail = TextEditingController();
  final TextEditingController _ctrPass = TextEditingController();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();
  String deviceId = '';

  @override
  void dispose() {
    _focusEmail.dispose();
    _ctrEmail.dispose();
    _focusPass.dispose();
    _ctrPass.dispose();
    super.dispose();
  }

  @override
  Widget createUI(BuildContext context) =>
      SignUpPageDev(_ctrEmail, _ctrPass, _focusEmail,
      _focusPass, back, _signUp);

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
    // if (_ctrEmail.text.isEmpty) {
    //   UtilUI.showCustomAlertDialog(context, MultiLanguage.get(LanguageKey.msgInputPhoneNumber))
    //       .then((value) => _focusEmail.requestFocus());
    //   return;
    // }
    //
    // if (_ctrPass.text.isEmpty) {
    //   UtilUI.showCustomAlertDialog(context, MultiLanguage.get(LanguageKey.msgInputPassword))
    //       .then((value) => _focusPass.requestFocus());
    //   return;
    // }
    // bloc?.add(CheckDuplicatePhoneEvent(_ctrEmail.text));
  }

  void _finishSignUp(dynamic result) {
    // result != null && result is ItemModel && result.id.replaceFirst('+84', '0') == _ctrEmail.text ?
    // bloc?.add(FinishSignUpEvent(_ctrEmail.text, _ctrPass.text))
    //     : UtilUI.showCustomAlertDialog(context, MultiLanguage.get(LanguageKey.msgVerifyFail));
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
