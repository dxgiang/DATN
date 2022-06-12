import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/ui/widgets/widgets.dart';

void modalOptionsAnotherUser(BuildContext context) {
  showModalBottomSheet(
    context: context,
    barrierColor: Colors.black12,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => Container(
      height: 237.h,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:
                  Container(height: 5.h, width: 40.w, color: Colors.grey[300]),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.only(left: 0, top: 10.h, bottom: 10.h),
                      primary: Colors.grey),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.report_gmailerrorred_rounded,
                              color: Colors.red),
                          SizedBox(width: 10.w),
                          TextCustom(
                              text: 'Report',
                              fontSize: 17.sp,
                              color: Colors.red),
                        ],
                      ))),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.only(left: 0, top: 10.h, bottom: 10.h),
                      primary: Colors.grey),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.block_outlined,
                              color: Colors.black87),
                          SizedBox(width: 10.w),
                          TextCustom(text: 'Block', fontSize: 17.sp),
                        ],
                      ))),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.only(left: 0, top: 10.h, bottom: 10.h),
                      primary: Colors.grey),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.copy_all_rounded,
                              color: Colors.black87),
                          SizedBox(width: 10.w),
                          TextCustom(text: 'Copy profile URL', fontSize: 17.sp),
                        ],
                      ))),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.only(left: 0, top: 10.h, bottom: 10.h),
                      primary: Colors.grey),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.share_outlined,
                              color: Colors.black87),
                          SizedBox(width: 10.w),
                          TextCustom(
                              text: 'Share This Profile', fontSize: 17.sp),
                        ],
                      ))),
            ),
          ],
        ),
      ),
    ),
  );
}
