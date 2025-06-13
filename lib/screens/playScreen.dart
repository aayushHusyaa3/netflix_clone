import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/textStyles/textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class PlayScreen extends StatefulWidget {
  final String? imagePath;
  final String? title;
  final String? desc;
  final String? videolink;
  final String? ratings;
  final String? date;
  const PlayScreen({
    super.key,
    this.title,
    this.desc,
    this.imagePath,
    this.videolink,
    this.ratings,
    this.date,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    initilaizePlayer();
    super.initState();
  }

  Future<void> initilaizePlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videolink!),
    );
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      autoInitialize: true,
      looping: false,
      allowPlaybackSpeedChanging: true,
      allowFullScreen: true,
      allowMuting: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,

        handleColor: Colors.redAccent,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white,
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 40.r, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              videoContainer(
                child: Center(
                  child:
                      chewieController != null &&
                          chewieController!
                              .videoPlayerController
                              .value
                              .isInitialized
                      ? Chewie(controller: chewieController!)
                      : CircularProgressIndicator(),
                ),
              ),
              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.network(
                        widget.imagePath!,
                        width: 150.w,
                        height: 200.h,
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          widget.title!,
                          style: t1().copyWith(fontSize: 25.sp),
                        ),
                        Column(
                          children: [
                            containerBox(
                              text: "Trailer",
                              isIcon: true,
                              icon: Icons.tv,
                            ),
                            containerBox(text: "HD"),
                            containerBox(
                              text: "Ratings: ${widget.ratings!}",
                              color: Colors.yellowAccent,
                            ),
                            containerBox(text: widget.date!),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Text(widget.desc!, style: t4()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget videoContainer({required Widget child}) {
  return Container(
    width: double.infinity,
    height: 150.h,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
    child: child,
  );
}

Widget containerBox({
  required String text,
  Color color = Colors.white,
  bool isStroke = true,
  bool isIcon = false,
  IconData? icon,
  Color textColor = Colors.black,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 5.r, bottom: 7.r),
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: isStroke ? Colors.black : Colors.transparent,
          width: isStroke ? 1.w : 0,
        ),
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: isIcon
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.black),
                  SizedBox(width: 3.w),
                  Text(text, style: t4().copyWith(color: textColor)),
                ],
              )
            : Text(text, style: t4().copyWith(color: textColor)),
      ),
    ),
  );
}
