// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygate/config/size_config.dart';
import 'package:mygate/screens/Profile%20Page/profilepage.dart';
import 'package:mygate/screens/login/roleselect.dart';
import 'package:mygate/screens/notice_board/notice_board.dart';
import 'package:mygate/screens/splashscreen/splash_screen.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int currentpage = 0;


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
          body: Container(
            child: _getpage(currentpage),
          ),
          bottomNavigationBar: FancyBottomNavigation(
            tabs: [
              TabData(iconData: Icons.home, title: "Home"),
              TabData(iconData: Icons.person, title: "Profile"),
            ],
            initialSelection: 0,
            onTabChangedListener: (position) {
              setState(() {
                currentpage = position;
              });
            },
          ),
        ));
  }
}

_getpage(int page) {
  switch (page) {
    case 1:
      return tab_2();
    default:
      return tab_1();
  }
}

class tab_1 extends StatefulWidget {
  const tab_1({
    Key? key,
  }) : super(key: key);

  @override
  State<tab_1> createState() => _tab_1State();
}

class _tab_1State extends State<tab_1> {
  @override
  @override
  Widget build(BuildContext context) {
    final userdata = GetStorage();
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/homeBg.jpg"),
        alignment: Alignment.topCenter,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight * 0.12,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 7),
            child: Text(
              "Hello, ${userdata.read('name')}",
              style: GoogleFonts.nunito(
                fontSize: SizeConfig.blockSizeVertical * 3.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 7),
            child: Text(
              userdata.read('room_no') ?? 'Info not added',
              style: GoogleFonts.nunito(
                fontSize: SizeConfig.blockSizeVertical * 2.8,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 7),
            child: Text(
              "${userdata.read('role')} Member",
              style: GoogleFonts.nunito(
                fontSize: SizeConfig.blockSizeVertical * 2.8,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.08,
          ),
          Expanded(
              child: Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 7),
                  child: Text(
                    "Available Services :-",
                    style: GoogleFonts.nunito(
                      fontSize: SizeConfig.blockSizeVertical * 3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const noticeboard()));
                  },
                  child: Center(
                    child: Container(
                        height: SizeConfig.screenHeight * 0.09,
                        width: SizeConfig.screenWidth * 0.90,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeVertical * 2),
                              child: Icon(
                                Icons.info_outline,
                                size: 32,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.019,
                                ),
                                Text(
                                  "Notice Board",
                                  style: GoogleFonts.nunito(
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Access all important announcements",
                                  style: GoogleFonts.nunito(
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.7,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class tab_2 extends StatefulWidget {
  const tab_2({Key? key}) : super(key: key);

  @override
  _tab_2State createState() => _tab_2State();
}

class _tab_2State extends State<tab_2> {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final userdata = GetStorage();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[100],
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottom),
            child: Stack(
              children: <Widget>[
                const first_ellipse(),
                const second_ellipse(),
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.08,
                      ),
                      Text(
                        "Profile Page",
                        style: GoogleFonts.nunito(
                          fontSize: SizeConfig.blockSizeVertical * 3.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.03,
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset("assets/avataaars.png"),
                          radius: 80,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.03,
                      ),
                      Text(
                        userdata.read('name') ?? 'Info not added',
                        style: GoogleFonts.nunito(
                          fontSize: SizeConfig.blockSizeVertical * 3.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        userdata.read('email') ?? 'Info not added',
                        style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.7,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      Divider(
                        height: SizeConfig.screenHeight * 0.02,
                        thickness: 5,
                        indent: SizeConfig.screenWidth * 0.20,
                        endIndent: SizeConfig.screenWidth * 0.20,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      Text(
                        "Room Number",
                        style: GoogleFonts.nunito(
                          fontSize: SizeConfig.blockSizeVertical * 3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        userdata.read('room_no') ?? 'Info not added',
                        style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.7,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Text(
                        "Mobile Number",
                        style: GoogleFonts.nunito(
                          fontSize: SizeConfig.blockSizeVertical * 3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        userdata.read('mob_no') ?? 'Info not added',
                        style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.7,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      ClipRRect(
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
                                      vertical:
                                          SizeConfig.blockSizeVertical * 2),
                                )),
                            child: Center(
                              child: Text("Add Info",
                                  style: GoogleFonts.nunito(
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.4,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => editprofile()));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const roleselect()));
                            userdata.write('name', null);
                            userdata.write('email', null);
                            userdata.write('role', null);
                            userdata.write('mob_no', null);
                            userdata.write('room_no', null);
                            userdata.write('isloggedin', false);
                          },
                          icon: Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                          ),
                          label: Text(
                            "Logout",
                            style: GoogleFonts.nunito(
                              fontSize: SizeConfig.blockSizeVertical * 2.7,
                              fontWeight: FontWeight.w300,
                              color: Colors.red,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
