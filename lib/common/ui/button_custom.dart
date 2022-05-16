import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ButtonCustom extends StatelessWidget {
  final Function function;
  final Widget child;
  final Color? color;
  final Color borderColor;
  final double borderWidth;
  final double? padding, radius;
  final double elevation;
  const ButtonCustom(this.function, this.child, {this.color, Key? key,
    this.borderColor = Colors.transparent, this.borderWidth = 0.0, this.radius,
    this.elevation = 4.0, this.padding}):super(key:key);

  @override
  Widget build(BuildContext context) => RaisedButton(
    onPressed: () => function(), child: child,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius??100.sp),
        side: BorderSide(color: borderColor, width: borderWidth)),
    color: color,
    elevation: elevation, padding: EdgeInsets.all(padding??14.sp),
  );
}