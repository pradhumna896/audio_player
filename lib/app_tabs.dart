import 'package:flutter/material.dart';
import 'package:audio_player/app_color/app_color.dart' as AppColors;

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;
  const AppTabs({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 7,
                offset: const Offset(0, 0))
          ]),
      child:Text(
        text,
        style: const TextStyle(color: Colors.white,fontSize: 20),
      ),
      
     
    );
  }
}
