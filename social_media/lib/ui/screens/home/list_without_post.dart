import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/commons/assets.dart';

class ListWithoutPosts extends StatelessWidget {
  final List<String> svgPosts = [
    SocialMediaAssets.withoutPostsHome,
    SocialMediaAssets.withoutPostsHome,
    SocialMediaAssets.mobileNewPosts,
  ];

  ListWithoutPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: EdgeInsets.only(bottom: 20.h),
          padding: const EdgeInsets.all(10.0),
          height: 350.h,
          width: size.width,
          // color: Colors.amber,
          child: SvgPicture.asset(svgPosts[index], height: 15.h),
        ),
      ),
    );
  }
}
