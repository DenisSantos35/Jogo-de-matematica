import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class IntialController extends GetxController {
  /* A páginal initial controller tem como objetivo gerenciar estados da "initial page" */
  //Declaração das váriaveis com observaveis ver documentação GetX. https://pub.dev/packages/get

  //Responsavel pela verificação d estado do áudio.
  final _isPlay = false.obs;
  bool get isPlay => _isPlay.value;
  set isPlay(bool value) => _isPlay.call(value);

  //instancia audio player doc: https://pub.dev/packages/just_audio/install
  final player = AudioPlayer();

  // Funçaõ responsavel pelo audio dos teclados numericos.
  Future<bool> getTouch() async {
    player.setAsset('assets/achive-sound-132273.mp3');
    player.play();
    await Future.delayed(Duration(milliseconds: 600));
    player.stop();
    return true;
  }
}
