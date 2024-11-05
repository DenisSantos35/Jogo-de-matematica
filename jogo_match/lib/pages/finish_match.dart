import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jogo_match/controller/intial_controller.dart';
import 'package:jogo_match/pages/initial_page.dart';
import 'package:just_audio/just_audio.dart';

class FinishMatch extends StatefulWidget {
  FinishMatch({super.key}) {
    timeOutPage();
  }

  final player = AudioPlayer();

  Future<void> timeOutPage() async {
    await Future.delayed(Duration(seconds: 8));
    player.stop();
    Get.lazyPut(() => IntialController());
    Get.offAll(InitialPage(
      controller: IntialController(),
    ));
  }

  @override
  State<FinishMatch> createState() => _FinishMatchState();
}

class _FinishMatchState extends State<FinishMatch> {
  @override
  void initState() {
    super.initState();
    widget.player.setAsset('assets/energetic-bgm-242515.mp3');
    widget.player.play();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            height: Get.height,
            child: Image.asset(
              "assets/cel_grama.avif",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: Get.height * 0.2,
            width: Get.width,
            child: Image.asset(
              "assets/winner.gif",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Container(
              height: Get.height * 0.8,
              child: Image.asset(
                "assets/campeao2_matematica.gif",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
