import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void handlePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    player.setAsset('assets/sample.mp3');
    // player.setUrl(
    //     'https://innopsi.s3.ap-south-1.amazonaws.com/Test_audio.mp3?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGsaCmFwLXNvdXRoLTEiRjBEAiAZMmNGK%2BAxnhveC7w%2FJXtAvgZ3Xck%2BZ5jH3IYGLNrbCAIgO1C9fHFULZKHQXlBSD6RKk%2FxJQQ64dgLXqX1tI%2FzfbQqhgMI1P%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARABGgw5NzYzMTE2NDE0NjgiDOKIcHAAi67jfgVBairaAlEODAHECP3KH8xTD18RwPPsoOMF2b7%2FhHd5sfKKmOVZiOJKVIqFvNLBpKsxnWEVf6cuCk%2BjcAGv5NchqTwfNFuwSikiFI0f5EO5IUebGLUTj8Yfv2d9a6SWVV96Tzkns2d7DvHmwCCPEDO4uNAr0qgpzOj1z2eRNMj7%2BHbpjeM7NliaRUlTpJB8xlOgmttB%2FXhuxuTLceNuBJreblGMKAP%2F87tvo%2BPld8mtxUSd8UCF6iLnEp0F4YAZCBcwhwegobO9mRcMyUxjeUMCFc9kG7V12%2FQROR921sqN10IoNJ0h8B8sbCvEsvV%2FeBoUENSTub7JSBID4QsZQkYeYdgC1s7I%2F6%2FqONOM2CPi4qYHl8jucUbc0CTF2DKeOZdYpALX4meSEKct%2BI4mpVIOTttQ0E5slaxP3FbvtLJhwh5tVTrFJG99OtUQuxXKUKq6urWecET3vtC4dTa9X4Qw8ficsgY6tALA9EjmnSiwfVXlIfD7W9WHETxSMBexlJCBCgSNvo5a72%2F%2Fi015WcdHDpbahgfkdHFPyl%2Fy01XlUX41CU8PsJPYmCFTt6vTxAhU3avH4Ee5fLKxxsT6BaLbtsZGUMulg0BxzFR5UCQh17lTQXUUxJVW6rPdvmNsoSSFZq3VHY4HK1VBFiY6XBP8IJ%2F%2BI3b6RYiiLMmmdTwdI2usyWq9soOqDlC1trCOorYDpN67WNIMjD33VK88DypuZ6sZeMRpX9nHNlpi%2BrqV08gku9msIsPD9RYVULQiem4Y3OsDjSgChIV19GdoOIRxE6LuY%2BIQufI3dkSkMjyW8tPX%2BSzkdXYbJJnJifpEFTFunkTovEwuB7D5D%2F3gfyyCMl1OGJUPH0IJ8%2BoPlvOLAt%2FtCAl3n%2FPAfYib%2BA%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240517T111637Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIA6GUFVMV6MQNSHECM%2F20240517%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Signature=f45aaa26603847030fd6edcc1fc969ef62e2b66fe5194a464135fc26dda7f843');

    player.positionStream.listen((p) {
      setState(() => position = p);
    });

    player.durationStream.listen((d) {
      setState(() => duration = d!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(formatDuration(position)),
            Slider(
                min: 0.0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: handleSeek),
            Text(formatDuration(duration)),
            IconButton(
              icon: Icon(player.playing ? Icons.pause : Icons.play_arrow),
              onPressed: handlePlayPause,
            )
          ],
        ),
      ),
    );
  }
}
