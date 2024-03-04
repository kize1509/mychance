import 'dart:io';
import 'package:ffmpeg_kit_flutter_https_gpl/return_code.dart';
import 'package:flutter/material.dart';
import 'package:mychance/screens/root_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter_https_gpl/ffmpeg_kit.dart';
import 'package:http/http.dart' as http;

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  TextEditingController captionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  Future<void> compressAndUploadVideo(String videoPath) async {
    int videoBitrate = 6 * 1000 * 1024; // 6 Mbps
    int audioBitrate = 32 * 1024; // 32 kbps

    int maxWidth = 1080;
    int maxHeight = 1920;

    int audioChannels = 2;
    double frameRate = 30.0;

    Directory tempDir = await getTemporaryDirectory();
    String outputPath = '${tempDir.path}/compressed_video7.mp4';

    String command =
        "-i $videoPath -c:v libx264 -b:v $videoBitrate -c:a aac -b:a $audioBitrate -strict experimental -ac $audioChannels -vf 'scale=$maxWidth:$maxHeight' -r $frameRate $outputPath";

    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();

      await session.getLogs().then((logs) {
        logs.forEach((log) {
          print(log.getMessage());
        });
      });

      if (ReturnCode.isSuccess(returnCode)) {
        print("Success");
        await uploadVideoToServer(File(outputPath));
        await File(outputPath).delete();
      } else {
        print("FFmpeg execution failed with return code: $returnCode");
      }
    });
  }

  Future<void> uploadVideoToServer(File videoFile) async {
    try {
      var uploadUrl = Uri.parse('http://ceca.ddns.net/data/single?id=1');

      var request = http.MultipartRequest('POST', uploadUrl);

      request.files
          .add(await http.MultipartFile.fromPath('video', videoFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Video uploaded successfully');
      } else {
        print('Failed to upload video. Status code: ${response.statusCode}');
        print(await response.stream.bytesToString());
      }
    } catch (error) {
      print('Error uploading video: $error');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Title',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextField(
                      controller: captionController,
                      decoration: const InputDecoration(
                        labelText: 'Caption',
                        icon: Icon(Icons.closed_caption),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextField(
                      controller: tagsController,
                      decoration: const InputDecoration(
                        labelText: 'Tags',
                        icon: Icon(Icons.tag),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const RootScreen();
                                },
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print("START");
                          compressAndUploadVideo(widget.videoPath);
                        },
                        child: const Text(
                          'Upload',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
