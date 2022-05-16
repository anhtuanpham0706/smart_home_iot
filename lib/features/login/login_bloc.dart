
import 'package:core_advn/common/base_bloc.dart';
import 'package:core_advn/common/base_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_dev/common/constants.dart';

class ChangeRememberLoginState extends BaseState {
  final bool isRemember;
  const ChangeRememberLoginState(this.isRemember);
}
class ChangeRememberLoginEvent extends BaseEvent {
  final bool isRemember;
  const ChangeRememberLoginEvent(this.isRemember);
}

class SaveDeviceLoginState extends BaseState {
  final BaseResponse response;
  const SaveDeviceLoginState(this.response, bool loading):super(showLoading: loading);
}

class SaveDeviceLoginEvent extends BaseEvent {
  final Map<String, String> info;
  const SaveDeviceLoginEvent(this.info);
}

class FinishLoginState extends BaseState {
  final BaseResponse response;
  const FinishLoginState(this.response);
}
class ContinueLoginEvent extends BaseEvent {
  final String key;
  final String pass;
  final String device;
  const ContinueLoginEvent(this.key, this.pass, this.device);
}

class ForgetPassLoginState extends BaseState {
  final BaseResponse response;
  final String phone;
  const ForgetPassLoginState(this.response, this.phone);
}
class ForgetPassLoginEvent extends BaseEvent {
  final String key;
  const ForgetPassLoginEvent(this.key);
}

class SignInOthersEvent extends BaseEvent {
  final String type;
  const SignInOthersEvent(this.type);
}
class SignInOthersState extends BaseState {
  final BaseResponse response;
  const SignInOthersState(this.response);
}

class LoginBloc extends BaseBloc {
  LoginBloc() {
    on<ForgetPassLoginEvent>((event, emit) async {
      on<ChangeRememberLoginEvent>((event, emit) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool(Constants.isRemember, event.isRemember);
        emit(ChangeRememberLoginState(event.isRemember));
      });
      // on<SaveDeviceLoginEvent>((event, emit) async {
      //   emit(const BaseState(showLoading: true));
      //   final response = await _saveDevice(event.info);
      //   emit(SaveDeviceLoginState(response, response.checkOK()));
      // });
      // on<ContinueLoginEvent>((event, emit) async {
      //   emit(const BaseState(showLoading: true));
      //   final response = await ApiClient().postAPI(
      //       '${Constants.apiVersion}account/login', 'POST', UserModel(),
      //       hasHeader: false,
      //       body: {
      //         'loginkey': event.key,
      //         'password': event.pass,
      //         'device_id': event.device
      //       });
      //   emit(FinishLoginState(response));
      // });

      // emit(const BaseState(showLoading: true));
      // final response = await ApiClient().postAPI('${Constants.apiVersion}account/forget_password', 'POST', BaseResponse(), hasHeader: false, body: {
      //   'loginkey': event.key
      // });
      // emit(ForgetPassLoginState(response, event.key));
    });
    // on<SignInOthersEvent>((event, emit) async {
    //   emit(const BaseState(showLoading: true));
    //   final info = await Util.getDeviceInfo();
    //   if (info['device']!.isEmpty || info['token']!.isEmpty) {
    //     Util.clearFirebaseToken();
    //     emit(SignInOthersState(BaseResponse(data: MultiLanguage.get(LanguageKey.msgErrorGetDeviceId))));
    //     return;
    //   }
    //
    //   final response = await _saveDevice(info);
    //   if (response.checkOK()) {
    //     emit(const BaseState(showLoading: false));
    //     String email = '';
    //     switch(event.type) {
    //       case 'facebook': email = await Util.signInWithFaceBook(); break;
    //       case 'google': email = await Util.signInWithGoogle(); break;
    //       default: email = await Util.signInWithAppleID();
    //     }
    //     if (email.isNotEmpty) {
    //       emit(const BaseState(showLoading: true));
    //       final responseFinish = await ApiClient().postAPI(
    //           '${Constants.apiVersion}account/login_with_others', 'POST',
    //           UserModel(), hasHeader: false,
    //           body: {
    //             'email': email,
    //             'partner_type': event.type,
    //             'device_id': info['device']!
    //           });
    //       emit(SignInOthersState(responseFinish));
    //     }
    //   } else emit(SignInOthersState(response));
    // });
  }
// Future<BaseResponse> _saveDevice(info) => ApiClient().postAPI(
//     '${Constants.apiVersion}devices', 'POST', DeviceModel(), hasHeader: false,
//     body: {
//       'device_id': info['device'],
//       'device_name': info['name'],
//       'device_type': info['type'],
//       'os_version': info['os'],
//       'app_version': info['version'],
//       'device_token': info['token']
//     });
}