import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class PlayVideo extends StatefulWidget {
  final String video;
  const PlayVideo({Key? key, required this.video}) : super(key: key);

  @override
  _PlayVideo createState() => _PlayVideo();
}

class _PlayVideo extends State<PlayVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late ChewieController chewieController;
  late Chewie playerWidget;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.video,
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();

    chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      //looping: true,
    );

    playerWidget = Chewie(
      controller: chewieController,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            "تراكتور الرحامنة",
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: playerWidget,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
