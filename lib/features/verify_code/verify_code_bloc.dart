


import '../../common/ui/base_page_state.dart';

class ShowLoadingState extends BaseState {
  const ShowLoadingState(bool loading) : super(showLoading: loading);
}

class CountDownVerifyCodeState extends BaseState {
  final int count;
  const CountDownVerifyCodeState(this.count, bool loading) : super(showLoading: loading);
}

class ShowResendVerifyCodeState extends BaseState {
  final bool show;
  const ShowResendVerifyCodeState(this.show);
}

class ValidateNumVerifyCodeState extends BaseState {
  final bool invalid;
  const ValidateNumVerifyCodeState(this.invalid);
}

class CheckVerifyCodeState extends BaseState {
  final BaseResponse response;
  const CheckVerifyCodeState(this.response);
}

class ForgetPassVerifyCodeState extends BaseState {
  final BaseResponse response;
  final String phone;
  const ForgetPassVerifyCodeState(this.response, this.phone);
}

class ShowLoadingEvent extends BaseEvent {
  final bool value;
  const ShowLoadingEvent({this.value = false});
}

class CountDownVerifyCodeEvent extends BaseEvent {
  final int count;
  final bool loading;
  const CountDownVerifyCodeEvent(this.count, this.loading);
}

class ShowResendVerifyCodeEvent extends BaseEvent {
  final bool show;
  const ShowResendVerifyCodeEvent(this.show);
}

class ValidateNumVerifyCodeEvent extends BaseEvent {
  final bool invalid;
  const ValidateNumVerifyCodeEvent(this.invalid);
}

class CheckVerifyCodeEvent extends BaseEvent {
  final String phone;
  final String code;
  const CheckVerifyCodeEvent(this.phone, this.code);
}

class ForgetPassVerifyCodeEvent extends BaseEvent {
  final String key;
  const ForgetPassVerifyCodeEvent(this.key);
}

class VerifyCodeBloc extends BaseBloc {
  VerifyCodeBloc() {
    on<ShowLoadingEvent>((event, emit) => emit(ShowLoadingState(event.value)));
    on<ValidateNumVerifyCodeEvent>((event, emit) => emit(ValidateNumVerifyCodeState(event.invalid)));
    on<ShowResendVerifyCodeEvent>((event, emit) => emit(ShowResendVerifyCodeState(event.show)));
    on<CountDownVerifyCodeEvent>((event, emit) => emit(CountDownVerifyCodeState(event.count, event.loading)));
    on<CheckVerifyCodeEvent>((event, emit) async {
      emit(const BaseState(showLoading: true));
      final response = await ApiClient().postAPI(
          '${Constants.apiVersion}account/check_verify_code', 'POST', BaseResponse(),
          hasHeader: false,
          body: {'loginkey': event.phone, 'verify_code': event.code});
      emit(CheckVerifyCodeState(response));
    });
    on<ForgetPassVerifyCodeEvent>((event, emit) async {
      emit(const BaseState(showLoading: true));
      final response = await ApiClient().postAPI('${Constants.apiVersion}account/forget_password', 'POST', BaseResponse(), body: {
        'loginkey': event.key
      });
      emit(ForgetPassVerifyCodeState(response, event.key));
    });
  }
}

