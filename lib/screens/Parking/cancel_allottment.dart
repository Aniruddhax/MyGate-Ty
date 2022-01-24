// ignore_for_file: camel_case_types, non_constant_identifier_names, sized_box_for_whitespace

import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mygate/config/size_config.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class cancel_allottment extends StatefulWidget {
  const cancel_allottment({Key? key}) : super(key: key);

  @override
  _cancel_allottmentState createState() => _cancel_allottmentState();
}

class _cancel_allottmentState extends State<cancel_allottment> {
  @override
  void initState() {
    //etMemberList(context);
    super.initState();
    Timer.run(() => getSpotList(context));
  }

  List ParkingSpotList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String SpotSelected = '';

  bool selected = false;

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
                          height: SizeConfig.screenHeight * 0.42,
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
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.screenHeight * 0.05,
                                  right: SizeConfig.screenHeight * 0.05),
                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                isExpanded: true,
                                hint: Text(
                                  'Select A Parking Spot',
                                  style: GoogleFonts.nunito(
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: SizeConfig.blockSizeVertical * 5,
                                buttonHeight: SizeConfig.screenHeight * 0.08,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: ParkingSpotList.map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: GoogleFonts.nunito(
                                          fontSize:
                                              SizeConfig.blockSizeVertical * 2,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select Parking Spot';
                                  }
                                },
                                onChanged: (value) {
                                  SpotSelected = value.toString();
                                },
                                onSaved: (value) {
                                  SpotSelected = value.toString();
                                },
                              ),
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
                                      child: Text("Cancel",
                                          style: GoogleFonts.nunito(
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2.4,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          final QueryBuilder<ParseObject>
                                              parseQuery =
                                              QueryBuilder<ParseObject>(
                                                  ParseObject('Parking'));
                                          parseQuery.whereContains(
                                              'spot', SpotSelected.toString());
                                          final ParseResponse parseResponse =
                                              await parseQuery.query();
                                          if (parseResponse.success &&
                                              parseResponse.results != null) {
                                            final object = (parseResponse
                                                .results!.first) as ParseObject;
                                            String? id =
                                                object.get<String>('objectId');
                                            var todo = ParseObject('Parking')
                                              ..objectId = id
                                              ..set('alotted', false)
                                              ..set('to', null)
                                              ..set('Room_no', null)
                                              ..set("Type", null)
                                              ..set(
                                                  'spot', SpotSelected.trim());

                                            await todo.save();
                                          } else {}
                                        } finally {
                                          SpotSelected = '';
                                          VisitorNotFound();
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
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
            "assets/undraw_cancel_re_ctke (1).svg",
            height: SizeConfig.screenHeight * 0.18,
            width: SizeConfig.screenWidth * 0.25,
          ),
          const Spacer(),
          Text(
            "Enter the details below to\n Cancel Parking Allottment",
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

  Future<List<ParseObject>> getSpotList(BuildContext context) async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Parking'));
    queryTodo.whereContains("allotted", "true");
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var o in apiResponse.results!) {
        final object = o as ParseObject;
        ParkingSpotList.add(object.get<String>('spot'));
      }
      return apiResponse.results!.reversed.toList() as List<ParseObject>;
    } else {
      return [];
    }
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
                        height: SizeConfig.screenHeight * 0.3,
                        width: SizeConfig.screenWidth * 0.60,
                        child: Lottie.asset(
                          "assets/18374-right-check.json",
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Text(
                        "Parking Spot Alottmemt Cancelled",
                        textAlign: TextAlign.center,
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
