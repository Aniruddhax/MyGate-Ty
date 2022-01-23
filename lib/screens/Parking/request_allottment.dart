import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mygate/config/size_config.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class request_allotment extends StatefulWidget {
  request_allotment({Key? key}) : super(key: key);

  @override
  _request_allotmentState createState() => _request_allotmentState();
}

class _request_allotmentState extends State<request_allotment> {
  @override
  void initState() {
    //etMemberList(context);
    super.initState();
    Timer.run(() => getSpotList(context));
  }

  List ParkingSpotList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String TypeSelected = '';
  String SpotSelected = '';

  bool selected = false;
  final List<String> VehicleTypeList = [
    'Two Wheeler',
    'Four Wheeler',
  ];

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
                        height: SizeConfig.screenHeight * 0.02,
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
                                dropdownOverButton: false,
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
                                  'Select Vehicle Type',
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
                                items: VehicleTypeList.map((item) =>
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
                                    return 'Please select Vehicle Type';
                                  }
                                },
                                onChanged: (value) {
                                  TypeSelected = value.toString();
                                },
                                onSaved: (value) {
                                  TypeSelected = value.toString();
                                },
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
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
                                      child: Text("Request",
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
                                          final userdata = GetStorage();
                                          String SpotRequestname =
                                              userdata.read('name');
                                          String? SpotRequestroom =
                                              userdata.read('room_no') ?? 'Info not Added';    
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
                                              ..set('alotted', true)
                                              ..set(
                                                  'to', SpotRequestname.trim())
                                                  ..set(
                                                  'Room_no', SpotRequestroom.trim())
                                              ..set(
                                                  'Type', TypeSelected.trim());
                                            await todo.save();
                                          } else {
                                            print("error");
                                          }
                                        } finally {
                                          TypeSelected = '';
                                          SpotSelected = '';
                                          Flushbar(
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            flushbarStyle:
                                                FlushbarStyle.GROUNDED,
                                            message: "Parking Spot Allotted",
                                            icon: Icon(
                                              Icons.info_outline,
                                              size: 28.0,
                                              color: Colors.blue[300],
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            leftBarIndicatorColor:
                                                Colors.blue[300],
                                          ).show(context);
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
            "assets/Parking.svg",
            height: SizeConfig.screenHeight * 0.18,
            width: SizeConfig.screenWidth * 0.25,
          ),
          const Spacer(),
          Text(
            "Enter the details below to\n Request a Allotment For vehicle Parking",
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
    queryTodo.whereValueExists('alotted', false);
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var o in apiResponse.results!) {
        final object = o as ParseObject;
        ParkingSpotList.add(object.get<String>('spot'));
      }
      return apiResponse.results!.reversed.toList() as List<ParseObject>;
    } else {
      VisitorNotFound();
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
                          "assets/71229-not-found.json",
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Text(
                        "Sorry \nNo Parking Spots Are available",
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
