import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

void modalLoading(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white54,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: SizedBox(
        height: 100.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Row(
              children: [
                const CircularProgressIndicator(color: CustomColors.kPrimary),
                SizedBox(width: 15.0.w),
                TextCustom(text: text)
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
