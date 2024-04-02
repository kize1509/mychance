import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final Color selectedColor = const Color.fromRGBO(200, 174, 83, 1);
  final Color unselectedColor = Colors.white;
  Color pendingButtonColor = Colors.white;
  Color exploreButtonColor = const Color.fromRGBO(200, 174, 83, 1);
  Color likeColor = Colors.white;
  bool liked = false;
  late List<VideoPlayerController> videoPlayerController;
  late List<ChewieController> chewieController;
  List<String> videoList = [];
  final PageController pageController = PageController(initialPage: 0);
  int perviousPage = 0;
  int length = 2;

  Future<void> fetchVideoList() async {
    final response = await http
        .get(Uri.parse('http://ceca.ddns.net:80/hls/playlist/unwatched/1'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      videoList = data.map((video) => video['path'].toString()).map((videoUrl) {
        return videoUrl.replaceAll(RegExp(r'\.mp4$'), '');
      }).toList();
      initializePlayer(0, 3, true);
    } else {
      throw Exception('Failed to load video list');
    }
  }

  void initializePlayer(start, finish, firstTime) async {
    List loadList = [];

    for (int i = start; i < finish && i < videoList.length; i++) {
      loadList.add(videoList[i]);
    }
    videoPlayerController = loadList
        .map((videoUrl) => VideoPlayerController.networkUrl(Uri.parse(
            'http://ceca.ddns.net:80/hls/$videoUrl/stream.m3u8?id=1')))
        .toList();

    await videoPlayerController[0].initialize();

    if (firstTime) {
      chewieController = videoPlayerController
          .map(
            (controller) => ChewieController(
                videoPlayerController: controller,
                aspectRatio: 9 / 16,
                looping: true,
                autoPlay: false,
                allowFullScreen: false,
                allowPlaybackSpeedChanging: false,
                autoInitialize: true,
                allowedScreenSleep: false,
                hideControlsTimer: const Duration(seconds: 2),
                showControlsOnInitialize: false,
                showOptions: false),
          )
          .toList();
    } else {
      chewieController.addAll(videoPlayerController
          .map(
            (controller) => ChewieController(
                videoPlayerController: controller,
                aspectRatio: 9 / 16,
                looping: true,
                autoPlay: false,
                allowFullScreen: false,
                allowPlaybackSpeedChanging: false,
                autoInitialize: true,
                allowedScreenSleep: false,
                hideControlsTimer: const Duration(seconds: 2),
                showControlsOnInitialize: false,
                showOptions: false),
          )
          .toList());
    }

    if (videoPlayerController[0].value.isInitialized && firstTime) {
      chewieController[0].play();
    }

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
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (pageNumber) {
                setState(() {
                  if (perviousPage < pageNumber) {
                    chewieController[pageNumber - 1].pause();
                    chewieController[pageNumber].play();
                    perviousPage = pageNumber;
                  } else {
                    chewieController[pageNumber + 1].pause();
                    chewieController[pageNumber].play();
                    perviousPage = pageNumber;
                  }
                  if (chewieController.length == pageNumber + 2 &&
                      pageNumber % 2 != 0 &&
                      pageNumber != 0 &&
                      pageNumber != 9) {
                    initializePlayer(pageNumber + 2, pageNumber + 4, false);
                  }
                  length = chewieController.length;
                });
              },
              itemCount: length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Chewie(
                      controller: chewieController[index],
                    ),
                    feedOverlay(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget feedOverlay() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      pendingButtonColor = selectedColor;
                      exploreButtonColor = unselectedColor;
                    });
                  },
                  child: Text(
                    'PENDING',
                    style: TextStyle(
                      color: pendingButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      pendingButtonColor = unselectedColor;
                      exploreButtonColor = selectedColor;
                    });
                  },
                  child: Text(
                    'EXPLORE',
                    style: TextStyle(
                      color: exploreButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: TextButton(
                  onPressed: () {},
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: ClipOval(
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(
                          'images/myChanceLogo_white.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (liked == true) {
                            liked = false;
                            likeColor = unselectedColor;
                          } else {
                            liked = true;
                            likeColor = Colors.red;
                          }
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.heart_fill,
                        color: likeColor,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 47, right: 23),
                      child: Text(
                        '200',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: unselectedColor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        contentPadding: const EdgeInsets.all(0),
                        backgroundColor: Colors.transparent,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, left: 12),
                                child: Container(
                                  width: 400,
                                  height: 500,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromRGBO(153, 127, 38, 1),
                                        Colors.white
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, left: 12),
                                child: Container(
                                  width: 400,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.black,
                                        Color.fromRGBO(200, 145, 22, 1),
                                      ],
                                    ),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'INVEST IN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                      Text(
                                        '@vargicon',
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10.0,
                                              color: Colors.black,
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ],
                                          color:
                                              Color.fromRGBO(153, 127, 38, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 150),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 250,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.black,
                                            Color.fromRGBO(200, 145, 22, 1),
                                          ],
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'AMOUNT',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 70,
                                      margin: const EdgeInsets.only(
                                          top: 15, left: 200),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromRGBO(153, 127, 38, 1),
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                      child: const Center(
                                        child: TextField(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: '',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 300),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 250,
                                      height: 100,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.black,
                                            Color.fromRGBO(200, 145, 22, 1),
                                          ],
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '1 SHARE PRICE',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 70,
                                      margin: const EdgeInsets.only(
                                          top: 15, left: 200),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromRGBO(153, 127, 38, 1),
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '10\$',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 90,
                                  height: 80,
                                  margin: const EdgeInsets.only(
                                      top: 450, left: 150),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromRGBO(153, 127, 38, 1),
                                        Colors.white,
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.credit_card,
                                    size: 50,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 75,
                                  height: 65,
                                  margin:
                                      const EdgeInsets.only(top: 460, left: 65),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromRGBO(153, 127, 38, 1),
                                        Colors.white,
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Image.asset(
                      'images/myChanceLogo_black1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Comments',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (index, context) {
                                          return commentTile('@vargenzi');
                                        },
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Add comment',
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.send),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      CupertinoIcons.chat_bubble_fill,
                      color: Colors.white,
                      size: 40,
                    )),
              )
            ],
          ),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.arrowshape_turn_up_right_fill,
                          color: Colors.white,
                          size: 40,
                        )),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '@vargicon',
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    blurRadius: 10.0,
                                    color: selectedColor,
                                    offset: const Offset(2.0, 2.0))
                              ],
                              color: selectedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Augmented reality revolution',
                          style: TextStyle(
                            color: unselectedColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );

  Widget commentTile(String username) => Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        'images/myChanceLogo_white.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          username,
                          style: TextStyle(
                              color: selectedColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 15),
                      child: SizedBox(
                        width: 280,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, top: 1),
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  'Reply',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      );
}
