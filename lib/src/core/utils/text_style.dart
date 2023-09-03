import 'package:flutter/material.dart';
import 'package:school_timetable/src/core/utils/colors.dart';

TextStyle kTitleTextStyle(
        {double size = 14,
        FontWeight fontWeight = FontWeight.w600,
        Color color = primaryColor,
        TextDecoration decoration = TextDecoration.none}) =>
    TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
