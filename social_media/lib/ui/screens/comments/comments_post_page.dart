import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';
import 'package:social_media/domain/models/response/response_comments.dart';
import 'package:social_media/domain/services/post_services.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media/data/env/env.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class CommentsPostPage extends StatefulWidget {
  final String uidPost;

  const CommentsPostPage({
    Key? key,
    required this.uidPost,
  }) : super(key: key);

  @override
  _CommentsPostPageState createState() => _CommentsPostPageState();
}

class _CommentsPostPageState extends State<CommentsPostPage> {
  late TextEditingController _commentController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.clear();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postBloc = BlocProvider.of<PostBloc>(context);

    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is LoadingPost) {
          modalLoadingShort(context);
        } else if (state is FailurePost) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessPost) {
          Navigator.pop(context);
          _commentController.clear();
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextCustom(
              text: 'Comments',
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
        ),
        body: Form(
          key: _keyForm,
          child: FutureBuilder<List<Comment>>(
            future: postService.getCommentsByUidPost(widget.uidPost),
            builder: (context, snapshot) => !snapshot.hasData
                ? const ShimmerCustom()
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 5.h, right: 5.w, bottom: 5.h),
                              // color: Colors.green,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25.r,
                                    backgroundColor: Colors.blue,
                                    backgroundImage: NetworkImage(
                                        Environment.baseUrl +
                                            snapshot.data![i].avatar),
                                  ),
                                  SizedBox(width: 10.w),
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                            text: snapshot.data![i].username,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                        Text(snapshot.data![i].comment),
                                        SizedBox(height: 5.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(50.r),
                                              onTap: () => postBloc.add(
                                                  OnLikeOrUnlikeComment(
                                                      snapshot.data![i].uid)),
                                              child: snapshot.data![i].isLike ==
                                                      1
                                                  ? Icon(Icons.favorite_rounded,
                                                      size: 19.sp,
                                                      color: Colors.red)
                                                  : Icon(
                                                      Icons
                                                          .favorite_border_rounded,
                                                      size: 19.sp),
                                            ),
                                            TextCustom(
                                                text: timeago.format(
                                                    snapshot.data![i].createdAt,
                                                    locale: 'en_short'),
                                                fontSize: 14.sp),
                                          ],
                                        )
                                        // add dots to show this is a longer text
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 70.h,
                        decoration: const BoxDecoration(
                          color: Color(0xff1F2128),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: TextField(
                                    controller: _commentController,
                                    style:
                                        GoogleFonts.roboto(color: Colors.white),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(left: 10.w),
                                        hintText: 'Write a comment',
                                        hintStyle: GoogleFonts.roboto(
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (_keyForm.currentState!.validate()) {
                                      postBloc.add(OnAddNewCommentEvent(
                                          widget.uidPost,
                                          _commentController.text.trim()));
                                    }
                                  },
                                  icon: Icon(Icons.send_rounded,
                                      color: Colors.white, size: 28.sp))
                            ],
                          ),
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
