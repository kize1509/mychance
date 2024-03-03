import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late List<VideoPlayerController> videoPlayerController;
  late List<ChewieController> chewieController;
  List<String> videoList = [];
  final PageController pageController = PageController(initialPage: 0);

  Future<void> fetchVideoList() async {
    final response = await http
        .get(Uri.parse('http://ceca.ddns.net/hls/playlist/unwatched/1'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      videoList = data.map((video) => video['path'].toString()).map((videoUrl) {
        return videoUrl.replaceAll(RegExp(r'\.mp4$'), '');
      }).toList();
      print(videoList);
      initializePlayer();
    } else {
      throw Exception('Failed to load video list');
    }
  }

  void initializePlayer() {
    videoPlayerController = videoList
        .map((videoUrl) => VideoPlayerController.networkUrl(
            Uri.parse('http://ceca.ddns.net/hls/$videoUrl/stream.m3u8?id=1')))
        .toList();

    chewieController = videoPlayerController
        .map((controller) => ChewieController(
              videoPlayerController: controller,
              aspectRatio: 9 / 16,
              looping: true,
              autoPlay: false,
              allowFullScreen: false,
              allowPlaybackSpeedChanging: false,
              autoInitialize: true,
            ))
        .toList();
    chewieController[0].play();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchVideoList();
  }

  @override
  void dispose() {
    pageController.dispose();
    for (var controller in videoPlayerController) {
      controller.dispose();
    }
    for (var chewieController in chewieController) {
      chewieController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (pageNumber) {
                setState(() {
                  chewieController[pageNumber - 1].pause();
                  chewieController[pageNumber].play();
                });
              },
              itemCount: videoList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Chewie(
                  controller: chewieController[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
