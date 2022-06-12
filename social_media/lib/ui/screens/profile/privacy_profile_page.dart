import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/profile/widgets/item_profile.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class PrivacyProgilePage extends StatelessWidget {
  const PrivacyProgilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingChangeAccount) {
          modalLoading(context, 'Changing Privacy..');
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'Privacy changed',
              onPressed: () => Navigator.pop(context));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextCustom(
              text: 'Privacy', fontSize: 19.sp, fontWeight: FontWeight.w500),
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black)),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            physics: const BouncingScrollPhysics(),
            children: [
              TextCustom(
                  text: 'Account Privacy',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 10.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: InkWell(
                  child: BlocBuilder<UserBloc, UserState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (_, state) => Row(
                      children: [
                        const Icon(Icons.lock_outlined),
                        SizedBox(width: 10.w),
                        TextCustom(text: 'Private account', fontSize: 17.sp),
                        const Spacer(),
                        (state.user != null && state.user!.isPrivate == 1)
                            ? const Icon(Icons.radio_button_checked_rounded,
                                color: CustomColors.primary)
                            : const Icon(Icons.radio_button_unchecked_rounded),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                  onTap: () => modalPrivacyProfile(context),
                ),
              ),
              const Divider(),
              SizedBox(height: 10.h),
              TextCustom(
                  text: 'Interactions',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 10.h),
              ItemProfile(
                  text: 'Comments',
                  icon: Icons.chat_bubble_outline_rounded,
                  onPressed: () {}),
              ItemProfile(
                  text: 'Post', icon: Icons.add_box_outlined, onPressed: () {}),
              ItemProfile(
                  text: 'Mentions',
                  icon: Icons.alternate_email_sharp,
                  onPressed: () {}),
              ItemProfile(
                  text: 'Stories',
                  icon: Icons.control_point_duplicate_rounded,
                  onPressed: () {}),
              ItemProfile(
                  text: 'Messages', icon: Icons.send_rounded, onPressed: () {}),
              const Divider(),
              SizedBox(height: 10.h),
              TextCustom(
                  text: 'Connections',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 10.h),
              ItemProfile(
                  text: 'Restricted accounts',
                  icon: Icons.no_accounts_outlined,
                  onPressed: () {}),
              ItemProfile(
                  text: 'Blocked accounts',
                  icon: Icons.highlight_off_rounded,
                  onPressed: () {}),
              ItemProfile(
                  text: 'Muted accounts',
                  icon: Icons.notifications_off_outlined,
                  onPressed: () {}),
              ItemProfile(
                  text: 'Accounts you\'re following',
                  icon: Icons.people_alt_outlined,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
