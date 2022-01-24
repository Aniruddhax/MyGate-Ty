// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygate/config/size_config.dart';
import 'package:mygate/screens/Parking/cancel_allottment.dart';
import 'package:mygate/screens/Parking/check_allottement.dart';
import 'package:mygate/screens/Parking/request_allottment.dart';

class Parking_screen extends StatefulWidget {
  const Parking_screen({Key? key}) : super(key: key);

  @override
  _Parking_screenState createState() => _Parking_screenState();
}

class _Parking_screenState extends State<Parking_screen> {
  @override
  Widget build(BuildContext context) {
    //Normal tabs
    final normal_tabIcon = <Tab>[
      const Tab(
        text: "Request Allottment",
      ),
      const Tab(
        text: "Check Previous Allottment",
      ),
    ];
    final Normal_tabPages = <Widget>[
      //TAB 1
      const request_allotment(),
      //TAB 2
      const check_allottment(),
    ];
    //------

    //Committee tabs
    final Committee_tabIcon = <Tab>[
      const Tab(
        text: "Request \nAllottment",
      ),
      const Tab(
        text: "Check Previous \nAllottment",
      ),
      const Tab(
        text: "Cancel \nAllottment",
      ),
    ];
    final Committee_tabPages = <Widget>[
      //TAB 1
      const request_allotment(),
      //TAB 2
      const check_allottment(),
      //TAB 2
      const cancel_allottment(),
    ];
    //------

    final userdata = GetStorage();
    final role = userdata.read('role');

    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[100],
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
      home: DefaultTabController(
          length: role == 'Committee' ? 3 : 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Parking",
                  style: TextStyle(
                    fontSize: 25,
                  )),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
              bottom: TabBar(
                tabs: role == 'Committee' ? Committee_tabIcon : normal_tabIcon,
              ),
            ),
            body: TabBarView(
              children:
                  role == 'Committee' ? Committee_tabPages : Normal_tabPages,
            ),
          )),
    );
  }
}
