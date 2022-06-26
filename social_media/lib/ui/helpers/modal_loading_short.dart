import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/ui/themes/color_custom.dart';

void modalLoadingShort(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black45,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 150.w),
      content: SizedBox(
        height: 40.h,
        width: 40.w,
        child: const CircularProgressIndicator(color: CustomColors.kPrimary),
      ),
    ),
  );
}
