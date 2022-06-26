import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';
import 'package:social_media/domain/models/response/response_post.dart';
import 'package:social_media/domain/services/post_services.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/addPost/add_post_page.dart';
import 'package:social_media/ui/screens/home/list_histories.dart';
import 'package:social_media/ui/screens/home/list_view_post.dart';
import 'package:social_media/ui/screens/home/list_without_post.dart';
import 'package:social_media/ui/screens/messages/list_messages_page.dart';
import 'package:social_media/ui/screens/notifications/notifications_page.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is LoadingSavePost || state is LoadingPost) {
          modalLoadingShort(context);
        } else if (state is FailurePost) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessPost) {
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
                text: 'FluSocial',
                fontWeight: FontWeight.w600,
                fontSize: 22.sp,
                color: CustomColors.kSecondary,
                isTitle: true,
              ),
              elevation: 0,
              actions: [
                IconButton(
                    splashRadius: 20.r,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                          routeSlide(page: AddPostPage()), (_) => false);
                    },
                    icon: SvgPicture.asset(SocialMediaAssets.addRounded,
                        height: 32.h)),
                // IconButton(
                //     splashRadius: 20.r,
                //     onPressed: () => Navigator.pushAndRemoveUntil(
                //         context,
                //         routeSlide(page: const NotificationsPage()),
                //         (_) => false),
                //     icon: SvgPicture.asset(SocialMediaAssets.notificationIcon,
                //         height: 26.h)),
                IconButton(
                    splashRadius: 20.r,
                    onPressed: () => Navigator.push(
                        context, routeSlide(page: const ListMessagesPage())),
                    icon: SvgPicture.asset(SocialMediaAssets.chatIcon,
                        height: 24.h)),
              ],
            ),
            body: SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const ListHistories(),
                  SizedBox(height: 5.h),
                  FutureBuilder<List<Post>>(
                    future: postService.getAllPostHome(),
                    builder: (_, snapshot) {
                      if (snapshot.data != null && snapshot.data!.isEmpty) {
                        return ListWithoutPosts();
                      }

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
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, i) =>
                                  ListViewPosts(posts: snapshot.data![i]),
                            );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const BottomNavigationCustom(index: 1)),
      ),
    );
  }
}
