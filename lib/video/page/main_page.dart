import 'dart:io';
import 'package:audio_player/video/widget/button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import '../api/video_compress_api.dart';
import '../widget/progress_dialog_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  File? fileVideo;
  Uint8List? thumbnailBytes;
  int? videoSize;
  MediaInfo? compressedVideoInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: clearSelection, child: Text("Clear"))],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(40),
        child: buildContent(),
      ),
    );
  }

  void clearSelection() {
    compressedVideoInfo = null;
    fileVideo = null;
  }

  Widget buildContent() {
    if (fileVideo == null) {
      return ButtonWidget(text: 'Pick Video', onClicked: pickVideo);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildThumbnail(),
          const SizedBox(
            height: 20,
          ),
          buildVideoInfo(),
          const SizedBox(
            height: 20,
          ),
          buildVideoCompressedInfo(),
          const SizedBox(
            height: 20,
          ),
          ButtonWidget(text: 'Compress Video', onClicked: compressVideo)
        ],
      );
    }
  }

  Widget buildVideoCompressedInfo() {
    if (compressedVideoInfo == null) return Container();
    final size = compressedVideoInfo!.filesize! / 1000;
    return Column(
      children: [
        const Text("Compressed video info",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 8,
        ),
        Text(
          '$size KB',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        Text('${compressedVideoInfo!.file}')
      ],
    );
  }

  Future compressVideo() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Dialog(
            child: ProgressDialogWidget(),
          );
        });
    final info = await VideoCompressApi.compressVideo(fileVideo!);

    setState(() {
      compressedVideoInfo = info;
    });
    Navigator.of(context).pop();
  }

  Widget buildVideoInfo() {
    if (videoSize == null) return Container();
    final size = videoSize! / 1000;
    return Column(
      children: [
        const Text(
          'Original Video info',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$size KB',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildThumbnail() => thumbnailBytes == null
      ? const CircularProgressIndicator()
      : Image.memory(
          thumbnailBytes!,
          height: 100,
        );

  Future pickVideo() async {
    final picker = ImagePicker();
    final PickedFile = await picker.getVideo(source: ImageSource.gallery);

    if (PickedFile == null) return;
    final file = File(PickedFile.path);

    setState(() {
      fileVideo = file;
    });
    generateThumbnail(fileVideo!);
    getVideoSize(fileVideo!);
  }

  Future generateThumbnail(File file) async {
    final thumbnailBytes = await VideoCompress.getByteThumbnail(file.path);

    setState(() {
      this.thumbnailBytes = thumbnailBytes;
    });
  }

  Future getVideoSize(File file) async {
    final size = await file.length();

    setState(
      () => videoSize = size,
    );
  }
}
