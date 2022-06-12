import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/ui/screens/reels/widgets/modal_more_option.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class ReelHomeScreen extends StatelessWidget {
  const ReelHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Image.asset(SocialMediaAssets.logo),
          ),
          Positioned(
              left: 15.w,
              top: 30.h,
              child: const TextCustom(
                  text: 'Test',
                  color: Colors.white,
                  isTitle: true,
                  fontWeight: FontWeight.w600)),
          Positioned(
              bottom: 20.h,
              left: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 15.r,
                          child: Image.asset(SocialMediaAssets.logo)),
                      SizedBox(width: 10.w),
                      TextCustom(
                          text: 'FrankPe',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 3.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: Colors.white)),
                        child: TextCustom(
                          text: 'Follow',
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  TextCustom(
                    text: 'Description',
                    fontSize: 14.sp,
                    color: Colors.white,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      const Icon(
                        Icons.music_note_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(width: 5.w),
                      TextCustom(
                        text: 'Song name',
                        color: Colors.white,
                        fontSize: 14.sp,
                      )
                    ],
                  )
                ],
              )),
          Positioned(
              right: 10.w,
              bottom: 20.h,
              child: Column(
                children: [
                  Column(
                    children: [
                      const Icon(Icons.favorite_border_rounded,
                          color: Colors.white, size: 30),
                      SizedBox(height: 5.h),
                      TextCustom(
                        text: '524',
                        color: Colors.white,
                        fontSize: 13.sp,
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Column(
                    children: [
                      SvgPicture.asset(
                        SocialMediaAssets.messageIcon,
                        color: Colors.white,
                        height: 30.h,
                      ),
                      SizedBox(height: 5.h),
                      TextCustom(
                        text: '1504',
                        color: Colors.white,
                        fontSize: 13.sp,
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  const Icon(Icons.share_outlined,
                      color: Colors.white, size: 26),
                  SizedBox(height: 20.h),
                  GestureDetector(
                      onTap: () => modalOptionsReel(context),
                      child: const Icon(Icons.more_vert_rounded,
                          color: Colors.white, size: 26)),
                  SizedBox(height: 20.h),
                  Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          border: Border.all(color: Colors.white, width: 2.w)),
                      child: Image.asset(SocialMediaAssets.logo))
                ],
              ))
        ],
      ),
      bottomNavigationBar: const BottomNavigationCustom(index: 3, isReel: true),
    );
  }
}
