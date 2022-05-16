
import 'package:core_advn/common/ui/import_base_ui_lib.dart';
import 'package:smart_home_dev/common/constants.dart';

class FinishSignUpState extends BaseState {
  final BaseResponse response;
  const FinishSignUpState(this.response);
}
class FinishSignUpEvent extends BaseEvent {
  final String phone;
  final String pass;
  const FinishSignUpEvent(this.phone, this.pass);
}

class SignUpOthersState extends BaseState {
  final BaseResponse response;
  const SignUpOthersState(this.response);
}
class SignUpOthersEvent extends BaseEvent {
  final String type;
  const SignUpOthersEvent(this.type);
}

class CheckDuplicatePhoneState extends BaseState {
  final BaseResponse response;
  const CheckDuplicatePhoneState(this.response);
}
class CheckDuplicatePhoneEvent extends BaseEvent {
  final String phone;
  const CheckDuplicatePhoneEvent(this.phone);
}

class SignUpBloc extends BaseBloc {
  SignUpBloc() {
    on<CheckDuplicatePhoneEvent>((event, emit) async {
      emit(const BaseState(showLoading: true));
      final response = await ApiClient().postAPI(
          '${Constants.apiVersion}account/check_duplicate', 'POST', BaseResponse(),
          hasHeader: false, body: { 'phone': event.phone });
      emit(CheckDuplicatePhoneState(response));
    });
    on<FinishSignUpEvent>((event, emit) async {
      emit(const BaseState(showLoading: true));
      String hash = '';
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('hash')) hash = prefs.getString('hash')!;
      final response = await ApiClient().postAPI(
          '${Constants.apiVersion}account/register', 'POST', BaseResponse(), hasHeader: false,
          body: {
            'phone': event.phone,
            'name': event.phone,
            'password': event.pass,
            'password_confirmation': event.pass,
            'affiliate': hash
          });
      emit(FinishSignUpState(response));
    });
    on<SignUpOthersEvent>((event, emit) async {
      // String email = '';
      // switch(event.type) {
      //   case 'facebook': email = await Util.signInWithFaceBook(); break;
      //   case 'google': email = await Util.signInWithGoogle(); break;
      //   default: email = await Util.signInWithAppleID();
      // }
      // emit(const BaseState(showLoading: true));
      // if (email.isNotEmpty) {
      //   String hash = '';
      //   final prefs = await SharedPreferences.getInstance();
      //   if (prefs.containsKey('hash')) hash = prefs.getString('hash')!;
      //   final response = await ApiClient().postAPI(
      //       '${Constants.apiVersion}account/register_with_others', 'POST', UserModel(),
      //       hasHeader: false,
      //       body: {
      //         'email': email,
      //         'partner_type': event.type,
      //         'affiliate': hash
      //       });
      //   emit(SignUpOthersState(response));
      // } else emit(const BaseState());
    });
  }
}