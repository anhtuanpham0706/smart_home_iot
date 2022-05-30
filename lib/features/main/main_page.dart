




import 'package:smart_home_dev/common/ui/base_page_state.dart';
import 'package:smart_home_dev/features/home/home_page.dart';
import 'package:smart_home_dev/features/main/main_bloc.dart';
import 'package:smart_home_dev/features/main/ui/main_page_ui.dart';
import 'package:smart_home_dev/features/profile/profile_page.dart';

class MainPage extends BasePage {
  MainPage({Key? key}) : super(MainPageState(), key: key);

}


class MainPageState extends BasePageState with WidgetsBindingObserver {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // final UserModel _user = UserModel();
  BasePage? _page;
  MainBloc? _bloc;
  int index = 0;




  @override
  Widget build(BuildContext context, {Color color = Colors.white}) =>
      MainPageUI( _scaffoldKey, _bloc!, _changePage, _getPage);

  @override
  Widget createUI(BuildContext context) => const SizedBox();


  @override
  void initBloc() {

    MainPageUI.index = 0;
    _bloc = BlocProvider.of<MainBloc>(context);
    _bloc?.stream.listen((state) {
      if (state is ChangePageMainState) _closeDrawer();
      // else if (state is SetInfoMainState) _user.copy(state.user);
      // else if (state is CountNotificationMainState)
      //   _handleResponse(state.response, _handleCountNotification);
    });
  }

  @override
  void initUI() {

  }


  void _changePage(int newIndex) {
    // if (!Constants.valueLogin && (newIndex == 2 || newIndex == 3 || newIndex == 5)) {
    //   showLogin();
    //   return;
    // }
    if (MainPageUI.index != newIndex) {
      if (newIndex == 7) {
        // UtilUI.showCustomAlertDialog(context, MultiLanguage.get(LanguageKey.msgLogout), isActionCancel: true).then((value) {
        //   if (value != null && value) UtilUI.logout(context);
        // });
        // return;
      }
      if (newIndex == 10) {
        // _closeDrawer();
        // UtilUI.goToPage(context, SharePage(), hasBack: true);
        // return;
      }
      MainPageUI.index = newIndex;
      _bloc?.add(ChangePageMainEvent(newIndex));
    }
  }
  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  void _closeDrawer() {
    if (_scaffoldKey.currentState != null &&
        (_scaffoldKey.currentState?.isDrawerOpen)!) Navigator.pop(context);
  }
  BasePage? _getPage() {
    if (_page != null) {
      WidgetsBinding.instance?.removeObserver(this);
      _page = null;
    }
    switch (MainPageUI.index) {
    //   case 1:
    //     _page = CartPage(null, funOpenDrawer: _openDrawer,
    //         funLoadCountCart: _loadCountCart, funOpenHomePage: _openHomePage);
    //     break;
    //   case 2:
    //     _page = OrderHistoryPage(_openDrawer, _openHomePage);
    //     break;
      case 1:
        _page = ProfilePage(_openDrawer);
        break;
    //   case 4:
    //     _page = NewsPage(_openDrawer);
    //     break;
    //   case 5:
    //     _page = ChatPage(_openDrawer);
    //     break;
    //   case 6:
    //     _page = TermPolicyPage(openDrawer: _openDrawer);
    //     break;
    //   case 8:
    //     _page = ProductFavoritePage(openDrawer: _openDrawer);
    //     break;
    //   case 9:
    //     _page = ContactPage(_openDrawer);
    //     break;
    //   case 11:
    //     _page = PromotionSelectListPage(null, hasBack: false, openDrawer: _openDrawer);
    //     break;
      default:
        WidgetsBinding.instance?.addObserver(this);
        _page = HomePage(_openDrawer);
    }
    return _page;
  }

}