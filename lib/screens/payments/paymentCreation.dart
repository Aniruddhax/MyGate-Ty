// ignore_for_file: camel_case_types, sized_box_for_whitespace, duplicate_ignore, file_names

import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mygate/config/size_config.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class due_Creation extends StatefulWidget {
  const due_Creation({Key? key}) : super(key: key);

  @override
  _due_CreationState createState() => _due_CreationState();
}

class _due_CreationState extends State<due_Creation> {
  @override
  void initState() {
    getMemberList(context);

    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final complaintTitle = TextEditingController();
  final complaintSubject = TextEditingController();
  List MemberList = [];
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
            title: const Text("Society Dues",
                style: TextStyle(
                  fontSize: 25,
                )),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh))
            ],
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottom),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.035,
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                        height: SizeConfig.screenHeight * 0.04,
                        width: SizeConfig.screenWidth,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.04),
                          child: Text(
                            "Pending Dues :-",
                            style: GoogleFonts.nunito(
                              fontSize: SizeConfig.blockSizeVertical * 2.4,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.009,
                      ),
                      Container(
                          height: SizeConfig.screenHeight * 0.20,
                          width: SizeConfig.screenWidth,
                          child: FutureBuilder<List<ParseObject>>(
                              future: getcomplaint(),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return const Center(
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CircularProgressIndicator()),
                                    );
                                  default:
                                    if (snapshot.hasError) {
                                      return const Center(
                                        child: Text("Error..."),
                                      );
                                    }
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: Text("No Data..."),
                                      );
                                    } else {
                                      return PageView.builder(
                                        //reverse: true,
                                        controller: PageController(
                                            viewportFraction: 0.9),
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          //*************************************
                                          //Get Parse Object Values
                                          final varTodo = snapshot.data![index];
                                          final varTitle =
                                              varTodo.get<String>('title')!;
                                          final varcontent =
                                              varTodo.get<String>('subject')!;
                                          final varcreatedAt = varTodo
                                              .get<DateTime>('createdAt')!;
                                          String createdat =
                                              DateFormat.yMMMd('en_US')
                                                  .format(varcreatedAt);
                                          final varCreatedBy =
                                              varTodo.get<String>('CreteadBy')!;

                                          final ObjId =
                                              varTodo.get<String>('objectId')!;

                                          //*************************************

                                          return _complaintCard(
                                              title: varTitle,
                                              subject: varcontent,
                                              createdBy: varCreatedBy,
                                              createdAt: createdat,
                                              id: ObjId);
                                        },
                                      );
                                    }
                                }
                              })),
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
                            "Raise a Complaint",
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
                          "Title",
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
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            DropdownButtonFormField2(
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
                              items: MemberList.map((item) =>
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
                                var TypeSelected = value.toString();
                              },
                              onSaved: (value) {
                                var TypeSelected = value.toString();
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 8),
                              child: Text(
                                "Subject",
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
                                controller: complaintSubject,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please Enter a Subject for the Complaint");
                                  }
                                },
                                onSaved: (value) {
                                  complaintSubject.text = value!;
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
                                  hintText: "Subject For the Complaint",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.03,
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
                                      child: Text("Raise",
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
                                        String complaintcreator =
                                            userdata.read('name');
                                        try {
                                          var firstObject =
                                              ParseObject('Complaints');
                                          firstObject.set('title',
                                              complaintTitle.text.trim());
                                          firstObject.set('subject',
                                              complaintSubject.text.trim());
                                          firstObject.set('CreteadBy',
                                              complaintcreator.trim());
                                          await firstObject.save();
                                        } finally {
                                          Flushbar(
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            flushbarStyle:
                                                FlushbarStyle.GROUNDED,
                                            message: "Complaint Raised",
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

  Future<List<ParseObject>> getcomplaint() async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Complaints'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results!.reversed.toList() as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<List<ParseObject>> getMemberList(BuildContext context) async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('MyGate'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var o in apiResponse.results!) {
        final object = o as ParseObject;
        MemberList.add(object.get<String>('name'));
      }
      return apiResponse.results!.reversed.toList() as List<ParseObject>;
    } else {
      return [];
    }
  }

  Widget _complaintCard(
      {required String title,
      required String subject,
      required String createdBy,
      required String createdAt,
      required String id}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 4),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.015,
            ),
            Text(
              subject,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  print(MemberList);
                },
                child: Text(
                  " Complaint Resolved ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.008,
            ),
            Text(
              "Complaint Raised By $createdBy On $createdAt",
              style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.2),
            ),
          ],
        ),
      ),
    );
  }
}
