// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_if_null_operators

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygate/config/size_config.dart';
import 'package:mygate/screens/homescreen/home_screen.dart';
import 'package:mygate/screens/splashscreen/splash_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class editprofile extends StatefulWidget {
  const editprofile({Key? key}) : super(key: key);

  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  final fullname = TextEditingController();
  final emailcontroller = TextEditingController();
  final roomno = TextEditingController();
  final mobno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userdata = GetStorage();
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    String? user_name = userdata.read('name');
    String? useremail = userdata.read('email');
    String? user_mobno = userdata.read('mob_no');
    String? user_roomno = userdata.read('room_no');
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.10,
                      ),
                      Center(
                        child: Text(
                          "Edit Profile",
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.13),
                        child: Text(
                          "Name :-",
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.7,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.13,
                            right: SizeConfig.screenWidth * 0.10),
                        child: TextFormField(
                          controller: fullname,
                          onSaved: (value) {
                            fullname.text = value!;
                          },
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(Icons.mail),
                              hintText: user_name),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.13),
                        child: Text(
                          "Email :-",
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.7,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.13,
                            right: SizeConfig.screenWidth * 0.10),
                        child: TextFormField(
                          readOnly: true,
                          controller: emailcontroller,
                          onSaved: (value) {
                            emailcontroller.text = value!;
                          },
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(Icons.mail),
                              hintText: useremail),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.13),
                        child: Text(
                          "Mobile Number :-",
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.7,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.13,
                            right: SizeConfig.screenWidth * 0.10),
                        child: TextFormField(
                          controller: mobno,
                          onSaved: (value) {
                            mobno.text = value!;
                          },
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(Icons.mail),
                              hintText: user_mobno != null
                                  ? user_mobno
                                  : "Add a Mobile Number"),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.13),
                        child: Text(
                          "Room Number :-",
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.7,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.13,
                            right: SizeConfig.screenWidth * 0.10),
                        child: TextFormField(
                          controller: roomno,
                          onSaved: (value) {
                            roomno.text = value!;
                          },
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(Icons.mail),
                              hintText: user_roomno != null
                                  ? user_roomno
                                  : "Add a Room Number"),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.07,
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: SizedBox(
                            height: SizeConfig.screenHeight * 0.08,
                            width: SizeConfig.screenWidth * 0.75,
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
                                child: Text("Save ",
                                    style: GoogleFonts.nunito(
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2.4,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                              onPressed: () async {
                                // Update Name Code
                                if (fullname.text.isEmpty) {
                                } else {
                                  final QueryBuilder<ParseObject> parseQuery =
                                      QueryBuilder<ParseObject>(
                                          ParseObject('MyGate'));
                                  parseQuery.whereContains(
                                      'email', useremail.toString());
                                  final ParseResponse parseResponse =
                                      await parseQuery.query();
                                  if (parseResponse.success &&
                                      parseResponse.results != null) {
                                    final object = (parseResponse
                                        .results!.first) as ParseObject;
                                    String? id = object.get<String>('objectId');
                                    var todo = ParseObject('MyGate')
                                      ..objectId = id
                                      ..set('name', fullname.text.trim());
                                    await todo.save();
                                    userdata.write(
                                        'name', fullname.text.trim());

                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      flushbarStyle: FlushbarStyle.GROUNDED,
                                      message: "Name Updated",
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 28.0,
                                        color: Colors.blue[300],
                                      ),
                                      duration: const Duration(seconds: 3),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    ).show(context);
                                  } else {}
                                }

                                // Update Mobile number Code
                                if (mobno.text.isEmpty) {
                                } else {
                                  final QueryBuilder<ParseObject> parseQuery =
                                      QueryBuilder<ParseObject>(
                                          ParseObject('MyGate'));
                                  parseQuery.whereContains(
                                      'email', useremail.toString());
                                  final ParseResponse parseResponse =
                                      await parseQuery.query();
                                  if (parseResponse.success &&
                                      parseResponse.results != null) {
                                    final object = (parseResponse
                                        .results!.first) as ParseObject;
                                    String? id = object.get<String>('objectId');
                                    var todo = ParseObject('MyGate')
                                      ..objectId = id
                                      ..set('mob_no', mobno.text.trim());
                                    await todo.save();
                                    userdata.write('mob_no', mobno.text.trim());

                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      flushbarStyle: FlushbarStyle.GROUNDED,
                                      message: "Mobile Number Updated",
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 28.0,
                                        color: Colors.blue[300],
                                      ),
                                      duration: const Duration(seconds: 3),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    ).show(context);
                                  } else {}
                                }

                                // Update Room number Code
                                if (roomno.text.isEmpty) {
                                } else {
                                  final QueryBuilder<ParseObject> parseQuery =
                                      QueryBuilder<ParseObject>(
                                          ParseObject('MyGate'));
                                  parseQuery.whereContains(
                                      'email', useremail.toString());
                                  final ParseResponse parseResponse =
                                      await parseQuery.query();
                                  if (parseResponse.success &&
                                      parseResponse.results != null) {
                                    final object = (parseResponse
                                        .results!.first) as ParseObject;
                                    String? id = object.get<String>('objectId');
                                    var todo = ParseObject('MyGate')
                                      ..objectId = id
                                      ..set('room_no', roomno.text.trim());
                                    await todo.save();
                                    userdata.write(
                                        'room_no', roomno.text.trim());

                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      flushbarStyle: FlushbarStyle.GROUNDED,
                                      message: "Room Number Updated",
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 28.0,
                                        color: Colors.blue[300],
                                      ),
                                      duration: const Duration(seconds: 3),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    ).show(context);
                                  } else {}
                                }

                                Future.delayed(const Duration(seconds: 1),
                                    () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const homescreen()));
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.03,
                      ),
                      Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const homescreen()));
                              },
                              child: Text(
                                "Show Profile",
                                style: GoogleFonts.nunito(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 6,
                                    fontWeight: FontWeight.w500),
                              ))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
