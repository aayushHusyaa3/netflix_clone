import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/AppColor/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle t1({isBold = true}) {
  return TextStyle(
    fontSize: 30.sp,
    fontWeight: isBold ? FontWeight.bold : FontWeight.w100,
    fontFamily: "Font1",
    color: Colors.white,
  );
}

TextStyle t2({isBold = false}) {
  return TextStyle(
    fontSize: 14.sp,
    fontWeight: isBold ? FontWeight.bold : FontWeight.w100,
    color: AppColor.headingColor,
  );
}

TextStyle t3() {
  return TextStyle(fontSize: 10.sp, color: AppColor.hintColor);
}

TextStyle t4() {
  return TextStyle(fontSize: 16.sp, color: Colors.white);
}
