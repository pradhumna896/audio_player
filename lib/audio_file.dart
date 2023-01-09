import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  const AudioFile({super.key, required this.advancedPlayer});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  final String path = "https://file.api.audio/demo.mp3";
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  @override
  void initState() {
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.advancedPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    widget.advancedPlayer.setSourceUrl(path);
  }

  Widget btnStart() {
    return IconButton(
        padding: const EdgeInsets.only(bottom: 10),
        onPressed: () {
          if (isPlaying == false) {
            widget.advancedPlayer.play(UrlSource(path));
            setState(() {
              isPlaying = true;
            });
          } else if (isPlaying == true) {
            widget.advancedPlayer.pause();
            setState(() {
              isPlaying = false;
            });
          }
        },
        icon: isPlaying == false
            ? Icon(
                _icons[0],
                size: 59,
                color: Colors.blue,
              )
            : Icon(
                _icons[1],
                size: 59,
                color: Colors.blue,
              ));
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [btnSlow(), btnStart(), btnFast()],
      ),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        value: _position.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(
            () {
              changeToSecond(value.toInt());
              value = value;
            },
          );
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  Widget btnFast() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer.setPlaybackRate(1.5);
        },
        icon: const Icon(Icons.fast_forward, size: 50));
  }

  Widget btnSlow() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer.setPlaybackRate(0.5);
        },
        icon: const Icon(Icons.fast_rewind, size: 50));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split(".")[0],
                    style: const TextStyle(fontSize: 16)),
                Text(_duration.toString().split(".")[0],
                    style: const TextStyle(fontSize: 16))
              ],
            ),
          ),
          slider(),
          loadAsset()
        ],
      ),
    );
  }
}
