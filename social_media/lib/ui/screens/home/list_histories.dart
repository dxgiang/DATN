import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/domain/blocs/user/user_bloc.dart';
import 'package:social_media/domain/models/response/response_stories.dart';
import 'package:social_media/domain/services/story_services.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/Story/add_story_page.dart';
import 'package:social_media/ui/screens/Story/view_story_page.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class ListHistories extends StatelessWidget {
  const ListHistories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 90.h,
      width: size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          BlocBuilder<UserBloc, UserState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) => state.user != null
                  ? InkWell(
                      onTap: () => Navigator.push(
                          context, routeSlide(page: const AddStoryPage())),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [Colors.pink, Colors.amber])),
                            child: Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(Environment.baseUrl +
                                          state.user!.image.toString()))),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          TextCustom(
                              text: state.user!.username, fontSize: 15.sp)
                        ],
                      ),
                    )
                  : const CircleAvatar()),
          SizedBox(width: 10.w),
          SizedBox(
            height: 90.h,
            width: size.width,
            child: FutureBuilder<List<StoryHome>>(
              future: storyServices.getAllStoriesHome(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const ShimmerCustom()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => Navigator.push(
                                context,
                                routeFade(
                                    page: ViewStoryPage(
                                        storyHome: snapshot.data![i]))),
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            colors: [
                                              Colors.pink,
                                              Colors.amber
                                            ])),
                                    child: Container(
                                      height: 60.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(Environment
                                                      .baseUrl +
                                                  snapshot.data![i].avatar))),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  TextCustom(
                                      text: snapshot.data![i].username,
                                      fontSize: 15.sp)
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
