import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/ui/helpers/modal_profile_settings.dart';

modalMenuOtherProfile(BuildContext context, Size size) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(20.0.r))),
    backgroundColor: Colors.white,
    builder: (context) => Container(
      height: size.height * .48,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5.h,
                width: 50.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50.r)),
              ),
            ),
            SizedBox(height: 10.h),
            Item(
              icon: Icons.report,
              text: 'Report...',
              size: size,
              onPressed: () {},
            ),
            Item(
              icon: Icons.block,
              text: 'Block',
              size: size,
              onPressed: () {},
            ),
            Item(
              icon: Icons.remove_circle_outline_rounded,
              text: 'Restrict',
              size: size,
              onPressed: () {},
            ),
            Item(
              icon: Icons.visibility_off_outlined,
              text: 'Hide your history',
              size: size,
              onPressed: () {},
            ),
            Item(
              icon: Icons.copy_all_rounded,
              text: 'Copy profile URL',
              size: size,
              onPressed: () {},
            ),
            Item(
              icon: Icons.send,
              text: 'Send Message',
              size: size,
              onPressed: () {},
            ),
            Item(
              icon: Icons.share_outlined,
              text: 'Share This Profile',
              size: size,
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
