import 'dart:convert';
import 'dart:io';
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_home_dev/common/notificationservice.dart';
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
  String _data = '';
  FlutterLocalNotificationsPlugin? _localNotify;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DatabaseReference ref = FirebaseDatabase.instance.ref("Phong/Gas");

  @override
  void dispose() {
    if (_page != null) _page = null;
    if (_localNotify != null) _localNotify = null;
    super.dispose();
  }

  void _set_led() async {
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        _data = data.toString();
        if (_data == '1') {
          NotificationService().showNotification(
              1, 'Cảnh Báo Nguy Hiểm', 'Nhà bạn đang có dấu hiệu hoả hoạn');
        }
      });
    });
  }

  void _notifyGotoScreen(Map<String, dynamic> json) {
    if (json.containsKey('message')) {
      try {
        final msg = jsonDecode(json['message']);
        //if(msg['type'].toLowerCase() == 'chat') {
        if (msg['type'] == 1) {
          // if (_page is ChatPage) (_page as ChatPage).refreshChatList();
          // else {
          //   UtilUI.goToRealPage(context, 'MainPage');
          //   _changePage(5);
          // }
          return;
        }
      } catch (_) {}

      // if (!Constants.openNotification) {
      //   if(_notifyListener != null) _notifyListener = null;
      //   _notifyListener = NotificationPage(this);
      //   UtilUI.goToPage(context, _notifyListener, hasBack: true);
      // }
    }
  }

  void _initFirebase() {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    if (Platform.isAndroid && _localNotify == null) {
      _localNotify = FlutterLocalNotificationsPlugin();
      _localNotify?.initialize(
          const InitializationSettings(
              android: AndroidInitializationSettings('ic_launcher')),
          onSelectNotification: (value) =>
              _notifyGotoScreen(jsonDecode(value!)));
    }
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) _notifyGotoScreen(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notifyGotoScreen(message.data);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // _loadNotification(message.data, notification: message.notification);
    });
  }

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

    _initFirebase();
  }

  @override
  void initUI() {
    _requestPermissions();
    _set_led();
    tz.initializeTimeZones();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
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