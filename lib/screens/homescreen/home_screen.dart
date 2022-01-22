// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygate/config/size_config.dart';
import 'package:mygate/screens/Parcel/DeliveryList.dart';
import 'package:mygate/screens/Parcel/deliveryCreation.dart';
import 'package:mygate/screens/Profile%20Page/profilepage.dart';
import 'package:mygate/screens/complaints/complaints.dart';
import 'package:mygate/screens/login/roleselect.dart';
import 'package:mygate/screens/notice_board/notice_board.dart';
import 'package:mygate/screens/payments/Finechecker.dart';
import 'package:mygate/screens/payments/paymentCreation.dart';
import 'package:mygate/screens/splashscreen/splash_screen.dart';
import 'package:mygate/screens/visitor/VerifyingVisitor.dart';

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
    final role = userdata.read('role');
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
            height: SizeConfig.screenHeight * 0.05,
          ),
          Expanded(
            child: Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                  padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2.2),
                  child: SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 22,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const noticeboard()));
                          },
                          child: dasboardServiesGrid(
                            title: "Notice Board",
                            icon: Icons.info_outline,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const complaints()));
                          },
                          child: dasboardServiesGrid(
                            title: "Complaints Section",
                            icon: Icons.sentiment_dissatisfied_outlined,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (role == 'Staff') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const veryfingVisitor()));
                            } else {Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DeliveryCreating()));}
                          },
                          child: dasboardServiesGrid(
                            title: "Visitor / Guest Management",
                            icon: Icons.group_outlined,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (role == 'Staff') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const deliveryList()));
                            } else {Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DeliveryCreating()));}
                          },
                          child: dasboardServiesGrid(
                            title: "Delivery Management",
                            icon: Icons.local_shipping_outlined,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (role == 'Committee') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const due_Creation()));
                            } else {Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Fine_List()));}
                          },
                          child: dasboardServiesGrid(
                            title: "Society Dues",
                            icon: Icons.request_quote_outlined,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class dasboardServiesGrid extends StatelessWidget {
  final title;
  final icon;
  const dasboardServiesGrid({
    Key? key,
    this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: Colors.cyan,
            ),
            Divider(
              thickness: 1,
            ),
            Text(
              title,
              style: GoogleFonts.nunito(
                fontSize: SizeConfig.blockSizeVertical * 2.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
