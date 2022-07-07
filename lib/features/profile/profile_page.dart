

import 'package:smart_home_dev/common/language_key.dart';
import 'package:smart_home_dev/common/model/item_list_model.dart';
import 'package:smart_home_dev/common/ui/base_page_state.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';
import 'package:smart_home_dev/features/input_key_house/key_home_page.dart';
import 'package:smart_home_dev/features/main/main_bloc.dart';
import 'package:smart_home_dev/features/profile/ui/profile_page_ui.dart';

class ProfilePage extends BasePage {
  final Function funOpenDrawer;
  ProfilePage(this.funOpenDrawer, {Key? key}) : super(_ProfilePageState(), key: key);
}

class _ProfilePageState extends BasePageState {

  @override
  Widget createUI(BuildContext context) {
    return ProfilePageUI(
        bloc as MainBloc,
        (widget as ProfilePage).funOpenDrawer,
        _menuClick,
        _changeHomeKey,
        _showLanguage,
        _logout);
  }

  @override
  void initBloc() {
  bloc = MainBloc();
  }

  @override
  void initUI() {


  }
  void _menuClick() => (widget as ProfilePage).funOpenDrawer();
  void _showLanguage() => SharedPreferences.getInstance().then((prefs) {
    final langId = prefs.getString('lang')??Languages().vi;
    final lang = Languages();
    List<ItemModel> langs = [];
    langs.add(ItemModel(id: lang.en, name: MultiLanguage.get('lbl_english')));
    langs.add(ItemModel(id: lang.vi, name: MultiLanguage.get('lbl_vietnamese')));
    UtilUI.showOptionDialog(context,
                MultiLanguage.get('msg_select_language'), langs, langId)
            .then((value) {
          if (value != null) bloc?.add(ChangeLanguageMainEvent(value.id));
        });
      });

  void _logout() => UtilUI.showCustomAlertDialog(
              context, MultiLanguage.get(LanguageKey.msgLogout),
              isActionCancel: true)
          .then((value) {
        // bloc?.add(LogoutEvent());
        UtilUI.logout(context);
      });

  void _changeHomeKey() {
    CoreUtilUI.goToPage(
        context,
        ShopPage(
          changeSetting: true,
        ),
        hasBack: true);
  }
}