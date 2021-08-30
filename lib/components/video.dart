import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MyVideo extends StatefulWidget {
  final String video;
  const MyVideo({Key? key, required this.video}) : super(key: key);

  @override
  _MyVideo createState() => _MyVideo();
}

class _MyVideo extends State<MyVideo> {
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
      //autoPlay: true,
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
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: playerWidget /*VideoPlayer(_controller)*/,
              ),
              /*FloatingActionButton(
                onPressed: () {
                  // Wrap the play or pause in a call to `setState`. This ensures the
                  // correct icon is shown.
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),*/
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}