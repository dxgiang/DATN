import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media/ui/themes/color_custom.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final String uidUser;
  final DateTime? time;
  final AnimationController animationController;

  const ChatMessage(
      {Key? key,
      required this.message,
      required this.uidUser,
      required this.animationController,
      this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => state.user != null
                ? Container(
                    child: uidUser == state.user!.uid
                        ? _myMessages()
                        : _notMyMessage())
                : const SizedBox()),
      ),
    );
  }

  Widget _myMessages() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 50.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextCustom(
                text:
                    timeago.format(time ?? DateTime.now(), locale: 'en_short'),
                fontSize: 13.sp,
                color: Colors.grey),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 7.h),
              margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
              child: TextCustom(
                  text: message, color: Colors.white, fontSize: 17.sp),
              decoration: BoxDecoration(
                  color: CustomColors.kPrimary,
                  borderRadius: BorderRadius.circular(10.r)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 50.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
              child: TextCustom(text: message, fontSize: 17.sp),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            TextCustom(
                text:
                    timeago.format(time ?? DateTime.now(), locale: 'en_short'),
                fontSize: 15.sp,
                color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
