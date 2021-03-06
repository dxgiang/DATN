import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';
import 'package:social_media/domain/models/response/response_post.dart';
import 'package:social_media/domain/services/post_services.dart';
import 'package:social_media/domain/services/user_services.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/domain/models/response/response_search.dart';
import 'package:social_media/ui/screens/profile/profile_another_user_page.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

bool saveTheme = false;

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.clear();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 10.h),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  height: 45.h,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: saveTheme
                        ? CustomColors.backgroundColor
                        : CustomColors.backgroundColorWhite,
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(5, 10),
                        color: saveTheme ? Colors.black : Colors.grey,
                      ),
                    ],
                  ),
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) => TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            postBloc.add(OnIsSearchPostEvent(true));
                            userService.searchUsers(value);
                          } else {
                            postBloc.add(OnIsSearchPostEvent(false));
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Search ...',
                          hintStyle: GoogleFonts.roboto(fontSize: 17.sp),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey,
                          hoverColor: Colors.grey,
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search_rounded,
                              size: 23,
                              color: saveTheme
                                  ? Colors.white
                                  : CustomColors.backgroundColor),
                          suffixStyle: TextStyle(
                              color: saveTheme
                                  ? CustomColors.backgroundColorWhite
                                  : CustomColors.backgroundColor),
                        ),
                        cursorColor: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<PostBloc, PostState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) => !state.isSearchFriend
                      ? FutureBuilder<List<Post>>(
                          future: postService.getAllPostsForSearch(),
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? const _ShimerSearch()
                                : _GridPostSearch(posts: snapshot.data!);
                          },
                        )
                      : streamSearchUser())
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationCustom(index: 2),
      ),
    );
  }

  Widget streamSearchUser() {
    return StreamBuilder<List<UserFind>>(
      stream: userService.searchProducts,
      builder: (context, snapshot) {
        if (snapshot.data == null) return Container();

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.isEmpty) {
          return ListTile(
            title: TextCustom(text: 'No results for ${_searchController.text}'),
          );
        }

        return _ListUsers(listUser: snapshot.data!);
      },
    );
  }
}

class _ListUsers extends StatelessWidget {
  final List<UserFind> listUser;

  const _ListUsers({
    Key? key,
    required this.listUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listUser.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                routeSlide(
                    page: ProfileAnotherUserPage(idUser: listUser[i].uid)));
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              padding: EdgeInsets.only(left: 5.w),
              height: 70.h,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage:
                        NetworkImage(Environment.baseUrl + listUser[i].avatar),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextCustom(text: listUser[i].username),
                      TextCustom(
                          text: listUser[i].fullname, color: Colors.grey),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GridPostSearch extends StatelessWidget {
  final List<Post> posts;

  const _GridPostSearch({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 15.w, right: 20.w),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              mainAxisExtent: 170),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: posts.length,
          itemBuilder: (context, i) {
            final List<String> listImages = posts[i].images.split(',');

            return GestureDetector(
              onTap: () {},
              onLongPress: () => modalShowPost(context, post: posts[i]),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              Environment.baseUrl + listImages.first)))),
            );
          }),
    );
  }
}

class _ShimerSearch extends StatelessWidget {
  const _ShimerSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ShimmerCustom(),
        SizedBox(height: 10.h),
        const ShimmerCustom(),
        SizedBox(height: 10.h),
        const ShimmerCustom(),
      ],
    );
  }
}
