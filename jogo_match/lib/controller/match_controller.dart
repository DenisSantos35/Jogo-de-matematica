import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jogo_match/helper/show_dialog_helper.dart';
import 'package:jogo_match/pages/finish_match.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

class MatchController extends GetxController {
  /* Classe responsavel por controlar os estados do jogo*/
  //Instancia do pacote de áudio https://pub.dev/packages/just_audio/install
  final player = AudioPlayer();

  // declaração das váriaveis que serão observadas na página do jogo
  //o count é o que faz a mudança das fazes do jogo.
  //userAnswer é o que recebe as respostas digitadas pelo usuário
  // numberA e NumberB são os numeros que farão a operação para o jogador advinhar
  // size number e o tamanho limite que sera atribuido para o numero que sera gerado aleatório ex.:(1 á 10)
  //lengthAnswer é o tamanho limite de digitos que o usário poderá colocar nas respostas.
  //finalFaze é o que vai observar e ativar o teclado da faze final
  //isPlayed responsavel pela ativação e desativação dos áudios

  final _numberA = 1.obs;
  final _numberB = 1.obs;
  final _operator = "+".obs;
  final _count = 0.obs;
  final _userAnswer = ''.obs;
  final _sizeNumber = 10.obs;
  final _lengthAnswer = 3.obs;
  final _finalFaze = false.obs;
  final _isPlayed = false.obs;

  final _level = 0.obs;

  // Geters das váriaveis privadas
  int get numberA => _numberA.value;
  int get numberB => _numberB.value;
  int get count => _count.value;
  String get operator => _operator.value;
  String get userAnswer => _userAnswer.value;
  int get level => _level.value;
  int get sizeNumber => _sizeNumber.value;
  int get lengthAnswer => _lengthAnswer.value;
  bool get finalFaze => _finalFaze.value;
  bool get isPlayed => _isPlayed.value;

  //seters das variaveis privadas
  set numberA(int value) => _numberA.call(value);
  set numberB(int value) => _numberB.call(value);
  set count(int value) => _count.call(value);
  set operator(String value) => _operator.call(value);
  set userAnswer(String value) => _userAnswer.call(value);
  set level(int value) => _level.call(value);
  set sizeNumber(int value) => _sizeNumber.call(value);
  set lengthAnswer(int value) => _lengthAnswer.call(value);
  set finalFaze(bool value) => _finalFaze.call(value);
  set isPlayed(bool value) => _isPlayed.call(value);

  // Geração dos numeros aleatórios para os calculos
  Random randomNumber = Random();

