// ignore_for_file: camel_case_types, duplicate_ignore

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mygate/config/size_config.dart';
import 'package:mygate/screens/home_screen.dart';

import 'login/roleselect.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

// ignore: camel_case_types
class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    // Timer(
    //     const Duration(seconds: 3),
    //     () => Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) => const roleselect())));
final userdata = GetStorage();
             userdata.writeIfNull('isloggedin', false);

    Future.delayed(const Duration(seconds: 4), () async {
      userdata.read('isloggedin')
          ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => const homescreen()))
          : Navigator.push(context,
              MaterialPageRoute(builder: (context) => const roleselect()));
    });
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const first_ellipse(),
          const second_ellipse(),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 30,
                ),
                Lottie.asset(
                  "assets/23745-building.json",
                  height: 210,
                  width: 260,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                Text(
                  "MyGate",
                  style: GoogleFonts.nunito(
                      fontSize: SizeConfig.blockSizeHorizontal * 7,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "A Society Management System",
                  style: GoogleFonts.nunito(
                      fontSize: SizeConfig.blockSizeHorizontal * 5,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class second_ellipse extends StatelessWidget {
  const second_ellipse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Image.asset("assets/Ellipse.png", height: 200, width: 200),
      top: SizeConfig.screenWidth * -0.10,
      left: SizeConfig.screenWidth * -0.30,
    );
  }
}

// ignore: camel_case_types
class first_ellipse extends StatelessWidget {
  const first_ellipse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Image.asset("assets/Ellipse.png", height: 200, width: 200),
      top: SizeConfig.screenWidth * -0.30,
      left: SizeConfig.screenWidth * -0.10,
    );
  }
}
