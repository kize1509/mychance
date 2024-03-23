import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mychance/screens/confirm_screen.dart';
import 'package:mychance/screens/main_screen.dart';
import 'package:video_player/video_player.dart';

class ProjectUploadScreen extends StatefulWidget {
  const ProjectUploadScreen({super.key});

  @override
  State<ProjectUploadScreen> createState() => _ProjectUploadScreenState();
}

class _ProjectUploadScreenState extends State<ProjectUploadScreen> {
  pickVideo(ImageSource src, BuildContext context) async {
    var video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      VideoPlayerController testLengthController =
          VideoPlayerController.file(File(video.path));
      await testLengthController.initialize();
      if (testLengthController.value.duration.inSeconds < 30 ||
          testLengthController.value.duration.inSeconds > 180) {
        video = null;
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: const Text(
                      'We only allow videos that are longer than 30 seconds and shorter than 3 minutes!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                );
              });
        }
      } else {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ConfirmScreen(
                  videoFile: File(video!.path),
                  videoPath: video.path,
                );
              },
            ),
          );
        }
      }
      testLengthController.dispose();
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: const Row(
              children: [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: const Row(
              children: [
                Icon(Icons.cancel_rounded),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 19, right: 19, top: 10, bottom: 15),
            margin: const EdgeInsets.only(left: 30, right: 30),
            width: 450,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(200, 174, 83, 1),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'PROJECT UPLOAD',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 23,
                      top: 5,
                    ),
                    child: Text(
                      'LOGO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Colors.white,
                        size: 65,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 35,
                width: 150,
                padding:
                    const EdgeInsets.only(left: 8, top: 8, bottom: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: const Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'NAME',
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 40, right: 10),
            margin: const EdgeInsets.only(left: 30, right: 30),
            width: 450,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(200, 174, 83, 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SEEKING',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 45,
                  width: 130,
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: '',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Icon(
                          CupertinoIcons.money_dollar,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 40, right: 10),
            margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
            width: 450,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(200, 174, 83, 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'FOR',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 45,
                  width: 130,
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: '',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Icon(
                          CupertinoIcons.percent,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 17, bottom: 5, left: 40, right: 10),
                margin: const EdgeInsets.only(left: 30, right: 25, top: 20),
                width: 450,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromRGBO(200, 174, 83, 1),
                ),
                child: const Text(
                  'VIDEO PITCH',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 295, top: 13),
                child: CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      showOptionsDialog(context);
                    },
                  ),
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 17, bottom: 5, left: 40, right: 10),
                margin: const EdgeInsets.only(left: 30, right: 25, top: 20),
                width: 450,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromRGBO(200, 174, 83, 1),
                ),
                child: const Text(
                  'BUSINESS PLAN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 295, top: 13),
                child: CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 17, bottom: 5, left: 40, right: 10),
                margin: const EdgeInsets.only(left: 30, right: 25, top: 20),
                width: 450,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromRGBO(200, 174, 83, 1),
                ),
                child: const Text(
                  'SHORT DESCRIPTION',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 295, top: 13),
                child: CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 118,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 56,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  border: Border(
                      top: BorderSide(
                    color: Colors.white,
                  )),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const MainScreen(
                                startupPage: 4,
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.arrow_left_circle_fill,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.info_circle_fill,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromRGBO(153, 127, 38, 1),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.check_mark,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
