import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({super.key, required this.text, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            minimumSize: const Size.fromHeight(50),
            shape: const StadiumBorder()),
        onPressed: onClicked,
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ));
  }
}
