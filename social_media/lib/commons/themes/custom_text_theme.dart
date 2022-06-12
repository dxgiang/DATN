import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

getTextTheme(TextTheme textTheme) {
  return TextTheme(
    headline1: textTheme.headline1?.copyWith(
        fontSize: 68.sp, height: 76.sp / 68.sp, fontWeight: FontWeight.w300),
    headline2: textTheme.headline2?.copyWith(
        fontSize: 56.sp, height: 64.sp / 56.sp, fontWeight: FontWeight.w300),
    headline3:
        textTheme.headline3?.copyWith(fontSize: 46.sp, height: 54.sp / 46.sp),
    headline4:
        textTheme.headline4?.copyWith(fontSize: 38.sp, height: 46.sp / 38.sp),
    headline5:
        textTheme.headline5?.copyWith(fontSize: 30.sp, height: 38.sp / 30.sp),
    headline6: textTheme.headline6?.copyWith(
        fontSize: 24.sp, height: 32.sp / 24.sp, fontWeight: FontWeight.w500),
    button: textTheme.button?.copyWith(fontSize: 16.sp),
    bodyText1:
        textTheme.bodyText1?.copyWith(fontSize: 20.sp, height: 28.sp / 20.sp),
    bodyText2:
        textTheme.bodyText2?.copyWith(fontSize: 16.sp, height: 24.sp / 16.sp),
    subtitle1:
        textTheme.subtitle1?.copyWith(fontSize: 14.sp, height: 22.sp / 14.sp),
    subtitle2:
        textTheme.subtitle2?.copyWith(fontSize: 12.sp, height: 20.sp / 12.sp),
    caption:
        textTheme.caption?.copyWith(fontSize: 12.sp, height: 20.sp / 12.sp),
  );
}
