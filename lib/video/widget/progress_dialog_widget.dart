import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';

class ProgressDialogWidget extends StatefulWidget {
  const ProgressDialogWidget({super.key});

  @override
  State<ProgressDialogWidget> createState() => _ProgressDialogWidgetState();
}

class _ProgressDialogWidgetState extends State<ProgressDialogWidget> {
  late Subscription subscription;
  double? progress;
  @override
  void initState() {
    
    super.initState();

    subscription = VideoCompress.compressProgress$.subscribe((progress) {
      setState(() {
        this.progress = progress;
      });
    });
  }

  @override
  void dispose() {
    VideoCompress.cancelCompression();
    subscription.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = progress == null ? progress : progress! / 100;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Compressing Video...',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20,),
          LinearProgressIndicator(
            value: value,
            minHeight: 12,
          ),
          const SizedBox(height: 16,),
          ElevatedButton(onPressed: (){
            VideoCompress.cancelCompression();
          }, child: const Text("Cancel"))
        ],
      ),
    );
  }
}
