import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

modalPrivacyPost(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final postBloc = BlocProvider.of<PostBloc>(context);

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(20.r))),
    backgroundColor: Colors.white,
    barrierColor: Colors.black26,
    builder: (context) => Container(
      height: size.height * .45,
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
            const Center(
                child: TextCustom(
                    text: 'Who can comment?', fontWeight: FontWeight.w500)),
            SizedBox(height: 15.h),
            const TextCustom(
                text: 'Select who can comment on your\npost.',
                fontSize: 16,
                color: Colors.grey,
                maxLines: 2),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () => postBloc.add(OnPrivacyPostEvent(1)),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: CustomColors.primary,
                        child: const Icon(Icons.public_rounded,
                            color: Colors.white),
                      ),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (_, state) => state.privacyPost == 1
                            ? _Check()
                            : const SizedBox(),
                      )
                    ],
                  ),
                  SizedBox(width: 10.w),
                  const TextCustom(
                    text: 'All',
                    fontSize: 17,
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () => postBloc.add(OnPrivacyPostEvent(2)),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: CustomColors.primary,
                        child: const Icon(Icons.group_outlined,
                            color: Colors.white),
                      ),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (_, state) => state.privacyPost == 2
                            ? _Check()
                            : const SizedBox(),
                      )
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  const TextCustom(
                    text: 'Only followers',
                    fontSize: 17,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            InkWell(
              onTap: () => postBloc.add(OnPrivacyPostEvent(3)),
              child: Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: CustomColors.primary,
                        child: Icon(Icons.lock_outline_rounded,
                            color: Colors.white),
                      ),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (_, state) => state.privacyPost == 3
                            ? _Check()
                            : const SizedBox(),
                      )
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  const TextCustom(
                    text: 'No one',
                    fontSize: 17,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Check extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Positioned(
        right: 0,
        bottom: 0,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 13,
          child: CircleAvatar(
              radius: 10,
              backgroundColor: Color(0xff17bf63),
              child: Icon(Icons.check, color: Colors.white, size: 20)),
        ));
  }
}
