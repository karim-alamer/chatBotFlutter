import 'CustomerService/Ui/Webview/Screen/webview_screen.dart';
import 'CustomerService/providers/chat_provider.dart';
import 'Ui/StartApp/Screen/start_app_screen.dart';
import 'package:flutter/material.dart';
//
import 'CustomerService/Ui/FrequentQuestions/Screen/frequent_questions_screen.dart';
import 'CustomerService/Ui/Main/Screen/main_screen.dart';
import 'CustomerService/Ui/Opps/Screen/opps_screen.dart';

import 'CustomerService/Ui/Chat/Screen/chat_screen.dart';

import 'package:provider/provider.dart';
import 'CustomerService/Ui/Waiting/Screen/waiting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //print("------- current locale ---------");

    return MultiProvider(
      providers: [
        // Customer Serivce

        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: " نظام استعلامات النوادي والفنادق",
        color: Color(0xFFe1d5f5),
        theme: ThemeData(
          cursorColor: Color(0xFF416D6D),

          backgroundColor: Colors.grey[200],
          // We apply this to our appBarTheme because most of our appBar have this style
          appBarTheme: AppBarTheme(
            color: Colors.grey[200],
            elevation: 0,
          ),

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          // Customer Serivce
          ChatScreen.routeName: (ctx) => ChatScreen(),
          CustomerServiceMainScreen.routeName: (ctx) =>
              CustomerServiceMainScreen(),
          CustomerServiceOppsScreen.routeName: (ctx) =>
              CustomerServiceOppsScreen(),
          CustomerServiceWaitingScreen.routeName: (ctx) =>
              CustomerServiceWaitingScreen(),
          FrequentQuestionsScreen.routeName: (ctx) => FrequentQuestionsScreen(),
          StartAppScreen.routeName: (ctx) => StartAppScreen(),
          WebviewScreen.routeName: (ctx) => WebviewScreen(),
        },
        home: StartAppScreen(),
      ),
    );
  }
}
