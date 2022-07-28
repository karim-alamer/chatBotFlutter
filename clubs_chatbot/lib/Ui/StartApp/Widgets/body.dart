import '../../../CustomerService/Ui/Main/Screen/main_screen.dart';
import '../../../CustomerService/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
//
import 'background.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  // Fetch app offline data
  Future<void> futureFn(BuildContext context) async {
    await Future.delayed(
      Duration(
        seconds: 4,
      ),
    );
    await Provider.of<ChatProvider>(context, listen: false).fetchJsonData();
    Navigator.of(context)
        .pushReplacementNamed(CustomerServiceMainScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "مرحبا بك في نظام استعلامات نوادي وفنادق القوات المسلحة المصرية",
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  color: Color(0xFF416D6D),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/1.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.05),
            FutureBuilder(
              future: futureFn(context),
              builder: (fbctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SpinKitChasingDots(
                      color: Color(0xFF416D6D),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
