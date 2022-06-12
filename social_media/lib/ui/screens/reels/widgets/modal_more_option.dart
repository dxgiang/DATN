import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/ui/widgets/widgets.dart';

modalOptionsReel(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
    backgroundColor: Colors.white,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * .36,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(50.r)),
              ),
            ),
            SizedBox(height: 10.h),
            ItemModal(
              icon: Icons.report_gmailerrorred_outlined,
              text: 'Report',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ItemModal(
              icon: Icons.no_accounts_rounded,
              text: 'Im not interested',
              onPressed: () {},
            ),
            ItemModal(
              icon: Icons.copy_all_rounded,
              text: 'Copy link',
              onPressed: () {},
            ),
            ItemModal(
              icon: Icons.share_outlined,
              text: 'Share',
              onPressed: () {},
            ),
            ItemModal(
              icon: Icons.save_outlined,
              text: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
