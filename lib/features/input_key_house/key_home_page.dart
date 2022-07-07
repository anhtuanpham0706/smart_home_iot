


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/base_page_state.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/header.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/common/ui/theme_textfield.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';
import 'package:smart_home_dev/features/input_key_house/key_home_bloc.dart';
import 'package:smart_home_dev/features/login/login_page.dart';

class ShopPage extends BasePage {
  final bool changeSetting;
  ShopPage({this.changeSetting = false, Key? key}):super(_ShopPageState(), key:key);
}

class _ShopPageState extends BasePageState {
  final TextEditingController _ctrEmail = TextEditingController();
  final FocusNode _focusEmail = FocusNode();
  bool _changeSetting = false;

  Map<String, bool> data = {};

  @override
  Widget build(BuildContext context, {Color color = Colors.white}) =>
      super.build(context, color: const Color(0xFFF5F5F5));

  @override
  Widget createUI(BuildContext context) => Stack(children: [
        SizedBox(width: 1.sw, height: 0.6.sh, child:
    Image.asset('assets/images/theme/6230154.png', fit: BoxFit.fill)
    ),
    ListView(padding: EdgeInsets.zero, children: [
      const HeaderCustom('House Key', color: Colors.white, top: 0,hasBack: true),
      Container(
          height: 1.sh - 0.36.sh - ScreenUtil().statusBarHeight - 38.sp,
          margin: EdgeInsets.only(top: 0.36.sh),
          padding: EdgeInsets.fromLTRB(48.sp, 32.sp, 48.sp, 26.sp),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(32.sp), topRight: Radius.circular(32.sp))
          ),
        child: Column(
          children: [
                TextCustom(
                  MultiLanguage.get('lbl_input_key_home'),
                  size: 17.sp,
                  color: Colors.black,
                ),
                SizedBox(height: 40.sp),
                ThemeTextField(_ctrEmail, _focusEmail, Icons.house, 'Key Home',
                    type: TextInputType.phone),
                Container(
                    width: 1.sw,
                    padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 24.sp),
                    child: ButtonCustom(
                      _submit,
                      TextCustom(MultiLanguage.get('btn_check'),
                          size: 18.sp,
                          color: Colors.white,
                          fontFamily: 'Segoe UI',
                          weight: FontWeight.bold),
                      padding: 10.sp,
                      elevation: 0,
                      color: SmartHomeStyle.primaryColor,
                    )),
              ],
        ),
      )
    ])
  ]);

  @override
  void initBloc() {
    final page = widget as ShopPage;
    _changeSetting = page.changeSetting;
    bloc = InputKeyHomeBloc();
    bloc?.stream.listen((state) {
      if (state is GetKeyHomeState) {
        setState(() {
          data = state.data;
        });
      }
    });

    // bloc = ShopBloc();
  }

  @override
  void initUI() {
    bloc?.add(GetKeyHomeEvent());
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('shop')) {
        // final json = jsonDecode(prefs.getString('shop')!);
        // _list.addAll(ShopsModel().fromJson(json).list);
        // bloc!.add(ReloadListEvent());
      }
    });
  }

  void _submit() async{
    if(data.containsKey(_ctrEmail.text)){
      print('okey nha');
      _saveShop();
    } else {
      UtilUI.showCustomAlertDialog(
              context, MultiLanguage.get('lbl_key_home_not_exist'),
              isActionCancel: false)
          .then((value) {});
    }
  }
  void _saveShop() => SharedPreferences.getInstance().then((prefs) {
    prefs.setString('housekey', _ctrEmail.text);
        Constants.housekey = _ctrEmail.text;
        if (_changeSetting == false) {
          UtilUI.goToPage(context, LoginPage(), hasBack: true);
        } else {
          CoreUtilUI.goBack(context, false);
        }
        // _showButtonMenu();
  });







  // void _saveShop() => SharedPreferences.getInstance().then((prefs) =>
  //     prefs.setString('shop', jsonEncode(_list)));

  // void _connectShop(ShopModel shop) => SharedPreferences.getInstance().then((prefs) {
  //   if (!(widget as ShopPage).changeSetting) {
  //     prefs.setInt('shopId', shop.id);
  //     Constants.apiVersion = '/api/${shop.id}/v1/';
  //     UtilUI.goToPage(context, LoginPage());
  //   } else if (!prefs.containsKey('shopId') || prefs.getInt('shopId') != shop.id)
  //     UtilUI.showCustomAlertDialog(context, MultiLanguage.get('msg_change_shop'), isActionCancel: true).then((value) {
  //       if (value != null && value) {
  //         prefs.setInt('shopId', shop.id);
  //         Constants.apiVersion = '/api/${shop.id}/v1/';
  //         UtilUI.logout(context, saveCarts: false);
  //       }
  //     });
  // });
}