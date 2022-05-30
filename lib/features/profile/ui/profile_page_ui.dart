

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/language_key.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/header.dart';
import 'package:smart_home_dev/features/main/main_bloc.dart';
import 'package:smart_home_dev/features/profile/profile_item.dart';

import '../../../common/ui/base_page_state.dart';
import '../../../common/ui/text_custom.dart';

class ProfilePageUI extends StatelessWidget {
  final Function funOpenDrawer, menuClick, changePassword,
     showLanguage, logout;

  final MainBloc bloc;
  const ProfilePageUI(this.bloc, this.funOpenDrawer, this.menuClick,
       this.changePassword, this.showLanguage, this.logout, {Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) => Column(children: [
    HeaderCustom(LanguageKey.ttlProfile, hasBack: false, hasMenu: true, funMenu: menuClick),

    Expanded(child: BlocBuilder(bloc: bloc,
        buildWhen: (oldState, newState) => newState is ChangeLanguageMainState,
        builder: (context, state) => ListView(padding: EdgeInsets.zero, children: [
          Container(padding: EdgeInsets.fromLTRB(16.sp, 14.sp, 0, 9.sp),
              child: TextCustom(MultiLanguage.get(LanguageKey.lblAccount),
                  color: SmartHomeStyle.color7B, size: 14.sp)),
          ProfileItem('assets/images/theme/ic_language.png', LanguageKey.lblLanguage, showLanguage),
          ProfileItem('assets/images/theme/ic_lock.png', LanguageKey.lblChangePass, changePassword),
          ProfileItem('assets/images/theme/ic_logout.png', LanguageKey.lblLogout, logout,
              color: SmartHomeStyle.colorA5, hasLine: false)
        ])))
  ]);
}