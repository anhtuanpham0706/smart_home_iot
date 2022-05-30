


import 'package:core_advn/common/ui/import_base_ui_lib.dart';



class MainBloc extends BaseBloc {
  MainBloc() {
    on<ChangePageMainEvent>((event, emit) =>
        emit(ChangePageMainState(event.index)));
    on<ChangeLanguageMainEvent>((event, emit) async {
      emit(const BaseState(showLoading: true));
      await MultiLanguage.setLanguage(lang: event.language);
      emit(ChangeLanguageMainState(event.language));
    });
  }
}


class ChangePageMainEvent extends BaseEvent {
  final int index;
  const ChangePageMainEvent(this.index);
}
class ChangePageMainState extends BaseState {
  final int index;
  ChangePageMainState(this.index);
}


class ReloadMenuMainState extends BaseState {}

class SetInfoMainState extends BaseState {
  // final UserModel user;
  SetInfoMainState();
}
class LogoutEvent extends BaseEvent{}
class LogoutState extends BaseState{
  final BaseResponse response;
  LogoutState(this.response);
}


class UpdateAvatarMainState extends BaseState {
  final BaseResponse response;
  UpdateAvatarMainState(this.response);
}

class ShowLoadingMainState extends BaseState {
  const ShowLoadingMainState(bool showLoading):super(showLoading: showLoading);
}

class ChangeLanguageMainState extends BaseState {
  final String language;
  const ChangeLanguageMainState(this.language);
}

class CountNotificationMainState extends BaseState {
  final BaseResponse response;
  const CountNotificationMainState(this.response);
}

class LoadTermPolicyMainState extends BaseState {
  final BaseResponse response;
  const LoadTermPolicyMainState(this.response);
}

class ChangeExpandMainState extends BaseState {}

class ReloadMenuMainEvent extends BaseEvent {}

class SetInfoMainEvent extends BaseEvent {}



class UpdateAvatarMainEvent extends BaseEvent {
  final String image, format;
  const UpdateAvatarMainEvent(this.image, this.format);
}

class ShowLoadingMainEvent extends BaseEvent {
  final bool showLoading;
  const ShowLoadingMainEvent(this.showLoading);
}

class ChangeLanguageMainEvent extends BaseEvent {
  final String language;
  const ChangeLanguageMainEvent(this.language);
}

class CountNotificationMainEvent extends BaseEvent {}

class LoadTermPolicyMainEvent extends BaseEvent {}

class ChangeExpandMainEvent extends BaseEvent {}

class ScrollMainEvent extends BaseEvent {
  final bool value;
  const ScrollMainEvent(this.value);
}

class ScrollMainState extends BaseState {
  final bool value;
  const ScrollMainState(this.value);
}

class CountCartMainEvent extends BaseEvent{}

class SendContactEvent extends BaseEvent{
  final String name, phone, email, content;
  const SendContactEvent(this.name, this.phone, this.email, this.content);
}
class SendContactState extends BaseState{
  final BaseResponse response;
  const SendContactState(this.response);
}

class LoadHashMainEvent extends BaseEvent {
  final String hash;
  const LoadHashMainEvent(this.hash);
}
class LoadHashMainState extends BaseState {}

class GetPointMainEvent extends BaseEvent {}
class GetPointMainState extends BaseState {
  final double point;
  const GetPointMainState(this.point);
}