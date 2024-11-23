import 'package:final_projects/presentation/resources/asstes_manager.dart';
import 'package:final_projects/presentation/shared/custom_scafffold/sliding_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoShowPage extends StatefulWidget {
  const VideoShowPage({super.key});

  @override
  State<VideoShowPage> createState() => _VideoShowPageState();
}

class _VideoShowPageState extends State<VideoShowPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AssetsManager.alaminVideo)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SlidingScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      title: "فديو ترويجي لبطوله العلمين",
      child: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            :  Text("اضغط لتشغيل الفيديو" , style: Theme.of(context).textTheme.displayLarge,),
      ),
    );
  }
}
