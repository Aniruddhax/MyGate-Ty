// ignore: file_names
// ignore_for_file: camel_case_types, sized_box_for_whitespace, duplicate_ignore, file_names, non_constant_identifier_names

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:mygate/config/size_config.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class DeliveryCreating extends StatefulWidget {
  const DeliveryCreating({Key? key}) : super(key: key);

  @override
  _DeliveryCreatingState createState() => _DeliveryCreatingState();
}

class _DeliveryCreatingState extends State<DeliveryCreating> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ParcelType = TextEditingController();
  final ParcelTime = TextEditingController();
  String TypeSelected = '';
  String TimeSelected = '';
  final List<String> ParcelTypeList = [
    'Food Delivery',
    'Amazon Delivery',
    'Other Delivery',
  ];
  final List<String> ParcelTimeList = [
    'Morning (6:00AM - 12:00PM)',
    'Afternoon (12:00PM - 4:00PM)',
    'Evening (4:00PM - 8:00PM)',
    'Night (8:00PM - 12:00AM)',
    'OverNight (12:00AM - 6:00AM)',
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
          appBar: AppBar(
            title: const Text("Delivery Management",
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
                                  'Select Parcel Type',
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
                                items: ParcelTypeList.map((item) =>
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
                                    return 'Please select Parcel Type';
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
                                  'Select Parcel Arriving time',
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
                                items: ParcelTimeList.map((item) =>
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
                                    return 'Please select Parcel Time';
                                  }
                                },
                                onChanged: (value) {
                                  TimeSelected = value.toString();
                                },
                                onSaved: (value) {
                                  TimeSelected = value.toString();
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
                                      child: Text("Submit",
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
                                          String ParcelRequest =
                                              userdata.read('name');
                                          String? ParcelRequestcreator_room =
                                              userdata.read('room_no');
                                          userdata.read('name');
                                          var firstObject =
                                              ParseObject('Parcel');
                                          firstObject.set('roomno',
                                              ParcelRequestcreator_room?.trim());
                                          firstObject.set(
                                              'AddedBy', ParcelRequest.trim());
                                          firstObject.set(
                                              'type', TypeSelected.trim());
                                          firstObject.set(
                                              'time', TimeSelected.trim());
                                          await firstObject.save();
                                        } finally {
                                          setState(() {
                                            TypeSelected = '';
                                            TimeSelected = '';
                                            Flushbar(
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              flushbarStyle:
                                                  FlushbarStyle.GROUNDED,
                                              message: "Delivery Request Created",
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
                                          });
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
            "assets/delivery.svg",
            height: SizeConfig.screenHeight * 0.18,
            width: SizeConfig.screenWidth * 0.25,
          ),
          const Spacer(),
          Text(
            "Enter the details below to\n Add a Parcel Delivery Request",
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

  void showalertdialog() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //title: VisitorCode(),
                content: ElevatedButton(
                  onPressed: () async {},
                  child: const Text(
                    "MyGate",
                  ),
                ));
          });
        });
  }
}
