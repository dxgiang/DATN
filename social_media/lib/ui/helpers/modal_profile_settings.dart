import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/profile/setting_profile_page.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

modalProfileSetting(BuildContext context, Size size) {
  // showModalBottomSheet(
  //   context: context,
  //   shape: RoundedRectangleBorder(
  //       borderRadius:
  //           BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
  //   backgroundColor: Colors.white,
  //   builder: (context) => Container(
  //     height: size.height * .36,
  //     width: size.width,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius:
  //             BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Align(
  //             alignment: Alignment.center,
  //             child: Container(
  //               height: 4.h,
  //               width: 35.w,
  //               decoration: BoxDecoration(
  //                   color: Colors.grey[400],
  //                   borderRadius: BorderRadius.circular(50.r)),
  //             ),
  //           ),
  //           SizedBox(height: 10.h),
  //           Item(
  //             icon: Icons.settings,
  //             text: 'Settings',
  //             size: size,
  //             onPressed: () {
  //               Navigator.pop(context);
  //               Navigator.push(
  //                   context, routeSlide(page: const SettingProfilePage()));
  //             },
  //           ),
  //           // Item(
  //           //   icon: Icons.history,
  //           //   text: 'Your activity',
  //           //   size: size,
  //           //   onPressed: () {},
  //           // ),
  //           // Item(
  //           //   icon: Icons.qr_code_rounded,
  //           //   text: 'QR Code',
  //           //   size: size,
  //           //   onPressed: () {},
  //           // ),
  //           // Item(
  //           //   icon: Icons.bookmark_border_rounded,
  //           //   text: 'Saved',
  //           //   size: size,
  //           //   onPressed: () {},
  //           // ),
  //           // Item(
  //           //   icon: Icons.health_and_safety_sharp,
  //           //   text: 'COVID-19 information',
  //           //   size: size,
  //           //   onPressed: () {},
  //           // ),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
  showModalSideSheet(
    context: context,
    ignoreAppBar: false,
    body: Container(
      height: size.height * .36,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     height: 4.h,
          //     width: 35.w,
          //     decoration: BoxDecoration(
          //         color: Colors.grey[400],
          //         borderRadius: BorderRadius.circular(50.r)),
          //   ),
          // ),
          SizedBox(height: 50.h),
          Item(
            icon: Icons.settings,
            text: 'Settings',
            size: size,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context, routeSlide(page: const SettingProfilePage()));
            },
          ),
        ]),
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
