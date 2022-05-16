import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartHomeStyle {
  static Color primaryColor = const Color(0xFFDB7A24);
  static const Color colorLine = Color(0xFFEAECF6);
  static const Color color3B = Color(0xFF3B3B3B);
  static const Color color41 = Color(0xFF414141);
  static const Color color46 = Color(0xFF464646);
  static const Color color5E = Color(0xFF5E5E5E);
  static const Color color9B = Color(0xFF9B9B9B);
  static const Color colorAF = Color(0xFFAFAFAF);
  static const Color colorE4 = Color(0xFFE4E4E4);
  static const Color colorEB = Color(0xFFEBEBEB);
  static const Color colorF4 = Color(0xFFF4F4F4);
  static const Color colorF2 = Color(0xFFF2F2F2);
  static const Color colorA5 = Color(0xFFA5A5A5);
  static const Color color2A29 = Color(0xFF2A2929);
  static const Color color7B = Color(0xFF7B7B7B);
  static const Color color1397 = Color(0xFF139704);
  static const Color color8B = Color(0xFF8B8B8B);
  static const Color colorOrange = Color(0xFFFECC00);
  static const Color colorRed = Color(0xFFEE0906);
  static const Color colorLightBlue = Color(0xFF9CD7D4);
  static const Color colorDarkBlue = Color(0xFF34ACA9);
  static const Color colorD3 = Color(0xFFD3DEEF);
  static const Color colorRed1 = Color(0xFFE00000);
  static const double elevation = 4.0;
  static const FontWeight mediumWeight = FontWeight.w500;

  static TextStyle getDefaultStyle() {
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: const Color(0xFF3B3B3B));
  }

  static TextStyle getStyle(
      {Color color = const Color(0xFF414141),
        FontWeight weight = FontWeight.normal,
        double? size}) {
    return TextStyle(fontWeight: weight, fontSize: size ?? 18.sp, color: color);
  }
}