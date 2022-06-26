import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/main.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media/ui/helpers/animation_route.dart';
import 'package:social_media/domain/models/response/response_list_chat.dart';
import 'package:social_media/domain/services/chat_services.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/ui/screens/messages/chat_message_page.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class ListMessagesPage extends StatefulWidget {
  const ListMessagesPage({Key? key}) : super(key: key);

  @override
  State<ListMessagesPage> createState() => _ListMessagesPageState();
}

class _ListMessagesPageState extends State<ListMessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextCustom(
            text: 'Messages',
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: .8),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            splashRadius: 20.r,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black87)),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon:
        //           SvgPicture.asset(SocialMediaAssets.newMessage, height: 23.h))
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Container(
            //   height: 50.h,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10.r),
            //       border: Border.all(color: Colors.grey[300]!)),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           decoration: InputDecoration(
            //             contentPadding: EdgeInsets.only(left: 10.w),
            //             hintText: 'Search',
            //             hintStyle: GoogleFonts.roboto(
            //                 letterSpacing: .8, fontSize: 17.sp),
            //             border: InputBorder.none,
            //           ),
            //         ),
            //       ),
            //       const Icon(Icons.search),
            //       SizedBox(width: 10.w)
            //     ],
            //   ),
            // ),
            SizedBox(height: 20.h),
            Flexible(
                child: FutureBuilder<List<ListChat>>(
              future: chatServices.getListChatByUser(),
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) => InkWell(
                              onTap: () => Navigator.push(
                                context,
                                routeFade(
                                  page: ChatMessagesPage(
                                    uidUserTarget: snapshot.data![i].targetUid,
                                    usernameTarget: snapshot.data![i].username,
                                    avatarTarget: snapshot.data![i].avatar,
                                  ),
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.h),
                                height: 70.h,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 27.r,
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
                                            text: snapshot.data![i].username),
                                        SizedBox(height: 5.h),
                                        TextCustom(
                                            text: snapshot.data![i].lastMessage,
                                            fontSize: 16.sp,
                                            color: Colors.grey),
                                      ],
                                    ),
                                    const Spacer(),
                                    TextCustom(
                                        text: timeago.format(
                                            snapshot.data![i].updatedAt,
                                            locale: 'en_short'),
                                        fontSize: 15.sp),
                                  ],
                                ),
                              ),
                            ));
              },
            )),
          ],
        ),
      ),
    );
  }
}
