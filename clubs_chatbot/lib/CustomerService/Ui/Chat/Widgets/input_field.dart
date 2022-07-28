import 'dart:math';

import '../../../providers/chat_provider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../../Ui/1MainHelper/Alerts/alerts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class InputFullCard extends StatefulWidget {
  @override
  _InputFullCardState createState() => _InputFullCardState();
}

class _InputFullCardState extends State<InputFullCard> {
  final userInputController = TextEditingController();

  Future<void> sendQuestion(
    BuildContext context,
    String question,
  ) async {
    DateTime sendDate = DateTime.now();
    Provider.of<ChatProvider>(context, listen: false).addClientQuestion(
      question: question,
      sendDate: sendDate,
    );
    userInputController.clear();

    String requestStatus =
        await Provider.of<ChatProvider>(context, listen: false).sendHttpRequest(
      question: question,
    );
    if (requestStatus != null) {
      showAlertNoAction(
        context: context,
        message: requestStatus,
      );

      return;
    }
  }

  bool _hasSpeech = false;

  bool _logEvents = false;

  double level = 0.0;

  double minSoundLevel = 50000;

  double maxSoundLevel = -50000;

  String lastWords = '';

  String lastError = '';

  String lastStatus = '';

  String _currentLocaleId = '';

  List<LocaleName> _localeNames = [];

  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onStatus: (statusListener) {
          print(statusListener);
        },
        onError: (errorListener) {
          print(errorListener);
        },
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      _localeNames = await speech.locales();

      // ar_EG

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  Future<void> runSpeechRecogonition() async {
    stt.SpeechToText speech = stt.SpeechToText();

    bool available = await speech.initialize(
      onStatus: (statusListener) {
        print('status000');
        print(statusListener);
      },
      onError: (errorListener) {
        print('error000');
        print(errorListener);
      },
    );
    if (available) {
      await speech.listen(
        onResult: (resultListener) {
          print("result");
          print(resultListener);
        },
        partialResults: true,
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
    // some time later...
    //speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 2,
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xFF547B7B),
              child: IconButton(
                icon: Icon(
                  CommunityMaterialIcons.microphone_outline,
                  size: 28,
                  color: Colors.white,
                ),
                onPressed: () async {
                  startListening();
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: userInputController,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: "اسأل ما تريد",
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    helperMaxLines: 4,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 5,
            ),
            child: CircleAvatar(
              backgroundColor: Color(0xFF547B7B),
              child: IconButton(
                icon: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                ),
                onPressed: () async {
                  String userInput = userInputController.text.trim();
                  if (userInput.isEmpty) {
                    return;
                  } else {
                    await sendQuestion(
                      context,
                      userInput,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    print("----------currentLocaleId----------");
    print(_currentLocaleId);
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    print('888888888888888888888888');
    print(result.recognizedWords);
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');

    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
      userInputController.text = result.recognizedWords;
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }
}
