import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/commons/l10n/generated/l10n.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';
import 'package:social_media/domain/blocs/user/user_bloc.dart';
import 'package:social_media/domain/models/response/response_followers.dart';
import 'package:social_media/domain/models/response/response_post.dart';
import 'package:social_media/ui/helpers/modal_post_options.dart';
import 'package:social_media/ui/screens/comments/comments_post_page.dart';
import 'package:social_media/ui/screens/home/views/video_player.dart';
import 'package:social_media/ui/screens/profile/profile_another_user_page.dart';
import 'package:social_media/ui/screens/profile/profile_page.dart';
import 'package:social_media/ui/widgets/widgets.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

class ListViewPosts extends StatefulWidget {
  final Post posts;

  const ListViewPosts({Key? key, required this.posts}) : super(key: key);

  @override
  State<ListViewPosts> createState() => _ListViewPostsState();
}

class _ListViewPostsState extends State<ListViewPosts> {
  final File file = File('/assets/video.mp4');

  late VideoPlayerController _videoPlayerController;

  List<int> verticalData = [];
  List<int> horizontalData = [];

  final int increment = 10;

  bool isLoadingVertical = false;
  bool isLoadingHorizontal = false;

  @override
  void initState() {
    _loadMoreVertical();
    _loadMoreHorizontal();
    _videoPlayerController = VideoPlayerController.file(file)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _videoPlayerController.play());

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<File?> pickFiles() async {
    final src = await FilePicker.platform.pickFiles(type: FileType.media);
    if (src == null) {
      return null;
    } else {
      return File(src.files.single.path!);
    }
  }

  Future _loadMoreVertical() async {
    setState(() {
      isLoadingVertical = true;
    });

    // Add in an artificial delay
    await Future.delayed(const Duration(seconds: 2));

    verticalData.addAll(
        List.generate(increment, (index) => verticalData.length + index));

    setState(() {
      isLoadingVertical = false;
    });
  }

  Future _loadMoreHorizontal() async {
    setState(() {
      isLoadingHorizontal = true;
    });

    // Add in an artificial delay
    await Future.delayed(const Duration(seconds: 2));

    horizontalData.addAll(
        List.generate(increment, (index) => horizontalData.length + index));

    setState(() {
      isLoadingHorizontal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);

    final List<String> listImages = widget.posts.images.split(',');
    final time = timeago.format(widget.posts.createdAt, locale: 'en');
    final List<Follower> follow;

    return LazyLoadScrollView(
      onEndOfPage: () => _loadMoreVertical(),
      child: Scrollbar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          child: Container(
            margin: EdgeInsets.only(bottom: 5.h),
            height: 350.h,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.grey[100]),
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
                    // itemBuilder: (context, i, realIndex) => VideoPlayerWidget(),
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
                                  BlocBuilder<UserBloc, UserState>(
                                    builder: (context, state) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              routeSlide(
                                                  page: const ProfilePage()),
                                              (_) => false);
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              Environment.baseUrl +
                                                  widget.posts.avatar),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextCustom(
                                          text: widget.posts.username,
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
                                onPressed: () =>
                                    modalPostOptions(context, size),
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
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
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
                                                        widget.posts.postUid,
                                                        widget
                                                            .posts.personUid)),
                                                child: widget.posts.isLike == 1
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
                                                      text: widget
                                                          .posts.countLikes
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
                                                        uidPost: widget
                                                            .posts.postUid))),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    SocialMediaAssets
                                                        .messageIcon,
                                                    color: Colors.white),
                                                SizedBox(width: 5.w),
                                                TextCustom(
                                                    text: widget
                                                        .posts.countComment
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
                                          // IconButton(
                                          //     onPressed: () {},
                                          //     icon: SvgPicture.asset(
                                          //         SocialMediaAssets.sendIcon,
                                          //         height: 24.h,
                                          //         color: Colors.white)),
                                          SizedBox(width: 20.w,),
                                          IconButton(
                                              onPressed: () => postBloc.add(
                                                  OnSavePostByUser(
                                                      widget.posts.postUid)),
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
        ),
      ),
    );
  }
}
