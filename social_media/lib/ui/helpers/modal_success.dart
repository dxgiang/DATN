import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

void modalSuccess(BuildContext context, String text,
    {required VoidCallback onPressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      content: SizedBox(
        height: 250.h,
        child: Column(
          children: [
            Row(
              children: const [
                TextCustom(
                    text: 'Flu ',
                    color: CustomColors.kPrimary,
                    fontWeight: FontWeight.w500),
                TextCustom(text: 'Social', fontWeight: FontWeight.w500),
              ],
            ),
            const Divider(),
            SizedBox(height: 10.h),
            Container(
              height: 90.h,
              width: 90.w,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [Colors.white, CustomColors.kPrimary])),
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: CustomColors.kPrimary),
                child: const Icon(Icons.check, color: Colors.white, size: 38),
              ),
            ),
            SizedBox(height: 35.h),
            TextCustom(
                text: text, fontSize: 17.sp, fontWeight: FontWeight.w400),
            SizedBox(height: 20.h),
            InkWell(
              onTap: onPressed,
              child: Container(
                alignment: Alignment.center,
                height: 35.h,
                width: 150.w,
                decoration: BoxDecoration(
                    color: CustomColors.kPrimary,
                    borderRadius: BorderRadius.circular(5.r)),
                child: TextCustom(
                    text: 'Done', color: Colors.white, fontSize: 17.sp),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
