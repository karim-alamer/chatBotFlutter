import '../Models/frequent_question_model.dart';
import '../Widgets/single_question_answer.dart';
import '../../../providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'search_card.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isInit = false;
  List<FrequentQuestionModel> allFrequentQuestions = [];
  List<FrequentQuestionModel> searchFrequentQuestions = [];

  Future<void> fetchJsonData() async {
    if (_isInit) {
      return;
    }

    await Provider.of<ChatProvider>(context, listen: false).fetchJsonData();
    allFrequentQuestions =
        Provider.of<ChatProvider>(context, listen: false).getFrequentQuestions;
    searchFrequentQuestions = allFrequentQuestions;
    _isInit = true;

    return null;
  }

  void search(String searchValue) {
    setState(() {
      searchFrequentQuestions = allFrequentQuestions
          .where((element) => element.question.contains(searchValue))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchCard(
          onChange: (value) => search(value),
        ),
        FutureBuilder(
          future: fetchJsonData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SpinKitChasingDots(
                  color: Color(0xFF638D8D),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: searchFrequentQuestions.length,
                  itemBuilder: (context, index) => SingleQuestionAnswer(
                    question: searchFrequentQuestions[index].question,
                    answer: searchFrequentQuestions[index].answer,
                    counter: index + 1,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
