


class BaseResponse {
  final String _msgUndefinedMethod = 'undefined method';
  final String _dataInvalidToken = 'invalid token';
  final String _dataUnAuthorize = 'unauthorize';
  final String _msgUpdateUser = 'updateuser';
  final String _msgRegister = 'register';
  final String _msgCountNotify = 'count_notification';
  final String _msgDestroyNotify = 'destroy_notification';
  final String _msgRemoveFavoritePro = 'create favorite product';
  final String msgForgetPass = 'forget_password';
  final String _msgCheckVerifyCode = 'check_verify_code';
  final String _msgRemoveAvatar = 'remove avatar';
  final String _msgUpdatePass = 'update_password';
  bool success;
  String msg;
  dynamic data;

  BaseResponse({this.success = false, this.msg = '', this.data});

  BaseResponse fromJson(Map<String, dynamic> json, dynamic data) {
    if (json.containsKey('success')) success = json['success'];
    if (json.containsKey('msg')) msg = json['msg'];
    if (json.containsKey('data')) {
      try {
        if (data is BaseResponse) {
          this.data = json['data'].toString();
        } else {
          this.data = success ? data.fromJson(json['data']) : json['data'].toString();
        }
      } catch (e) { setDataError(); }
    }
    return this;
  }

  void setDataError({String? error}) {
    // data = error??MultiLanguage.get(LanguageKey.msgSystemError);
  }

  bool checkOK({bool passString = false}) => (success && (passString || data is! String ||
      msg == _msgRegister || msg == _msgUpdateUser || msg == _msgCountNotify ||
      msg == _msgDestroyNotify || msg == _msgRemoveFavoritePro || msg == msgForgetPass ||
      msg == _msgCheckVerifyCode || msg == _msgRemoveAvatar || msg == _msgUpdatePass));

  bool checkTimeout() => (data is String && (data.toLowerCase().contains(_dataInvalidToken) || data.toLowerCase().contains(_dataUnAuthorize) || data.toLowerCase().contains(_msgUndefinedMethod)));
}