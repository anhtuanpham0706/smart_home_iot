

import 'package:core_advn/common/base_bloc.dart';
import 'package:core_advn/common/import_base_lib.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/notificationservice.dart';
import 'package:smart_home_dev/features/splash_page.dart';
import 'package:smart_home_dev/features/test_notification/test_noti_page.dart';
import 'features/main/main_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static void restartApp(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!.restart();
}
class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  int loading = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MultiLanguage.setLanguage().then((value) => _changeState());

  }

  void _changeState() {
    loading++;
    if (loading == 1) setState((){});
  }

  @override
  Widget build(BuildContext context) {
  if (loading ==1) {
    return ScreenUtilInit(
        designSize: const Size(400, 600),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => MultiBlocProvider(
            providers: [BlocProvider<MainBloc>(create: (context) => MainBloc())],
            child: MaterialApp(home: const SplashPage(),
              key: key, debugShowCheckedModeBanner: false,
              // theme: ThemeData(fontFamily: ThemeModel.font, primaryColor: ECommerceStyle.primaryColor)
            )
        ));
  }
    // if (loading == 2) {
    //   return ScreenUtilInit(
    //       designSize: const Size(400, 600),
    //       minTextAdapt: true,
    //       splitScreenMode: true,
    //       builder: () => MultiBlocProvider(
    //           providers: [BlocProvider<MainBloc>(create: (context) => MainBloc())],
    //           child: MaterialApp(home: const SplashPage(),
    //               key: key, debugShowCheckedModeBanner: false,
    //               // theme: ThemeData(fontFamily: ThemeModel.font, primaryColor: ECommerceStyle.primaryColor)
    //           )
    //       ));
    // }
     return Container(color: Colors.white);

  }
  void restart() => setState((){ key = UniqueKey(); });
}