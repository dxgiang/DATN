import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/domain/models/response/response_notifications.dart';
import 'package:social_media/domain/services/notifications_services.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media/data/env/env.dart';
import 'package:social_media/ui/screens/home/home_page.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: TextCustom(
                text: 'Notifications',
                fontWeight: FontWeight.w500,
                letterSpacing: .9,
                fontSize: 19.sp),
            elevation: 0,
            leading: IconButton(
                splashRadius: 20.r,
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context, routeSlide(page: const HomePage()), (_) => false),
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.black)),
          ),
          body: SafeArea(
              child: FutureBuilder<List<Notificationsdb>>(
            future: notificationServices.getNotificationsByUser(),
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
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return SizedBox(
                          height: 60.h,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 22.r,
                                    backgroundColor: Colors.blue,
                                    backgroundImage: NetworkImage(
                                        Environment.baseUrl +
                                            snapshot.data![i].avatar),
                                  ),
                                  SizedBox(width: 5.w),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextCustom(
                                              text: snapshot.data![i].follower,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp),
                                          TextCustom(
                                              text: timeago.format(
                                                  snapshot.data![i].createdAt,
                                                  locale: 'en_short'),
                                              fontSize: 14.sp,
                                              color: Colors.grey),
                                        ],
                                      ),
                                      SizedBox(width: 5.w),
                                      if (snapshot.data![i].typeNotification ==
                                          '1')
                                        TextCustom(
                                            text: 'send a friend request ',
                                            fontSize: 16.sp),
                                      if (snapshot.data![i].typeNotification ==
                                          '3')
                                        TextCustom(
                                            text: 'start to following',
                                            fontSize: 16.sp),
                                      if (snapshot.data![i].typeNotification ==
                                          '2')
                                        Row(
                                          children: [
                                            TextCustom(
                                                text: 'liked ',
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500),
                                            TextCustom(
                                                text: 'to your post',
                                                fontSize: 16.sp),
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              if (snapshot.data![i].typeNotification == '1')
                                Card(
                                  color: CustomColors.kPrimary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.r)),
                                  elevation: 0,
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(50.r),
                                      splashColor: Colors.white54,
                                      onTap: () {
                                        userBloc.add(OnAcceptFollowerRequestEvent(
                                            snapshot.data![i].followersUid,
                                            snapshot.data![i].uidNotification));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 5.h),
                                        child: TextCustom(
                                            text: 'Accept',
                                            fontSize: 16.sp,
                                            color: Colors.white),
                                      )),
                                ),
                            ],
                          ),
                        );
                      },
                    );
            },
          )),
        ),
      ),
    );
  }
}
