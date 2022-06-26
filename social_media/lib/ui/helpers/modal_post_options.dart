import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/helpers/modal_report_posts.dart';
import 'package:social_media/ui/screens/profile/setting_profile_page.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/custom_dialog.dart';
import 'package:social_media/ui/widgets/widgets.dart';

modalPostOptions(BuildContext context, Size size) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
    backgroundColor: Colors.white,
    builder: (context) => Container(
      height: size.height * .25,
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
                height: 4.h,
                width: 35.w,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(50.r)),
              ),
            ),
            SizedBox(height: 10.h),
            Item(
              icon: Icons.delete_outline_outlined,
              text: 'Delete post',
              size: size,
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return const CustomDialog();
                  }),
            ),
            Item(
              icon: Icons.hide_image_rounded,
              text: 'Hide post',
              size: size,
              onPressed: () {},
            ),
            Item(
              icon: Icons.report_gmailerrorred_rounded,
              text: 'Report post',
              size: size,
              onPressed: () => modalReportPost(
                context: context,
                title: 'Report post',
                // onTap: (){

                // }
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class Item extends StatelessWidget {
  final IconData icon;
  final String text;
  final Size size;
  final VoidCallback onPressed;

  const Item(
      {Key? key,
      required this.icon,
      required this.text,
      required this.size,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width: size.width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(primary: CustomColors.kSecondary),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(icon, color: Colors.black87),
                SizedBox(width: 10.w),
                TextCustom(text: text, fontSize: 17.sp)
              ],
            )),
      ),
    );
  }
}