  // Numeros do teclado da tela do jogo cálculos (+, - , X)
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0'
  ];

  // Numeros do teclado da tela do jogo cálculos (/)
  List<String> numberPadFinal = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '.',
    '0'
  ];

  //methods

  //Ir para proxima questão
  void goToNextQuestion() {
    //Realiza som ao clicar no botão
    getFinishCard();
    Get.back();

    // atualização de estado para as fazes do jogos

    count += 1;
    update();
    userAnswer = "";
    update();

    if (count < 3) {
      //creação de novas questões
      modifyNumber(sizeNumber: sizeNumber, numberLevel: 0, operador: "+");
    } else if (count < 6) {
      modifyNumber(sizeNumber: sizeNumber, numberLevel: 1, operador: "-");
      while (numberA < numberB) {
        modifyNumber(sizeNumber: sizeNumber, numberLevel: 1, operador: "-");
      }
    } else if (count < 9) {
      modifyNumber(sizeNumber: sizeNumber, numberLevel: 2, operador: "X");
    } else if (count < 12 && sizeNumber == 100 && lengthAnswer == 4) {
      modifyNumber(sizeNumber: sizeNumber + 4, numberLevel: 2, operador: "÷");
      finalFaseGame();
    } else {
      //limpeza e reset de todos valores e váriaveis
      clearValue();
    }
  }

  //átivação da faze final do jogo
  void finalFaseGame() {
    finalFaze = true;
    update();
  }

  // Limpeza e reset de todos os valores do jogo
  void clearValue() {
    sizeNumber *= 10;
    lengthAnswer++;
    level = 0;
    count = 0;
    numberA = randomNumber.nextInt(10);
    numberB = randomNumber.nextInt(10);
    operator = "+";
    if (lengthAnswer == 5) {
      finalFaze = false;
      lengthAnswer = 3;
      sizeNumber = 10;
      player.pause();
      Get.to(FinishMatch());
    }
    update();
  }

  //modifica o estado dos numeros e operadores na tela do jogo.
  void modifyNumber(
      {required int sizeNumber,
      required int numberLevel,
      required String operador}) {
    level = numberLevel;
    operator = operador;
    numberA = randomNumber.nextInt(sizeNumber);
    numberB = randomNumber.nextInt(sizeNumber);
    if (operador == '÷') {
      while (numberA == 0 || numberB == 0) {
        numberA = randomNumber.nextInt(sizeNumber);
        numberB = randomNumber.nextInt(sizeNumber);
      }
    }
    update();
  }

  //Retorno da caixa de dialogo caso esteja incorreto a questao
  void goToBackQuestion() {
    // dismiss alert dialog
    getFinishCard();
    Get.back();
  }

  //Checagem se o usuário colocou resultado correto ou incorreto
  void checkResult({required BuildContext context}) {
    if (count < 3) {
      if (numberA + numberB == int.parse(userAnswer)) {
        //caixa de dialogo caso resultado esteja correto
        ShowDialogHelper.showDialogCorrect(
            goToNextQuestion: goToNextQuestion, context: context);
      } else {
        userAnswer = "";
        //caixa de dialogo caso resultado esteja icorreto
        ShowDialogHelper.showDalogIncorrect(
            goToBackQuestion: goToBackQuestion, context: context);
      }
    } else if (count < 6) {
      if (numberA - numberB == int.parse(userAnswer)) {
        ShowDialogHelper.showDialogCorrect(
            goToNextQuestion: goToNextQuestion, context: context);
      } else {
        userAnswer = "";
        ShowDialogHelper.showDalogIncorrect(
            goToBackQuestion: goToBackQuestion, context: context);
      }
    } else if (count < 9) {
      if (numberA * numberB == int.parse(userAnswer)) {
        ShowDialogHelper.showDialogCorrect(
            goToNextQuestion: goToNextQuestion, context: context);
      } else {
        userAnswer = "";
        ShowDialogHelper.showDalogIncorrect(
            goToBackQuestion: goToBackQuestion, context: context);
      }
    } else if (count < 12) {
      if ((numberA / numberB).toStringAsFixed(2) ==
          double.parse(userAnswer).toStringAsFixed(2)) {
        ShowDialogHelper.showDialogCorrect(
            goToNextQuestion: goToNextQuestion, context: context);
      } else {
        userAnswer = "";
        ShowDialogHelper.showDalogIncorrect(
            goToBackQuestion: goToBackQuestion, context: context);
      }
    }
  }

  /*Lógica para botões que deletaram numero a numero, limpara toda tela,
    para sinal de igual, e fara o som dos botões.    
  */
  void buttonTapped({required String button, required BuildContext context}) {
    if (button == '=') {
      getTouch();
      //verifica o resultado se esta vazio
      if (userAnswer.isEmpty) {
        ShowDialogHelper.showDalogIncorrect(
            goToBackQuestion: goToBackQuestion, context: context);
        return;
      }
      //checa se resultado esta correto ou não
      checkResult(context: context);
    } else if (button == 'C') {
      //faz som do click do botão
      getClick();
      // limpa o input dque o usuario digitou
      userAnswer = '';
      update();
    } else if (button == 'DEL') {
      getClick();
      // deleta numero a numero sempre apartir do ultimo
      if (userAnswer.isNotEmpty) {
        userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        update();
      }
    } else if (button == '.') {
      getClick();
      //Permite colocar apenas 1 ponto no resultado a ser adivinhado
      if (!userAnswer.contains(".")) {
        userAnswer += button;
      }
    } else if (userAnswer.length < lengthAnswer) {
      getClick();
      userAnswer += button;
      update();
    }
  }

  //som no click dos botões
  void getClick() {
    player.setAsset('assets/click-151673.mp3');
    player.play();
  }

  void getTouch() {
    player.setAsset('assets/achive-sound-132273.mp3');
    player.play();
  }

  void getFinishCard() {
    player.setAsset('assets/notification-5-140376.mp3');
    player.play();
  }
}
