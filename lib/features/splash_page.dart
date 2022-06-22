import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_dev/common/constants.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/slider_images.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';
import 'package:smart_home_dev/common/ui/theme_layer.dart';
import 'package:smart_home_dev/common/utils/util_ui.dart';
import 'package:smart_home_dev/features/input_key_house/key_home_page.dart';
import 'package:smart_home_dev/features/login/login_page.dart';
import 'package:smart_home_dev/features/main/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SliderImageBloc? _bloc;
  bool _startScroll = false, _lockSkip = true;
  int _page = 1;

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }

  @override
  void initState() {
    // _loadSetting();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(seconds: 3), () {
      if (!Constants.valueLogin) {
        SharedPreferences.getInstance().then((prefs) {
          bool hasSlide = true;
          if (prefs.containsKey('hasSlide')) {
            hasSlide = prefs.getBool('hasSlide')!;
          }
          if (hasSlide) setState(() => _startScroll = true);
        });
      }
    });
    _nextPage(second: 3);
  }

  // Future<void> _loadSetting() async {
  //   // final response = await ApiClient().getString(Constants.baseUrl + '/api/16/v1/base/option?key=allow_scan_app');
  //   // if (response.isNotEmpty) {
  //   //   final Map json = jsonDecode(response);
  //   //   if (json.containsKey('data')) {
  //   //     final data = json['data'];
  //   //     if (data != null && data is List && data.isNotEmpty) {
  //   //       data.forEach((item) {
  //   //         if (item['key'] == 'allow_scan_app')
  //   //           Constants.showShop = item['value'] == 'true' ? true : false;
  //   //       });
  //   //     }
  //   //   }
  //   // }
  //   _lockSkip = false;
  // }

  void _nextPage({int second = 1}) =>
      Timer(Duration(seconds: second), () async {
        var page;
        if (Constants.valueLogin) {
          page = MainPage();
        } else {
          page = Constants.showShop ? ShopPage() : LoginPage();
        }
        bool hasSlide = true;
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('hasSlide')) {
          hasSlide = prefs.getBool('hasSlide')!;
        }
        if (Constants.valueLogin || !hasSlide) {
          prefs.setBool('hasSlide', false);
          UtilUI.goToPage(context, page);
        }
      });

  @override
  Widget build(BuildContext context) {
    if (Constants.valueLogin || !_startScroll) {
      return Container(
          color: Colors.white,
          child: Image.asset('assets/images/theme/ic_splash.png',
              fit: BoxFit.fill));
    }
    return Scaffold(
        backgroundColor: const Color(0xFFE5E5E5),
        body: Column(children: [
          Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 9,
                            offset: const Offset(0, 7))
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24.sp),
                          bottomRight: Radius.circular(24.sp))),
                  child: CarouselSlider.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index, int realIndex) => ThemeLayer(index+1),
                  options: CarouselOptions(
                      autoPlay: true, viewportFraction: 1, aspectRatio: 0.8)
              ))),
          Padding(padding: EdgeInsets.only(top: 40.sp, bottom: 40.sp), child:
          TextButton(onPressed: _skip,
              child: TextCustom('Skip', size: 14.sp,
                  color: const Color(0xFF414141), fontFamily: 'Segoe UI')))
        ]));
  }

  void _skip() {
    if (_lockSkip) {
      SharedPreferences.getInstance().then((prefs) => prefs.setBool('hasSlide', false));
      UtilUI.goToPage(context, Constants.hashousekey ? ShopPage() : LoginPage());
      // UtilUI.goToPage(context, LoginPage());
    }
  }
}
