/*import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  late Uri lenk; // Declaração da variável lenk

  void getUrl(url) {
    setState(() {
      lenk = Uri.parse(url); // Atribuição de valor à variável lenk
    });
  }

  @override
  void initState(){
    super.initState();
    initPlayer();
  }

  void initPlayer() async{
    videoPlayerController = VideoPlayerController.networkUrl(
      lenk  
    );
    await videoPlayerController.initialize();
  
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
    );
  @override
  void dispose(){
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }
  }

  

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('player'),
      ),
      body: chewieController!=null? Padding(padding: EdgeInsets.all(32),
      child: Chewie(controller: chewieController!,),
      ): Center(
        child: CircularProgressIndicator(),
      )
      );
  }
}*/