import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/login/login_page.dart';
import 'package:social_media/ui/screens/login/register_page.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: 55.h,
              width: size.width,
              child: Row(
                children: [
                  Image.asset(SocialMediaAssets.logoBlack, height: 30.h),
                  const TextCustom(
                      text: 'Flu',
                      fontWeight: FontWeight.w500,
                      color: CustomColors.kPrimary),
                  TextCustom(text: 'Social', fontSize: 14.sp)
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30.0),
                width: size.width,
                child: SvgPicture.asset(SocialMediaAssets.undrawPostOnline),
              ),
            ),
            TextCustom(
              text: 'Welcome to FluSocial!',
              letterSpacing: 2.0,
              color: CustomColors.kSecondary1,
              fontWeight: FontWeight.w600,
              fontSize: 26.sp,
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextCustom(
                text:
                    'The best place to post your stories and share your experiences.',
                textAlign: TextAlign.center,
                maxLines: 2,
                fontSize: 17.sp,
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SizedBox(
                height: 50.h,
                width: size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: CustomColors.kSecondary1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r))),
                  child: TextCustom(
                      text: 'Log in', color: Colors.white, fontSize: 20.sp),
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: const LoginPage())),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Container(
                height: 50.h,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                        color: CustomColors.kSecondary1, width: 1.5.w)),
                child: TextButton(
                  child: TextCustom(
                      text: 'Register',
                      color: CustomColors.kSecondary1,
                      fontSize: 20.sp),
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: const RegisterPage())),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
