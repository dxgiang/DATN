import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/domain/models/response/response_post_saved.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class SavedPostsPage extends StatelessWidget {
  final List<ListSavedPost> savedPost;

  const SavedPostsPage({Key? key, required this.savedPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'All posts', fontWeight: FontWeight.w500),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black)),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          physics: const BouncingScrollPhysics(),
          itemCount: savedPost.length,
          itemBuilder: (context, i) {
            final List<String> listImages = savedPost[i].images.split(',');

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
                      padding: EdgeInsets.only(left: 10.w, top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    Environment.baseUrl + savedPost[i].avatar),
                              ),
                              SizedBox(width: 5.w),
                              TextCustom(
                                  text: savedPost[i].username,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ],
                          ),
                          IconButton(
                              splashRadius: 20.r,
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert_rounded,
                                  color: Colors.white))
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 25.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.r),
                          height: 45.h,
                          width: size.width * .95,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                color: Colors.white.withOpacity(0.2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              const Icon(
                                                  Icons
                                                      .favorite_outline_rounded,
                                                  color: Colors.white),
                                              SizedBox(width: 8.w),
                                              TextCustom(
                                                  text: '52k',
                                                  fontSize: 16.sp,
                                                  color: Colors.white)
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                        TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  SocialMediaAssets.messageIcon,
                                                  color: Colors.white),
                                              SizedBox(width: 5.w),
                                              TextCustom(
                                                  text: '1.2k',
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
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.bookmark_rounded,
                                                size: 27,
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
            );
          },
        ),
      ),
    );
  }
}
