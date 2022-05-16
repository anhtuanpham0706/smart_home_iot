export 'package:core_advn/common/ui/base_page.dart';

import 'package:core_advn/common/ui/base_page.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';
import 'package:smart_home_dev/features/login/login_page.dart';


export '../constants.dart';



abstract class BasePageState extends CoreBasePageState {
  @override
  void logout(BuildContext context) => UtilUI.logout(context);

  @override
  bool checkResponse(BaseResponse response, {Color primaryColor = Colors.white60, bool showError = true, bool passString = false}) =>
      super.checkResponse(response, primaryColor: Colors.blue, showError: showError, passString: passString);

  void showMsgLogin() => showLogin(LoginPage(), Colors.blue);
}