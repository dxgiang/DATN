import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/login/started_page.dart';
import 'package:social_media/ui/screens/profile/account_profile_page.dart';
import 'package:social_media/ui/screens/profile/change_password_page.dart';
import 'package:social_media/ui/screens/profile/language_page.dart';
import 'package:social_media/ui/screens/profile/privacy_profile_page.dart';
import 'package:social_media/ui/screens/profile/theme_profile_page.dart';
import 'package:social_media/ui/screens/profile/widgets/item_profile.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class SettingProfilePage extends StatelessWidget {
  const SettingProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextCustom(
            text: 'Configuration',
            fontSize: 19.sp,
            fontWeight: FontWeight.w500),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black)),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          children: [
            Container(
              height: 35.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10.r)),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle:
                        GoogleFonts.getFont('Roboto', color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.search)),
              ),
            ),
            SizedBox(height: 15.h),
            ItemProfile(
                text: 'Follow and invite a friend',
                icon: Icons.person_add_alt,
                onPressed: () {}),
            ItemProfile(
                text: 'Notifications',
                icon: Icons.notifications_none_rounded,
                onPressed: () {}),
            ItemProfile(
                text: 'Privacy',
                icon: Icons.lock_outline_rounded,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const PrivacyProgilePage()))),
            ItemProfile(
                text: 'Security',
                icon: Icons.security_outlined,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const ChangePasswordPage()))),
            ItemProfile(
                text: 'Account',
                icon: Icons.account_circle_outlined,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const AccountProfilePage()))),
            ItemProfile(
                text: 'Help',
                icon: Icons.help_outline_rounded,
                onPressed: () {}),
            ItemProfile(
                text: 'About',
                icon: Icons.info_outline_rounded,
                onPressed: () {}),
            ItemProfile(
                text: 'Languages',
                icon: Icons.language_outlined,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const LanguagePage()))),
            ItemProfile(
                text: 'Themes',
                icon: Icons.palette_outlined,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const ThemeProfilePage()))),
            SizedBox(height: 20.h),
            Row(
              children: [
                const Icon(Icons.copyright_outlined),
                SizedBox(width: 5.w),
                TextCustom(
                    text: 'SOCIAL MEDIA APP',
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500),
              ],
            ),
            SizedBox(height: 30.h),
            TextCustom(
                text: 'Sessions', fontSize: 17.sp, fontWeight: FontWeight.w500),
            SizedBox(height: 10.h),
            ItemProfile(
                text: 'Add or change account',
                icon: Icons.add,
                colorText: CustomColors.primary,
                onPressed: () {}),
            ItemProfile(
                text: 'Log out ${userBloc.state.user!.username}',
                icon: Icons.logout_rounded,
                colorText: CustomColors.primary,
                onPressed: () {
                  authBloc.add(OnLogOutEvent());
                  userBloc.add(OnLogOutUser());
                  Navigator.pushAndRemoveUntil(context,
                      routeSlide(page: const StartedPage()), (_) => false);
                }),
          ],
        ),
      ),
    );
  }
}
