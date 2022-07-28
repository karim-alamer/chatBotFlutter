import 'package:assets_audio_player/assets_audio_player.dart';
import '../../CustomerService/Ui/FrequentQuestions/Models/frequent_question_model.dart';
import '../../CustomerService/models/message_details_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {
  List<FrequentQuestionModel> allQuestionsAndAnswers = [];

  List<MessageDetailsModel> chatMessages = [
    MessageDetailsModel(
      meesage: 'مرحبا بك! ماذا تريد ان تسأل',
      sendDate: DateTime.now(),
      senderType: 'Chatbot',
    ),
  ];
  List<MessageDetailsModel> getChatMessages() {
    return [...chatMessages];
  }

  // http://192.168.8.162:5000/getResponse?q=شروط الاعفاء من التجنيد
  Future<String> sendHttpRequest({String question}) async {
    try {
      // Check internet connection
      bool check = await checkInternetConnection();

      if (!check) {
        return 'لا يوجد لديك اتصال بالانترنت';
      }
      var client = http.Client();
      String url = 'http://192.168.8.162:5000/getResponse?q=' + question;
      Uri uri = Uri.parse(url);

      //await getHttp(question: question);

      http.Response response = await client.get(
        uri,
        //headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        //
        await addChatbotAnswer(
          answer: response.body,
        );
      }

      return null;
    } on TimeoutException {
      return 'السيرفير لايعمل في الوقت الحالي, من فضلك حاول في وقتا اخر';
    } on SocketException catch (_) {
      return 'لايوجد لديك اتصال بالانترنت';
    } catch (e) {
      print(e);
      return 'لقد حدث خطأ';
    }
  }

  Future<void> addChatbotAnswer({String answer}) async {
    chatMessages.add(
      MessageDetailsModel(
        meesage: answer,
        sendDate: DateTime.now(),
        senderType: "Chatbot",
      ),
    );

    // Say the answer
    await speak(answer);
    notifyListeners();
  }

  //Fetch content from the json file
  Future<void> fetchJsonData() async {
    if (allQuestionsAndAnswers.length > 0) {
      return;
    }
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final data = await json.decode(response);
    List listOfMaps = data['intents'];
    //print(listOfMaps);
    listOfMaps.forEach((element) {
      allQuestionsAndAnswers.add(
        FrequentQuestionModel(
          question: element['patterns'][0],
          answer: element['responses'][0],
          tag: element['tag'],
        ),
      );
    });
  }

  List<FrequentQuestionModel> get getFrequentQuestions {
    return [...allQuestionsAndAnswers];
  }

  String getTagNumber({String answer}) {
    FrequentQuestionModel frequentQuestionModel = allQuestionsAndAnswers
        .firstWhere((element) => element.answer == answer);
    return frequentQuestionModel.tag;
  }

  /////////////////////////////////////////////////////////////
  // Configuring text to speech library
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  Future<void> stopAudio() async {
    await _assetsAudioPlayer.stop();
  }

  Future<void> speak(String answer) async {
    if (answer == 'عذراً لا أستطيع أن أفهمك') {
      await _assetsAudioPlayer.open(
        Audio("assets/sounds/noAnswer.mp3"),
        autoStart: true,
        volume: 1,
      );

      return;
    }
    String tagNumber = getTagNumber(
      answer: answer,
    );
    print("-----------------" + tagNumber);
    await _assetsAudioPlayer.open(
      Audio("assets/sounds/$tagNumber.mp3"),
      autoStart: true,
      volume: 1,
    );
  }

  void addClientQuestion({String question, DateTime sendDate}) {
    chatMessages.add(
      MessageDetailsModel(
        meesage: question,
        sendDate: sendDate,
        senderType: "Client",
      ),
    );
    notifyListeners();
  }

  Future<bool> checkInternetConnection() async {
    try {
      await InternetAddress.lookup('google.com');
      //Nothing to do --> continue in code
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }
}
