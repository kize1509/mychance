import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mychance/screens/confirm_screen.dart';
import 'package:video_player/video_player.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

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
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ConfirmScreen(
                      videoFile: File(video!.path),
                      videoPath: video.path,
                    )),
          );
        }
      }
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 280,
            ),
            const Image(
              image: AssetImage('images/myChanceLogo_white.png'),
              /* Provider.of<ThemeProvider>(context).themeMode ==
                      ThemeMode.dark
                  ? const AssetImage('images/myChanceLogo_white.png')
                  : const AssetImage('images/myChanceLogo_black.png'), */
              alignment: Alignment(200, 100),
              height: 110,
            ),
            Container(
              height: 250,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'uploadVideo',
                  onPressed: () => showOptionsDialog(context),
                  label: const Text("  Upload video  "),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'browseFeed',
                  onPressed: () {},
                  label: const Text("  Browse feed  "),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
