import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/cubit/bloc/theme_bloc.dart';
import 'package:social_media/ui/themes/app_themes.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class ThemeProfilePage extends StatelessWidget {
  const ThemeProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const TextCustom(text: 'Change Theme', fontWeight: FontWeight.w500),
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextCustom(text: 'Light'),
                  Icon(Icons.radio_button_checked, color: CustomColors.kPrimary)
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextCustom(text: 'Dark'),
                  Icon(Icons.radio_button_off_rounded)
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextCustom(text: 'System'),
                  Icon(Icons.radio_button_off_rounded)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
