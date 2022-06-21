
import 'dart:async';

import 'package:core_advn/common/ui/base_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_home_dev/common/language_key.dart';
import 'package:smart_home_dev/common/model/item_list_model.dart';
import 'package:smart_home_dev/common/ui/base_page_state.dart';
import 'package:smart_home_dev/features/verify_code/ui/verify_code_page_ui.dart';
import 'package:smart_home_dev/features/verify_code/verify_code_bloc.dart';

class VerifyCodePage extends BasePage {
  final String phone, type;
  VerifyCodePage(this.phone, {Key? key, this.type = 'VerifyCodePage'}) : super(_VerifyCodePageState(), key: key);
}

class _VerifyCodePageState extends BasePageState {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _ctrNum = TextEditingController();
  int _countDown = 90, _totalSend = 0;
  Timer? _timer;
  String verificationId = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _ctrNum.dispose();
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget createUI(BuildContext context) => VerifyCodePageUI(
      _ctrNum,
      (widget as VerifyCodePage).phone,
      _countDown,
      bloc as VerifyCodeBloc,
      back,
      _signInFirebase,
      _resend);

  @override
  void initBloc() {
    bloc = VerifyCodeBloc();
    bloc?.stream.listen((state) {
      // if (state is CheckVerifyCodeState) {
      //   back(
      //       value: ItemModel(
      //           id: (widget as VerifyCodePage).phone,
      //           name: _ctrNum.text,
      //           select: true));
      // } else if (state is ForgetPassVerifyCodeState &&
      //    checkResponse(state.response)) _setCountDown();
      if (state is ShowLoadingState)
        _isLoading = state.showLoading;
      else if (state is ShowResendVerifyCodeState && state.show)
        _isLoading = false;
    });
    _setCountDown();
  }

  @override
  void initUI() => _resend();

  void _setCountDown() {
    bloc?.add(const ShowResendVerifyCodeEvent(false));
    _countDown = 90;
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
      _timer = null;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer value) {
      _countDown--;
      bloc?.add(CountDownVerifyCodeEvent(_countDown, _isLoading));
      if (_countDown <= 0) {
        bloc?.add(const ShowResendVerifyCodeEvent(true));
        value.cancel();
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  void _confirm() => bloc?.add(
      CheckVerifyCodeEvent((widget as VerifyCodePage).phone, _ctrNum.text));

  //void _resend() {
  //final page = widget as VerifyCodePage;
  //if (page.type != page.runtimeType.toString())
  //  bloc.add(ForgetPassVerifyCodeEvent(page.phone));
  //}

  void _resend() {
    if (_totalSend == 3) {
      // _showMessage(LanguageKey.msgTooManyRequests);
      return;
    }
    _totalSend ++;
    _setCountDown();
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      verificationId = verId;
    };
    _auth.verifyPhoneNumber(
        phoneNumber: '+84${(widget as VerifyCodePage).phone}',
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
        codeSent: smsOTPSent,
        timeout: const Duration(seconds: 80),
        verificationCompleted: (AuthCredential phoneAuthCredential) {},
        verificationFailed: (e) {
          _countDown = 1;
          // _showMessage(e.toString().contains('blocked all requests') ?
          // LanguageKey.msgTooManyRequests : LanguageKey.msgSendSMSFail);
        }
    );
  }

  void _signInFirebase() {
    bloc?.add(const ShowLoadingEvent(value: true));
    int otp = 0;
    try {
      otp = int.parse(_ctrNum.text);
    }
    catch(_) {}
    if (otp < 100000 || _ctrNum.text.length != 6) {
      _showMessage(LanguageKey.msgInvalidCode);
      return;
    }

    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: _ctrNum.text,
    );
    _auth.signInWithCredential(credential).then((user) {
      bloc?.add(const ShowLoadingEvent());
      if (user.user != null) {
        final page = widget as VerifyCodePage;
        back(value: ItemModel(id: user.user?.phoneNumber??'', name: user.user?.uid??'', select: page.type != page.runtimeType.toString()));
      } else {
        // _showMessage(LanguageKey.msgVerifyFail);
      }
    }).catchError((e) {
      // _showMessage(LanguageKey.msgVerifyFail);
    });
  }

  void _showMessage(String msg) =>
      CoreUtilUI.showCustomAlertDialog(context, MultiLanguage.get(msg))
          .then((value) => bloc?.add(const ShowLoadingEvent()));
}
