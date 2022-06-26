import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class ReportPosts extends StatefulWidget {
  const ReportPosts({ Key? key }) : super(key: key);

  @override
  State<ReportPosts> createState() => _ReportPostsState();
}

class _ReportPostsState extends State<ReportPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

void modalReportPost(
    {required BuildContext context,
    required String title,
    Function()? onTapOption1,
    Function()? onTapOption2,
    Function()? onTapOption3}) {
  bool value = false;

  showModalBottomSheet(
    context: context,
    barrierColor: Colors.black12,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
    builder: (context) => Container(
      height: 170.h,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(
                text: title, fontWeight: FontWeight.w500, fontSize: 16.sp),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              child: CheckboxListTile(value: value, onChanged: (value){}),
              // child: TextButton(
              //     onPressed: onPressedImage,
              //     style: TextButton.styleFrom(
              //         padding:
              //             EdgeInsets.only(left: 0, top: 10.h, bottom: 10.h),
              //         primary: Colors.grey),
              //     child: Align(
              //         alignment: Alignment.centerLeft,
              //         child: Row(
              //           children: [
              //             const Icon(Icons.wallpaper_rounded,
              //                 color: Colors.black87),
              //             SizedBox(width: 10.w),
              //             // TextCustom(
              //             //     text: 'Select from gallery', fontSize: 17.sp),
              //             CheckboxListTile(
              //                 value: value, onChanged: (value) => {}),
              //           ],
              //         ))),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: (){},
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.only(left: 0, top: 10.h, bottom: 10.h),
                      primary: Colors.grey),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.photo_camera_outlined,
                              color: Colors.black87),
                          SizedBox(width: 10.w),
                          TextCustom(text: 'Take a picture', fontSize: 17.sp),
                        ],
                      ))),
            ),
          ],
        ),
      ),
    ),
  );
}
