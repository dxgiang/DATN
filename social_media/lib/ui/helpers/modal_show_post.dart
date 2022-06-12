import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/domain/models/response/response_post.dart';
import 'package:social_media/ui/widgets/widgets.dart';

void modalShowPost(BuildContext context, {required Post post}) {
  final List<String> listImages = post.images.split(',');

  showDialog(
    context: context,
    barrierColor: Colors.black38,
    builder: (context) => Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(1.0),
                  height: 422.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      // color: Colors.amber,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      Environment.baseUrl + post.avatar),
                                ),
                                SizedBox(width: 10.w),
                                TextCustom(
                                    text: post.username,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                            const Icon(Icons.more_vert_rounded)
                          ],
                        ),
                      ),

                      Container(
                          height: 320.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(Environment.baseUrl +
                                      listImages.first)))),

                      // Bottom Modal Options
                      Container(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.favorite_outline_rounded)),
                                SizedBox(width: 20.w),
                                SvgPicture.asset(SocialMediaAssets.messageIcon,
                                    color: Colors.black),
                                SizedBox(width: 20.w),
                                SvgPicture.asset(SocialMediaAssets.sendIcon,
                                    height: 24.h, color: Colors.black)
                              ],
                            ),
                            const Icon(Icons.bookmark_outline_rounded)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
