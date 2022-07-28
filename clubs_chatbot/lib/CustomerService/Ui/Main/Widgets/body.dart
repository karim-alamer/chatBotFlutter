import 'package:clubs_chatbot/CustomerService/Ui/Webview/Screen/webview_screen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../FrequentQuestions/Screen/frequent_questions_screen.dart';
import '../../../providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import '../../Chat/Screen/chat_screen.dart';
import 'buttons.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFf2cf93).withOpacity(.2),
              Color(0xFFbf9c60),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Top(),
                    Bottom(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Image.asset(
            // 'assets/images/2.png',
            // height: 85,
            //),

            //Image.asset(
            //'assets/images/2.png',
            //height: 85,
            //),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'نظام استعلامات نوادي وفنادق القوات المسلحة المصرية',
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Color(0xFF416D6D),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          height: size.height * 0.45,
          child: Image.asset("assets/images/chatbot.png"),
        ),
      ],
    );
  }
}

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
          backgroundColor: Color(0xFF8795DD),
          function: () async {
            final result =
                await Navigator.of(context).pushNamed(ChatScreen.routeName);

            await Provider.of<ChatProvider>(context, listen: false).stopAudio();
          },
          title: "محادثة الية",
          textColor: Colors.white,
        ),
        Button(
          backgroundColor: Color(0xFF364F8A),
          function: () {
            Navigator.of(context).pushNamed(FrequentQuestionsScreen.routeName);
          },
          title: "الأسئلة الشائعة",
          textColor: Colors.white,
        ),
        Button(
          backgroundColor: Color(0xFF8795DD),
          function: () async {
            showImage2(
              context: context,
              imageUrl: 'assets/images/clubs1.jpg',
            );
          },
          title: "نوادي وفنادق القاهرة الكبرى",
          textColor: Colors.white,
        ),
        Button(
          backgroundColor: Color(0xFF364F8A),
          function: () async {
            showImage2(
              context: context,
              imageUrl: 'assets/images/clubs2.jpg',
            );
          },
          title: "JEWEL Hotels",
          textColor: Colors.white,
        ),
        Button(
          backgroundColor: Color(0xFF8795DD),
          function: () async {
            await launch('http://www.afhotels.com.eg/');
          },
          title: "زيارة موقعنا",
          textColor: Colors.white,
        ),
      ],
    );
  }
}

void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

void showImage2({BuildContext context, String imageUrl}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[850],
            actions: [
              Image.asset(
                'assets/images/2.png',
              )
            ],
          ),
          body: Container(
            color: Colors.grey[200],
            child: PhotoView(
              imageProvider: AssetImage(
                imageUrl,
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 700),
    ),
  );
}
