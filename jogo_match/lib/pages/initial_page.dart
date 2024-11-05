import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jogo_match/controller/intial_controller.dart';
import 'package:jogo_match/controller/match_controller.dart';
import 'package:jogo_match/pages/home_page.dart';
import 'package:just_audio/just_audio.dart';

class InitialPage extends StatefulWidget {
  IntialController controller;
  InitialPage({required this.controller});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setAsset('assets/lady-of-the-80x27s-128379.mp3');
    player.play();
    widget.controller.isPlay = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            height: Get.height,
            child: Image.asset(
              "assets/init_match.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: Get.width,
            height: Get.height,
            padding: EdgeInsets.all(24),
            alignment: Alignment.topRight,
            child: Obx(
              () => IconButton(
                  onPressed: () {
                    widget.controller.isPlay = !widget.controller.isPlay;
                    if (widget.controller.isPlay) {
                      player.stop();
                    } else {
                      player.play();
                    }
                  },
                  icon: Icon(
                    widget.controller.isPlay
                        ? Icons.volume_off_outlined
                        : Icons.volume_up_outlined,
                    color: Colors.white,
                    size: 35,
                  )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: Get.height * 0.30,
                  child: const Text(
                    "MATCH QUEST\n ",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontFamily: "Times New Roman",
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          )
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  player.stop();
                  final result = await widget.controller.getTouch();
                  if (result) {
                    Get.lazyPut(() => MatchController());
                    Get.to(HomePage(
                      controller: MatchController(),
                    ));
                  }
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: Get.height * 0.06,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black,
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ]),
                    child: const Text(
                      "INICIAR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
