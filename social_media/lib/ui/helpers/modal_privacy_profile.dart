import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

modalPrivacyProfile(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final userBloc = BlocProvider.of<UserBloc>(context);

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
    backgroundColor: Colors.white,
    barrierColor: Colors.black26,
    builder: (context) => Container(
      height: size.height * .41,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5.h,
                width: 38.w,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(50.r)),
              ),
            ),
            SizedBox(height: 15.h),
            Center(
                child: BlocBuilder<UserBloc, UserState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (_, state) => TextCustom(
                        text: (state.user != null && state.user!.isPrivate == 0)
                            ? 'Change account to Private'
                            : 'Change account to Public',
                        fontWeight: FontWeight.w500))),
            SizedBox(height: 5.h),
            const Divider(),
            SizedBox(height: 10.h),
            Row(
              children: [
                const Icon(Icons.photo_outlined, size: 30, color: Colors.black),
                SizedBox(width: 10.w),
                TextCustom(
                    text: 'Everyone can see your photos and videos',
                    fontSize: 15.sp,
                    color: Colors.grey)
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Icon(Icons.chat_bubble_outline_rounded,
                    size: 30, color: Colors.black),
                SizedBox(width: 10.w),
                TextCustom(
                  text: 'This will not change who can tag you \n@mention',
                  fontSize: 15.sp,
                  color: Colors.grey,
                  maxLines: 2,
                )
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                const Icon(Icons.person_add_alt, size: 30, color: Colors.black),
                SizedBox(width: 10.w),
                TextCustom(
                  text:
                      'All pending requests must be \n approved unless you delete them',
                  fontSize: 15.sp,
                  color: Colors.grey,
                  maxLines: 2,
                )
              ],
            ),
            SizedBox(height: 10.h),
            const Divider(),
            SizedBox(height: 10.h),
            BlocBuilder<UserBloc, UserState>(
              buildWhen: (previous, current) => previous != current,
              builder: (_, state) => BtnCustom(
                text: (state.user != null && state.user!.isPrivate == 0)
                    ? 'Change to Private'
                    : 'Change to Public',
                width: size.width,
                fontSize: 17.sp,
                backgroundColor: CustomColors.primary,
                onPressed: () {
                  Navigator.pop(context);
                  userBloc.add(OnChangeAccountToPrivacy());
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}
