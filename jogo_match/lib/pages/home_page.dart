import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jogo_match/controller/match_controller.dart';
import 'package:jogo_match/utils/const.dart';
import 'package:jogo_match/utils/colors_app.dart';
import 'package:jogo_match/utils/levels.dart';
import 'package:jogo_match/utils/my_button.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  final MatchController controller;
  HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.setAsset(
        'assets/puzzle-game-bright-casual-video-game-music-249202.mp3');
    player.play();
    player.setLoopMode(LoopMode.one);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: widget.controller.finalFaze
            ? Colors.orange[300]
            : Colors.deepPurple[300],
        body: Obx(
          () => SafeArea(
            child: Column(
              children: [
                // level progress, player needs 5 correct answers in a row to proceed to next level
                Container(
                  height: 160,
                  color: widget.controller.finalFaze
                      ? Colors.orange
                      : ColorsApp.purple,
                  child: Obx(
                    () => widget.controller.finalFaze
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Levels(
                                color: Colors.white,
                                icon: CupertinoIcons.divide_circle,
                                size: widget.controller.level == 0 ? 80 : 70,
                                colorIcon: Colors.orange,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Levels(
                                color: widget.controller.level == 0
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.3),
                                icon: Icons.add_circle_outline,
                                size: widget.controller.level == 0 ? 80 : 70,
                                colorIcon: ColorsApp.purple,
                              ),
                              Levels(
                                color: widget.controller.level == 1
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.3),
                                icon: Icons.remove_circle_outline,
                                size: widget.controller.level == 1 ? 80 : 70,
                                colorIcon: ColorsApp.purple,
                              ),
                              Levels(
                                color: widget.controller.level == 2
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.3),
                                icon: Icons.cancel_outlined,
                                size: widget.controller.level == 2 ? 80 : 70,
                                colorIcon: ColorsApp.purple,
                              ),
                            ],
                          ),
                  ),
                ),

                //question
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorsApp.purple.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //question
                          Obx(
                            () => Text(
                              "${widget.controller.numberA} ${widget.controller.operator} ${widget.controller.numberB} = ",
                              style: whiteTexStyle,
                            ),
                          ),
                          //answer box
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: widget.controller.finalFaze
                                    ? Colors.orange
                                    : Colors.deepPurple,
                                borderRadius: BorderRadius.circular(4)),
                            child: Card(
                              color: widget.controller.finalFaze
                                  ? ColorsApp.orange400
                                  : ColorsApp.purple400,
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    widget.controller.userAnswer,
                                    style: whiteTexStyle,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),

                //number pad
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: GridView.builder(
                            itemCount: widget.controller.finalFaze
                                ? widget.controller.numberPadFinal.length
                                : widget.controller.numberPad.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemBuilder: (context, index) {
                              return MyButton(
                                child: widget.controller.finalFaze
                                    ? widget.controller.numberPadFinal[index]
                                    : widget.controller.numberPad[index],
                                onTap: () => widget.controller.buttonTapped(
                                  button: widget.controller.finalFaze
                                      ? widget.controller.numberPadFinal[index]
                                      : widget.controller.numberPad[index],
                                  context: context,
                                ),
                                controller: widget.controller,
                              );
                            }),
                      ),
                    )),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  alignment: Alignment.topRight,
                  child: Obx(
                    () => IconButton(
                        onPressed: () {
                          widget.controller.isPlayed =
                              !widget.controller.isPlayed;

                          if (widget.controller.isPlayed) {
                            setState(() {
                              player.setLoopMode(LoopMode.off);
                              player.stop();
                            });
                          } else {
                            setState(() {
                              player.setLoopMode(LoopMode.one);
                              player.play();
                            });
                          }
                        },
                        icon: Icon(
                          widget.controller.isPlayed
                              ? Icons.volume_off
                              : Icons.volume_up_outlined,
                          size: 35,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
