import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  const AudioFile(
      {super.key, required this.advancedPlayer, required this.audioPath});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  final List<IconData> _icons = [
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
    widget.advancedPlayer.setSourceUrl(widget.audioPath);

    widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  @override
  void dispose() {
    widget.advancedPlayer.pause();
    super.dispose();
  }

  Widget btnStart() {
    return IconButton(
        padding: const EdgeInsets.only(bottom: 10),
        onPressed: () {
          if (isPlaying == false) {
            widget.advancedPlayer.play(UrlSource(widget.audioPath));
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          btnRepeat(),
          btnSlow(),
          const SizedBox(
            width: 15,
          ),
          btnStart(),
          const SizedBox(
            width: 15,
          ),
          btnFast(),
          btnLoop()
        ],
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
        icon: const Icon(
          Icons.fast_forward,
        ));
  }

  Widget btnSlow() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer.setPlaybackRate(0.5);
        },
        icon: const Icon(
          Icons.fast_rewind,
        ));
  }

  Widget btnRepeat() {
    return IconButton(
        onPressed: () {
          if (isRepeat == false) {
            widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
            setState(() {
              isRepeat = true;
              color = Colors.blue;
            });
          } else if (isRepeat == true) {
            widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
            setState(() {
              color = Colors.black;
              isRepeat = false;
            });
          }
        },
        icon: Icon(Icons.loop, color: color));
  }

  Widget btnLoop() {
    return IconButton(
        onPressed: () {
          if (isRepeat == false) {
            widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
            setState(() {
              isRepeat = true;
            });
          }
        },
        icon: const Icon(
          Icons.next_plan,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
