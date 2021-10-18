// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mygate/config/size_config.dart';
import 'package:mygate/screens/login/commlogin.dart';
import 'package:mygate/screens/login/resilogin.dart';
import 'package:mygate/screens/login/signup.dart';
import 'package:mygate/screens/login/stafflogin.dart';
import 'package:mygate/screens/splash_screen.dart';

import '../home_screen.dart';

class roleselect extends StatefulWidget {
  const roleselect({Key? key}) : super(key: key);

  @override
  _roleselectState createState() => _roleselectState();
}

class _roleselectState extends State<roleselect> {
  

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[100],
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(
        body: Stack(
          children: [
            const first_ellipse(),
            const second_ellipse(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Lottie.asset(
                    "assets/23745-building.json",
                    height: SizeConfig.screenHeight * 0.20,
                    width: SizeConfig.screenWidth * 0.60,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.10,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeVertical * 3),
                  child: Text("Welcome !",
                      style: GoogleFonts.nunito(
                        fontSize: SizeConfig.blockSizeVertical * 3,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeVertical * 3),
                  child: Text("Please Select The Login Type",
                      style: GoogleFonts.nunito(
                        fontSize: SizeConfig.blockSizeVertical * 2.4,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.07,
                      width: SizeConfig.screenWidth * 0.73,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.cyan),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeVertical * 2),
                            )),
                        child: Center(
                          child: Text("Residential Member",
                              style: GoogleFonts.nunito(
                                fontSize: SizeConfig.blockSizeVertical * 2.4,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const resilogin()));
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.07,
                      width: SizeConfig.screenWidth * 0.73,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.cyan),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeVertical * 2),
                            )),
                        child: Center(
                          child: Text("Committee Member",
                              style: GoogleFonts.nunito(
                                fontSize: SizeConfig.blockSizeVertical * 2.4,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const commlogin()));
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.07,
                      width: SizeConfig.screenWidth * 0.73,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.cyan),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeVertical * 2),
                            )),
                        child: Center(
                          child: Text("Staff Member",
                              style: GoogleFonts.nunito(
                                fontSize: SizeConfig.blockSizeVertical * 2.4,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const stafflogin()));
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Center(
                  child: Wrap(
                    children: [
                      Text("Don’t have an account ? ",
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            fontWeight: FontWeight.w400,
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const signup()));
                        },
                        child: Text("Sign Up",
                            style: GoogleFonts.nunito(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.w400,
                              color: Colors.cyan,
                            )),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
