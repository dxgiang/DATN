import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';
import 'package:social_media/domain/models/response/response_post.dart';
import 'package:social_media/ui/helpers/modal_post_options.dart';
import 'package:social_media/ui/screens/comments/comments_post_page.dart';
import 'package:social_media/ui/widgets/widgets.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;

class ListViewPosts extends StatelessWidget {
  final Post posts;

  const ListViewPosts({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);

    final List<String> listImages = posts.images.split(',');
    final time = timeago.format(posts.createdAt, locale: 'en');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        height: 350.h,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r), color: Colors.grey[100]),
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
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: false,
                ),
                itemBuilder: (context, i, realIndex) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              Environment.baseUrl + listImages[i]))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    Environment.baseUrl + posts.avatar),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(
                                      text: posts.username,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  TextCustom(
                                      text: time,
                                      fontSize: 15.sp,
                                      color: Colors.white),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () => modalPostOptions(context, size),
                            icon: const Icon(Icons.more_vert_outlined,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 15,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        height: 45.h,
                        width: size.width * .9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              color: Colors.white.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () => postBloc.add(
                                                OnLikeOrUnLikePost(
                                                    posts.postUid,
                                                    posts.personUid)),
                                            child: posts.isLike == 1
                                                ? const Icon(
                                                    Icons.favorite_rounded,
                                                    color: Colors.red)
                                                : const Icon(
                                                    Icons
                                                        .favorite_outline_rounded,
                                                    color: Colors.white),
                                          ),
                                          SizedBox(width: 8.w),
                                          InkWell(
                                              onTap: () {},
                                              child: TextCustom(
                                                  text: posts.countLikes
                                                      .toString(),
                                                  fontSize: 16,
                                                  color: Colors.white))
                                        ],
                                      ),
                                      SizedBox(width: 20.w),
                                      TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            routeFade(
                                                page: CommentsPostPage(
                                                    uidPost: posts.postUid))),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                SocialMediaAssets.messageIcon,
                                                color: Colors.white),
                                            SizedBox(width: 5.w),
                                            TextCustom(
                                                text: posts.countComment
                                                    .toString(),
                                                fontSize: 16.sp,
                                                color: Colors.white)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: SvgPicture.asset(
                                              SocialMediaAssets.sendIcon,
                                              height: 24.h,
                                              color: Colors.white)),
                                      IconButton(
                                          onPressed: () => postBloc.add(
                                              OnSavePostByUser(posts.postUid)),
                                          icon: Icon(
                                              Icons.bookmark_border_rounded,
                                              size: 27.sp,
                                              color: Colors.white))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
