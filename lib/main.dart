// ignore: duplicate_ignore
// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygate/screens/Profile%20Page/profilepage.dart';
import 'package:mygate/screens/complaints/complaints.dart';
import 'package:mygate/screens/homescreen/home_screen.dart';
import 'package:mygate/screens/login/commlogin.dart';
import 'package:mygate/screens/login/resilogin.dart';
import 'package:mygate/screens/login/roleselect.dart';
import 'package:mygate/screens/login/signup.dart';
import 'package:mygate/screens/login/stafflogin.dart';
import 'package:mygate/screens/splashscreen/splash_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'cJ301ST6MRr5abrhRsHqXAK0B2BXNHwztq0X5OjF';
  const keyClientKey = '5akFPzBRPSxl1p12ks4EWLyyZ96xYL7o9bkeQM6O';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
      await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'MyGate',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[100],
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const splash(),
        'role_select': (context) => const roleselect(),
        'signup': (context) => const signup(),
        'resilogin': (context) => const resilogin(),
        'commlogin': (context) => const commlogin(),
        'stafflogin': (context) => const stafflogin(),
        'homescreen': (context) => const homescreen(),
        'editprofile': (context) =>  const editprofile(),
        'complaints': (context) =>  const complaints(),
      },
      
    );
  }
}
