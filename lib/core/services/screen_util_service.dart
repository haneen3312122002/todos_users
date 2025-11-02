import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilService {
  static Widget init({required Widget Function(BuildContext context) builder}) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // 📐 حسب تصميم Figma
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // ✅ نعطي نفس الـ context للـ MaterialApp
        return builder(context);
      },
    );
  }
}
