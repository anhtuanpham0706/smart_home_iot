

import 'package:core_advn/common/ui/button_custom_transparent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/drawer_item.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';
import 'package:smart_home_dev/features/login/login_page.dart';
import 'package:smart_home_dev/features/main/main_bloc.dart';
import 'package:smart_home_dev/features/main/ui/main_page_ui.dart';

import '../../../common/ui/base_page_state.dart';

class DrawerContent extends StatelessWidget {
  final MainBloc bloc;
  // final UserModel user;
  final Function changePage;
  const DrawerContent(this.bloc, this.changePage, {Key? key}):super(key:key);
  @override
  Widget build(BuildContext context) {

        return Column(children: [
          Padding(padding: EdgeInsets.fromLTRB(23.sp, 60.sp, 23.sp, 33.sp), child: Row(children:[
            // ButtonCustomTransparent(() => UtilUI.viewAvatar(context),
            //     AvatarCircle(size: 75.sp), sizeRadius: 40.sp, borderWidth: 0),
            SizedBox(width: 16.sp),
            Expanded(child: Constants.valueLogin ? BlocBuilder(bloc: bloc, builder: (context, _) =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
                  TextCustom('Anh Tuấn', color: Colors.black, size: 18.sp, weight: FontWeight.w500),
                  SizedBox(height: 4.sp),
                  TextCustom('0929317227', color: const Color(0xFF897B7B), size: 14.sp)
                ]), buildWhen: (oldState, newState) => newState is SetInfoMainState) :
            Column(children: [
              TextCustom('', color: Colors.black, size: 16.sp),
              SizedBox(height: 10.sp),
              ButtonCustomTransparent(() => UtilUI.goToPage(context, LoginPage(), clearAllPage: true),
                  TextCustom('Đăng nhập', size: 14.sp), sizeRadius: 20.sp,
                  color: SmartHomeStyle.primaryColor, padding: EdgeInsets.fromLTRB(10.sp, 5.sp, 10.sp, 5.sp))
            ])
            )])),
          Expanded(child: _Body(bloc, changePage))
        ]);
    }

}

class _Body extends StatelessWidget {
  final MainBloc bloc;
  final Function changePage;
  const _Body(this.bloc, this.changePage);
  @override
  Widget build(BuildContext context) => BlocBuilder(bloc: bloc, builder: (context, state) {
    int index = MainPageUI.index;
    if (state is ChangePageMainState) index = state.index;
    return ListView(padding: EdgeInsets.zero, children: [
      DrawerItem(() => changePage(0), 'assets/images/theme/ic_home.png',
          'Home', index == 0),
      // DrawerItem(() => changePage(4), 'assets/images/ic_news.png',
      //     MultiLanguage.get(LanguageKey.ttlNews), index == 4),
      // Constants.valueLogin ? DrawerItem(() => changePage(10), 'assets/images/ic_share_app.png',
      //     MultiLanguage.get(LanguageKey.ttlShareApp), index == 10):const SizedBox(),
      // Constants.valueLogin ? DrawerItem(() => changePage(3), 'assets/images/ic_profile.png',
      //     MultiLanguage.get(LanguageKey.ttlProfile), index == 3):const SizedBox(),
      // // DrawerItem(() => changePage(11), 'assets/images/theme3/ic_theme3_promotion.png',
      // //     MultiLanguage.get(LanguageKey.lblPromotion), index == 11),
      // Constants.valueLogin ? DrawerItem(() => changePage(2), 'assets/images/ic_history.png',
      //     MultiLanguage.get(LanguageKey.ttlHistory), index == 2):const SizedBox(),
      // Constants.valueLogin ? DrawerItem(() => changePage(1), 'assets/images/ic_item_cart.png',
      //     MultiLanguage.get(LanguageKey.ttlCart), index == 1):const SizedBox(),
      // Constants.valueLogin ? DrawerItem(() => changePage(8), 'assets/images/ic_saved.png',
      //     MultiLanguage.get(LanguageKey.ttlFavorite), index == 8):const SizedBox(),
      // // Constants.valueLogin ? DrawerItem(() => changePage(5), 'assets/images/ic_chat.png',
      // //     MultiLanguage.get(LanguageKey.lblChatUs), index == 5):const SizedBox(),
      // Constants.valueLogin ? DrawerItem(() => changePage(9), 'assets/images/ic_chat.png',
      //     MultiLanguage.get(LanguageKey.ttlContact), index == 9):const SizedBox(),
      // DrawerItem(() => changePage(6), 'assets/images/ic_shield.png',
      //     MultiLanguage.get(LanguageKey.lblCommonPolicy), index == 6),
      // Constants.valueLogin ? ButtonCustomTransparent(() => changePage(7), Row(children: [
      //   Padding(padding: EdgeInsets.only(left: 26.sp, right: 23.sp), child:
      //   Image.asset('assets/images/ic_logout.png', width: 16.sp, height: 16.sp)),
      //   Expanded(child: TextCustom(MultiLanguage.get(LanguageKey.lblLogout), size: 14.sp,
      //       color: const Color(0xFF737373), weight: FontWeight.w500)),
      // ]), padding: EdgeInsets.fromLTRB(0, 24.sp, 24.sp, 24.sp)):const SizedBox()
    ]);
  }, buildWhen: (oldState, newState) => newState is ChangePageMainState);
}
