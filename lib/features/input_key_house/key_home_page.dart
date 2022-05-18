


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/ui/base_page_state.dart';
import 'package:smart_home_dev/common/ui/button_custom.dart';
import 'package:smart_home_dev/common/ui/header.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/common/ui/theme_textfield.dart';

class ShopPage extends BasePage {
  final bool changeSetting;
  ShopPage({this.changeSetting = false, Key? key}):super(_ShopPageState(), key:key);
}

class _ShopPageState extends BasePageState {
  final TextEditingController _ctrEmail = TextEditingController();
  final TextEditingController _ctrPass = TextEditingController();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPass = FocusNode();
  final DatabaseReference _deviceRef =
  FirebaseDatabase.instance.ref().child('smart_home');
  final DBref = FirebaseDatabase.instance.reference();
  Object? value;


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context, {Color color = Colors.white}) => super.build(context, color: const Color(0xFFF5F5F5));

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
            SizedBox(height: 40.sp),
            ThemeTextField(_ctrEmail, _focusEmail, Icons.house, 'Mã định danh nhà', type: TextInputType.phone),
            Container(width: 1.sw, padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 24.sp),
                child: ButtonCustom(_submit, TextCustom('Kiểm Tra',
                    size: 18.sp, color: Colors.white, fontFamily: 'Segoe UI',
                    weight: FontWeight.bold), padding: 10.sp, elevation: 0,color: const Color(0xFFCB7120),)),
          ],
        ),
      )
    ])
  ]);

  @override
  void initBloc() {
    // bloc = ShopBloc();
  }

  @override
  void initUI() => SharedPreferences.getInstance().then((prefs) {
    if (prefs.containsKey('shop')) {
      // final json = jsonDecode(prefs.getString('shop')!);
      // _list.addAll(ShopsModel().fromJson(json).list);
      // bloc!.add(ReloadListEvent());
    }
    /*if (_list.isEmpty) {
        _addShop(ShopModel(id: 16, name: 'shop 16', image: '/uploads/202110/41/090303-dior.png'));
        _addShop(ShopModel(id: 66, name: 'shop 66', image: ''));
        _addShop(ShopModel(id: 166, name: 'shop 166', image: '/uploads/202110/41/090303-dior.png'));
        _addShop(ShopModel(id: 666, name: 'shop 666 dasd asdas asdasd asdasd asdasd asd', image: ''));
        _addShop(ShopModel(id: 1666, name: 'shop 1666', image: '/uploads/202110/41/090303-dior.png'));
        _addShop(ShopModel(id: 6666, name: 'shop 6666', image: ''));
      }*/
  });
  void _submit() async{

    // await DBref.child('Nhiet_do').once().then((DataSnapshot snapshot) =>
    // temp = snapshot.value);
    DataSnapshot snapshot = (await _deviceRef.child("smart_home").child("0929317227")) as DataSnapshot;

    if (snapshot.value != null) {

  }
  }







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