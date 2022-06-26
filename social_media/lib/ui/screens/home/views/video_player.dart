import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerController? videoPlayerController;
  VideoPlayerWidget({Key? key, this.videoPlayerController}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.videoPlayerController != null &&
                widget.videoPlayerController!.value.isInitialized
            ? Align(
                alignment: Alignment.center,
                child: buildVideo(),
              )
            : SizedBox(
                height: 200.h,
                child: const CircularProgressIndicator(),
              ));
  }

  Widget buildVideo() => buildVideoPlayer();

  Widget buildVideoPlayer() => VideoPlayer(widget.videoPlayerController!);
}
