import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDemoWidget extends StatefulWidget {
  final String videoPath;
  final bool isAsset;

  const VideoDemoWidget({
    super.key,
    required this.videoPath,
    this.isAsset = true,
  });

  @override
  State<VideoDemoWidget> createState() => _VideoDemoWidgetState();
}

class _VideoDemoWidgetState extends State<VideoDemoWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    _controller = widget.isAsset
        ? VideoPlayerController.asset(widget.videoPath)
        : VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));

    await _controller.initialize();

    //  emulater setting
    await _controller.setLooping(true); //  looping
    await _controller.setVolume(0.0); // setvolume
    await _controller.play(); // autoplay

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
