import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String label;
  final String? fontFamily;
  final TextAlign align;
  final FontWeight weight;
  final double size;
  final int maxLine;
  final Color color;
  final TextDecoration? decoration;
  final FontStyle? style;
  const TextCustom(this.label, {this.align = TextAlign.left, this.weight = FontWeight.normal,
    this.size = 10.0, this.maxLine = 1000000000000, this.color = Colors.white, this.decoration,
    this.fontFamily, this.style, Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) => Text(label, textAlign: align,
      overflow: TextOverflow.ellipsis, maxLines: maxLine, style:
      TextStyle(fontWeight: weight, fontFamily: fontFamily, fontSize: size,
          color: color, decoration: decoration, fontStyle: style??FontStyle.normal));
}
