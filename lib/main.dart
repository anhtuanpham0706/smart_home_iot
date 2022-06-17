

import 'package:core_advn/common/base_bloc.dart';
import 'package:core_advn/common/import_base_lib.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_home_dev/common/notificationservice.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';
import 'package:smart_home_dev/features/splash_page.dart';
import 'package:smart_home_dev/features/test_notification/test_noti_page.dart';
import 'features/main/main_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  _determinePosition();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
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
    UtilUI.setTheme().then((value) => _changeState());
  }

  void _changeState() {
    loading++;
    if (loading == 2) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading == 2) {
      return ScreenUtilInit(
          designSize: const Size(400, 600),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: () => MultiBlocProvider(
                  providers: [
                    BlocProvider<MainBloc>(create: (context) => MainBloc())
                  ],
                  child: MaterialApp(
                    home: const SplashPage(),
                    key: key, debugShowCheckedModeBanner: false,
                    // theme: ThemeData(fontFamily: ThemeModel.font, primaryColor: ECommerceStyle.primaryColor)
                  )));
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