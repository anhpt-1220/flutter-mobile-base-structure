import 'package:flutter/material.dart';
import 'package:base/presentation/styles/app_colors.dart';

UnderlineInputBorder underlineBorder(
    {double size = 0.2, Color color = Colors.green}) {
  return UnderlineInputBorder(
      borderSide: BorderSide(width: size, color: color));
}

const BoxShadow defaultBoxShadow = const BoxShadow(
  offset: Offset(0.0, 3.0),
  color: AppColors.lightGrey16,
);

const BoxShadow defaultBoxShadowWithBlur = const BoxShadow(
    offset: Offset(0.0, 3.0),
    color: AppColors.lightGrey16,
    blurRadius: 3,
    spreadRadius: 3);
