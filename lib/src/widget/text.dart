import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  const CText(
    this.text, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.color,
    this.decoration,
    this.decorationColor,
    this.fontFamily,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.height,
    this.letterSpacing,
    this.wordSpacing,
  });

  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? color;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final String? fontFamily;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final double? height;
  final double? letterSpacing;
  final double? wordSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          decoration: decoration,
          decorationColor: decorationColor,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing),
    );
  }
}
