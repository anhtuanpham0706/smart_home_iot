import 'package:core_advn/common/ui/base_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/constants.dart';
import 'package:smart_home_dev/common/language_key.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/text_field_underline.dart';

class UtilUI {
  static void goBack(BuildContext context, value) =>
      Navigator.of(context).pop(value);

  static void clearAllPages(BuildContext context) {
    while (Navigator.of(context).canPop()) Navigator.of(context).pop(false);
  }

  static void goToPage(BuildContext context, dynamic page,
      {bool clearAllPage = false, bool hasBack = false, Function? callback}) {
    if (hasBack) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page))
          .then((value) {
        if (callback != null && value != null) callback(value);
      });
    } else {
      if (clearAllPage) clearAllPages(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => page));
    }
  }

  static Future<dynamic> showConfirmDialog(BuildContext context,
      {String? title,
      String keyLabel = LanguageKey.lblYourEmail,
      String initValue = '',
      bool isActionCancel = false,
      bool dismissible = false,
      TextInputType type = TextInputType.emailAddress}) {
    final TextEditingController controller = TextEditingController();
    controller.text = initValue;

    final List<Widget> actions = [];
    if (isActionCancel)
      actions.add(CoreUtilUI.addAction(
          context,
          MultiLanguage.get(CoreLanguageKey.btnCancel),
          false,
          Colors.grey,
          SmartHomeStyle.elevation));
    actions.add(CoreUtilUI.addAction(
        context,
        MultiLanguage.get(CoreLanguageKey.btnOK),
        controller,
        SmartHomeStyle.primaryColor,
        SmartHomeStyle.elevation));

    return showDialog(
        context: context,
        barrierDismissible: dismissible,
        barrierColor: Colors.black12,
        builder: (context) => AlertDialog(
            title: Text(title ?? MultiLanguage.get(CoreLanguageKey.ttlWarning)),
            content: TextFieldUnderLine(
                controller, null, MultiLanguage.get(keyLabel),
                keyboardType: type,
                padding: EdgeInsets.only(top: 8.sp, bottom: 12.sp)),
            actions: actions));
  }

  static bool checkResponse(BuildContext context, BaseResponse response,
      {bool showError = true, bool passString = false}) {
    if (response.checkTimeout()) {
      // showCustomAlertDialog(
      //     context, MultiLanguage.get(LanguageKey.msgAnotherLogin)).then((value) => logout(context));
      // return false;
    }
    if (response.checkOK(passString: passString)) return true;
    if (showError && response.data != null) {
      // showCustomAlertDialog(context, response.data);
    }
    return false;
  }

  static Future<bool?> showCustomAlertDialog(
          BuildContext context, String message,
          {String? title, bool isActionCancel = false}) =>
      CoreUtilUI.showCustomAlertDialog(context, message,
          title: title,
          isActionCancel: isActionCancel,
          primaryColor: SmartHomeStyle.primaryColor,
          elevation: SmartHomeStyle.elevation);

  static Future<dynamic> showOptionDialog(BuildContext context, String title,
          final List<dynamic> values, String id) =>
      CoreUtilUI.showOptionDialog(context, title, values, id,
          primaryColor: SmartHomeStyle.primaryColor);

  static saveInfo(String info,
          {bool saveAccount = false,
          dynamic nextPage,
          BuildContext? context}) =>
      SharedPreferences.getInstance().then((prefs) {
        // prefs.setInt(Constants.keyId, info.id);
        // prefs.setString(Constants.keyName, info.name);
        // prefs.setString(Constants.keyEmail, info.email);
        // prefs.setString(Constants.keyPhone, info.phone);
        // prefs.setString(Constants.keyAddress, info.address);
        // prefs.setString(Constants.keyDefaultAddress, info.default_address);
        // prefs.setString(Constants.keyGender, info.gender);
        // prefs.setString(Constants.keyBirthday, info.birthdate);
        // prefs.setString(Constants.keyImage, info.image);
        // prefs.setString(Constants.keyCity, info.city);
        // prefs.setInt(Constants.keyCityId, info.city_id);
        // prefs.setString(Constants.keyDistrict, info.district);
        // prefs.setInt(Constants.keyDistrictId, info.district_id);
        // Constants.avatar = info.image;
        if (saveAccount) {
          //prefs.setString(Constants.keyTokenUser, info.token_user);
          prefs.setString(Constants.keyLogin, 'tuananhpham0706@gmail.com');
          prefs.setString(Constants.keyPassword, '0929317227');
          prefs.setBool(Constants.isLogin, true);
          Constants.valueLogin = true;
        }
        if (nextPage != null) goToPage(context!, nextPage, clearAllPage: true);
      });

  static void logout(BuildContext context,
          {bool saveCarts = true, bool openLogin = true}) =>
      SharedPreferences.getInstance().then((prefs) {
        // final lang = prefs.getString('lang')??Languages().vi;
        // final key = prefs.getString(Constants.keyLogin);
        // final pass = prefs.getString(Constants.keyPassword);
        // final remember = prefs.getBool(Constants.isRemember);
        // final carts = prefs.getString(Constants.carts)??'';
        // final shops = prefs.getString('shop')??'[]';
        // final shop = prefs.getString('shopDefault')??'';
        // final shopName = prefs.getString('shopName')??'';
        // final shopId = prefs.getInt('shopId')??16;
        // final accounts = prefs.getString('accounts')??'{}';
        // prefs.clear();
        // if (saveCarts) prefs.setString(Constants.carts, carts);
        // prefs.setString(Constants.keyLogin, key!);
        // prefs.setString(Constants.keyPassword, pass!);
        // prefs.setBool(Constants.isRemember, remember!);
        // prefs.setBool(Constants.isLogin, false);
        // prefs.setBool('hasSlide', false);
        // prefs.setString('lang', lang);
        // prefs.setString('shop', shops);
        // prefs.setString('shopDefault', shop);
        // prefs.setString('shopName', shopName);
        // prefs.setInt('shopId', shopId);
        // prefs.setString(Constants.keyTheme, ThemeModel.value);
        // Constants.valueLogin = false;
        // CoreConstants.avatar = '';
        // Constants.paymentValue = -1;
        // final Map json = jsonDecode(accounts);
        // json.remove(shopId.toString());
        // prefs.setString('accounts', jsonEncode(json));
        // if (openLogin) CoreUtilUI.goToPage(context, LoginPage(), clearAllPage: true);
      });
}