import 'package:flutter/material.dart';
import 'package:jogo_match/utils/result_message.dart';

abstract class ShowDialogHelper {
  //Classe responsavel pelos dialogos informativos na tela do jogo

  //Dialogo caso resposta esteja correta
  static showDialogCorrect(
      {required VoidCallback goToNextQuestion, required BuildContext context}) {
    return showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: "Correto!",
            onTap: goToNextQuestion,
            icon: Icons.arrow_forward,
            isSucess: true,
          );
        });
  }

  //Dialogo caso resposta esteja incorreta
  static showDalogIncorrect(
      {required VoidCallback goToBackQuestion, required BuildContext context}) {
    return showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: "Desculpe, Tente novamente!",
            onTap: goToBackQuestion,
            icon: Icons.rotate_left,
            isSucess: false,
          );
        });
  }
}
