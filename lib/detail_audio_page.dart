import 'package:audio_player/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/app_color/app_color.dart' as AppColors;


class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const DetailAudioPage({super.key,this.booksData,required this.index});

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancedPlayer;
  @override
  void initState() {
    advancedPlayer = AudioPlayer();
    super.initState();
  }
  @override
 
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(children: [
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(
              color: AppColors.audioBlueBackground,
            )),
        Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, icon: const Icon(Icons.arrow_back_ios)),
              actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
            )),
        Positioned(
          left: 0,
          right: 0,
          top: screenHeight * 0.22,
          height: screenHeight * 0.38,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Text(
                  widget.booksData[widget.index]["title"],
                  style:const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(widget.booksData[widget.index]["text"],style:const  TextStyle(
                  fontSize: 20
                ),),
                AudioFile(advancedPlayer: advancedPlayer,audioPath:widget.booksData[widget.index]["audio"])
              ],
            ),
          ),
        ),
        Positioned(
          top:  screenHeight*0.12, 
          left: (screenWidth-150)/2,
          right: (screenWidth-150)/2,
          height: screenHeight*0.2,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.audioGreyBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white,width:2)
            ),
            child: Padding(padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:Border.all(color:Colors.white,width:5),
                image:  DecorationImage(fit:BoxFit.cover,image: AssetImage(widget.booksData[widget.index]["img"],))
            ),
            ),
            
          )))
      ]),
    );
  }
}
