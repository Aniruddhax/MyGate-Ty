// ignore: file_names
// ignore_for_file: camel_case_types, sized_box_for_whitespace, duplicate_ignore, file_names, non_constant_identifier_names

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';
import 'package:screenshot/screenshot.dart';

import 'package:mygate/config/size_config.dart';
import 'package:share_plus/share_plus.dart';

class helpdesk extends StatefulWidget {
  const helpdesk({Key? key}) : super(key: key);

  @override
  _helpdeskState createState() => _helpdeskState();
}

class _helpdeskState extends State<helpdesk> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = ScreenshotController();
  final visitorname = TextEditingController();
  final visitorNo = TextEditingController();
  final visitorTime = TextEditingController();
  String OTP = randomNumeric(4).toString();
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
                          "Name",
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
                                controller: visitorname,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter the Name of the Visitor';
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  visitorname.text = value!;
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
                                  hintText: "Name of the Visitor",
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
                                "Total Visitors",
                                style: GoogleFonts.nunito(
                                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 8,
                                  right: SizeConfig.blockSizeHorizontal * 8),
                              child: TextFormField(
                                controller: visitorNo,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please Enter total Number of the Visitor");
                                  }
                                },
                                onSaved: (value) {
                                  visitorNo.text = value!;
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
                                  hintText: "Number of Visitors",
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
                                "Time",
                                style: GoogleFonts.nunito(
                                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 8,
                                  right: SizeConfig.blockSizeHorizontal * 8),
                              child: TextFormField(
                                controller: visitorTime,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please Enter Time for Visiting");
                                  }
                                },
                                onSaved: (value) {
                                  visitorTime.text = value!;
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
                                  hintText: "Time for Visiting",
                                ),
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
                                      child: Text("Generate",
                                          style: GoogleFonts.nunito(
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2.4,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final userdata = GetStorage();
                                        String visitorCreator =
                                            userdata.read('name');
                                        try {
                                          var firstObject =
                                              ParseObject('Visitor');

                                          firstObject.set(
                                              'Name', visitorname.text.trim());
                                          firstObject.set(
                                              'number', visitorNo.text.trim());
                                          firstObject.set(
                                              'time', visitorTime.text.trim());
                                          firstObject.set('CreatedBy',
                                              visitorCreator.trim());
                                          firstObject.set('OTP', OTP);
                                          await firstObject.save();
                                        } finally {
                                          showalertdialog();
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
            "assets/Guest.svg",
            height: SizeConfig.screenHeight * 0.18,
            width: SizeConfig.screenWidth * 0.25,
          ),
          const Spacer(),
          Text(
            "Enter the details below to\n generate a Visitors Code and Card",
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

  Widget VisitorCode() {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2.4),
      child: Container(
        color: Colors.white,
        height: SizeConfig.screenHeight * 0.45,
        width: SizeConfig.screenWidth * 0.75,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Text(
              "Visitors Card",
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical * 2.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Divider(thickness: 4),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Text(
              "Name : ${visitorname.text.trim()}",
              textAlign: TextAlign.start,
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical * 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Text(
              "Time of Visiting : ${visitorTime.text.trim()}",
              textAlign: TextAlign.start,
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical * 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Text(
              "Visitor's Verification Code",
              textAlign: TextAlign.start,
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical * 2.3,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              OTP,
              textAlign: TextAlign.start,
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical * 4,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Text(
              "Verify the Code from the Gate Staff to Get Access",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical * 2,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            Text(
              "Made Using MyGate Society Management App",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical * 1.6,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
          ],
        ),
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
                title: VisitorCode(),
                content: ElevatedButton(
                  onPressed: () async {
                    final image =
                        await controller.captureFromWidget(VisitorCode());
                    saveAndShare(image);
                  },
                  child: const Text(
                    "Share",
                  ),
                ));
          });
        });
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    final name = 'Visitor Card_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/Visitor Card.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }
}
