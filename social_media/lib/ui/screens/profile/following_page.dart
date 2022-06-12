import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/domain/models/response/response_followings.dart';
import 'package:social_media/domain/services/user_services.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/profile/profile_another_user_page.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingFollowingUser) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessFollowingUser) {
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
              TextCustom(text: 'Friends', letterSpacing: .8, fontSize: 19.sp),
          elevation: 0,
          leading: IconButton(
              splashRadius: 20.r,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
          child: FutureBuilder<List<Following>>(
            future: userService.getAllFollowing(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Column(
                      children: [
                        const ShimmerCustom(),
                        SizedBox(height: 10.h),
                        const ShimmerCustom(),
                        SizedBox(height: 10.h),
                        const ShimmerCustom(),
                      ],
                    )
                  : _ListFollowings(follow: snapshot.data!);
            },
          ),
        ),
      ),
    );
  }
}

class _ListFollowings extends StatelessWidget {
  final List<Following> follow;

  const _ListFollowings({Key? key, required this.follow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        itemCount: follow.length,
        itemBuilder: (context, i) {
          return InkWell(
            borderRadius: BorderRadius.circular(10.r),
            splashColor: Colors.grey[300],
            onTap: () => Navigator.push(
                context,
                routeSlide(
                    page: ProfileAnotherUserPage(idUser: follow[i].uidUser))),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              height: 70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: Colors.amber,
                        backgroundImage: NetworkImage(
                            Environment.baseUrl + follow[i].avatar),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCustom(text: follow[i].username, fontSize: 16.sp),
                          TextCustom(
                              text: follow[i].fullname,
                              color: Colors.grey,
                              fontSize: 15.sp)
                        ],
                      ),
                    ],
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(50.r)),
                    elevation: 0,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(50.r),
                        splashColor: Colors.blue[50],
                        onTap: () => userBloc
                            .add(OnDeletefollowingEvent(follow[i].uidUser)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 17.w, vertical: 6.h),
                          child: TextCustom(text: 'Following', fontSize: 16.sp),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
