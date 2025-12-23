
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/constants/fonts.dart';

class AppTextStyles {
  static TextStyle get base => TextStyle(fontFamily: AppFonts.primaryFont);


  static TextStyle get title => base.copyWith(
        fontSize: 18.sp, // كان 24.sp → صغّرناه
        fontWeight: FontWeight.w700,
      );


  static TextStyle get body => base.copyWith(
        fontSize: 14.sp, // كان 24.sp → كبير جداً على شاشة صغيرة
        fontWeight: FontWeight.w400,
      );


  static TextStyle get caption => base.copyWith(
        fontSize: 12.sp, // كان 14.sp
        fontWeight: FontWeight.w400,
      );

  static TextStyle get error => base.copyWith(
        fontSize: 12.sp,
        color: Colors.red,
      );

  static TextTheme get textTheme => TextTheme(

        titleLarge: title,
        bodyLarge: body,
        bodyMedium: body,
        bodySmall: caption,
        labelSmall: caption,
      );
}