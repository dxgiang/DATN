import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';
import 'package:social_media/domain/models/response/response_post_by_user.dart';
import 'package:social_media/domain/services/post_services.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media/data/env/env.dart';
import 'package:social_media/ui/screens/comments/comments_post_page.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class ListPhotosProfilePage extends StatefulWidget {
  const ListPhotosProfilePage({Key? key}) : super(key: key);

  @override
  State<ListPhotosProfilePage> createState() => _ListPhotosProfilePageState();
}

class _ListPhotosProfilePageState extends State<ListPhotosProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);

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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'Posts', fontWeight: FontWeight.w500),
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black)),
        ),
        body: FutureBuilder<List<PostUser>>(
          future: postService.listPostByUser(),
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
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      final List<String> listImages =
                          snapshot.data![i].images.split(',');

                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: SizedBox(
                          height: 350.h,
                          width: size.width,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: CarouselSlider.builder(
                                  itemCount: listImages.length,
                                  options: CarouselOptions(
                                    viewportFraction: 1.0,
                                    enableInfiniteScroll: false,
                                    height: 350.h,
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    autoPlay: false,
                                  ),
                                  itemBuilder: (context, i, realIndex) =>
                                      Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                Environment.baseUrl +
                                                    listImages[i]))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.w, top: 5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              Environment.baseUrl +
                                                  snapshot.data![i].avatar),
                                        ),
                                        SizedBox(width: 10.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextCustom(
                                                text:
                                                    snapshot.data![i].username,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20.sp),
                                            TextCustom(
                                                text: timeago.format(
                                                    snapshot.data![i].createdAt,
                                                    locale: 'en'),
                                                fontSize: 14.sp,
                                                color: Colors.white),
                                          ],
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        splashRadius: 20.r,
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.more_vert_rounded,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                              Positioned(
                                  bottom: 25.h,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    height: 45.h,
                                    width: size.width * .95,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.r),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5.0, sigmaY: 5.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          color: Colors.white.withOpacity(0.2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () => postBloc
                                                        .add(OnLikeOrUnLikePost(
                                                            snapshot.data![i]
                                                                .postUid,
                                                            snapshot.data![i]
                                                                .personUid)),
                                                    child: Row(
                                                      children: [
                                                        snapshot.data![i]
                                                                    .isLike ==
                                                                1
                                                            ? const Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color:
                                                                    Colors.red)
                                                            : const Icon(
                                                                Icons
                                                                    .favorite_outline_rounded,
                                                                color: Colors
                                                                    .white),
                                                        SizedBox(width: 8.w),
                                                        TextCustom(
                                                            text: snapshot
                                                                .data![i]
                                                                .countLikes
                                                                .toString(),
                                                            fontSize: 16.sp,
                                                            color: Colors.white)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.w),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          routeFade(
                                                              page: CommentsPostPage(
                                                                  uidPost: snapshot
                                                                      .data![i]
                                                                      .postUid)));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            SocialMediaAssets
                                                                .messageIcon,
                                                            color:
                                                                Colors.white),
                                                        SizedBox(width: 5.w),
                                                        TextCustom(
                                                            text: snapshot
                                                                .data![i]
                                                                .countComment
                                                                .toString(),
                                                            fontSize: 16.sp,
                                                            color: Colors.white)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Row(
                                              //   children: [
                                              //     IconButton(
                                              //         onPressed: () {},
                                              //         icon: SvgPicture.asset(
                                              //             SocialMediaAssets
                                              //                 .sendIcon,
                                              //             height: 24.h,
                                              //             color: Colors.white)),
                                              //     IconButton(
                                              //         onPressed: () {},
                                              //         icon: const Icon(
                                              //             Icons
                                              //                 .bookmark_outline_sharp,
                                              //             size: 27,
                                              //             color: Colors.white))
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
