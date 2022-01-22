// ignore: file_names
// ignore_for_file: camel_case_types, sized_box_for_whitespace, duplicate_ignore, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:mygate/config/size_config.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class veryfingVisitor extends StatefulWidget {
  const veryfingVisitor({Key? key}) : super(key: key);

  @override
  _veryfingVisitorState createState() => _veryfingVisitorState();
}

class _veryfingVisitorState extends State<veryfingVisitor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final otpCheck = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
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
          appBar: AppBar(
            title: const Text("Visitor Management",
                style: TextStyle(
                  fontSize: 25,
                )),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: bottom),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: SizeConfig.screenHeight * 0.45,
                          width: SizeConfig.screenWidth * 0.72,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2.4,
                                bottom: SizeConfig.blockSizeVertical * 2.4),
                            child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: _fallback()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.015,
                      ),
                      Container(
                        height: SizeConfig.screenHeight * 0.04,
                        width: SizeConfig.screenWidth,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.04),
                          child: Text(
                            "Enter Details",
                            style: GoogleFonts.nunito(
                              fontSize: SizeConfig.blockSizeVertical * 2.4,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 8),
                        child: Text(
                          "Visitor Code",
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 8,
                                  right: SizeConfig.blockSizeHorizontal * 8),
                              child: TextFormField(
                                maxLength: 4,
                                controller: otpCheck,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter the Visitor\'s Code';
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  otpCheck.text = value!;
                                },
                                decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.cyan),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: 'Enter Visitor\'s Code'),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.04,
                            ),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.08,
                                  width: SizeConfig.screenWidth * 0.50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.cyan),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.blockSizeVertical *
                                                      2),
                                        )),
                                    child: Center(
                                      child: Text("Verify",
                                          style: GoogleFonts.nunito(
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2.4,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final QueryBuilder<ParseObject>
                                            parseQuery =
                                            QueryBuilder<ParseObject>(
                                                ParseObject('Visitor'));
                                        parseQuery.whereContains(
                                            'OTP', otpCheck.text.trim());
                                        final ParseResponse parseResponse =
                                            await parseQuery.query();
                                        if (parseResponse.success &&
                                            parseResponse.results != null) {
                                          final object = (parseResponse
                                              .results!.first) as ParseObject;

                                          String? objectid =
                                              object.get<String>('objectId');
                                          String? Name =
                                              object.get<String>('Name');
                                          String VisitorName = Name.toString();
                                          var todo = ParseObject('Visitor')
                                            ..objectId = objectid;
                                          await todo.delete();
                                          VisitorFound(name: VisitorName);
                                        } else {
                                          VisitorNotFound();
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                          ],
                        ),
                      )
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

  Widget _fallback() {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2.4),
      child: Column(
        children: <Widget>[
          const Spacer(),
          SvgPicture.asset(
            "assets/VisitorVerify.svg",
            height: SizeConfig.screenHeight * 0.18,
            width: SizeConfig.screenWidth * 0.25,
          ),
          const Spacer(),
          Text(
            "Enter the Visitor's Code to Verify",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              fontSize: SizeConfig.blockSizeVertical * 2.4,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void VisitorFound({String? name}) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: Container(
                  color: Colors.white,
                  height: SizeConfig.screenHeight * 0.45,
                  width: SizeConfig.screenWidth * 0.90,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.30,
                        width: SizeConfig.screenWidth * 0.30,
                        child: Lottie.asset(
                          "assets/18374-right-check.json",
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Text(
                        "Visitor Name \n $name",
                        style: GoogleFonts.nunito(
                          fontSize: SizeConfig.blockSizeVertical * 2.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ));
          });
        });
  }

  void VisitorNotFound() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: Container(
                  color: Colors.white,
                  height: SizeConfig.screenHeight * 0.45,
                  width: SizeConfig.screenWidth * 0.90,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.30,
                        width: SizeConfig.screenWidth * 0.30,
                        child: Lottie.asset(
                          "assets/34313-failure-error-icon.json",
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Text(
                        "Visitor Data Not Found",
                        style: GoogleFonts.nunito(
                          fontSize: SizeConfig.blockSizeVertical * 2.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ));
          });
        });
  }
}
