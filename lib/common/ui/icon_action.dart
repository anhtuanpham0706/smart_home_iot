import 'package:core_advn/common/ui/button_custom_transparent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class IconAction extends StatelessWidget {
  final String asset;
  final Function function;
  final double? width, height, padding;
  final Color? color;
  final Color bgColor;

  const IconAction(this.function, this.asset, {this.width, this.height, this.padding,
    this.color, this.bgColor = Colors.transparent, Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) => ButtonCustomTransparent(
        function, Image.asset(asset, width: width??17.sp, height: height??17.sp, color: color),
        sizeRadius: 100.sp, padding: EdgeInsets.all(padding??5.sp), color: bgColor);
}
