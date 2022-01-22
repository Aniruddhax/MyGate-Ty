// ignore_for_file: camel_case_types, sized_box_for_whitespace, duplicate_ignore, file_names, non_constant_identifier_names

import 'package:another_flushbar/flushbar.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
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
  final List<String> ChargeList = [
    'Late Maintenance Payment Fine - Rs.200',
    'Damage To Society Common Areas - Rs.400',
    'Not Adhering To society Rules - Rs.500',
  ];
  List MemberList = [];
  String ChargeSelected = '';
  String MemberSelected = '';
  var MemberFineCheck = '';
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
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeVertical * 5,
                            right: SizeConfig.blockSizeVertical * 5),
                        child: CustomSearchableDropDown(
                          dropdownItemStyle: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            fontWeight: FontWeight.w400,
                          ),
                          dropdownHintText: 'Search For Name Here... ',
                          items: MemberList,
                          label: 'Select to Search Members',
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.search),
                          dropDownMenuItems: MemberList,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                MemberFineCheck = value;
                              });
                            } else {
                              MemberFineCheck = '';
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.013,
                      ),
                      Container(
                          height: SizeConfig.screenHeight * 0.20,
                          width: SizeConfig.screenWidth,
                          child: FutureBuilder<List<ParseObject>>(
                              future: getMemberFine(Member: MemberFineCheck),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(),
                                      ),
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
                                          final fine_to =
                                              varTodo.get<String>('Fine_to')!;
                                          final Charge =
                                              varTodo.get<String>('Charge')!;
                                          final varcreatedAt = varTodo
                                              .get<DateTime>('createdAt')!;
                                          String createdat =
                                              DateFormat.yMMMd('en_US')
                                                  .format(varcreatedAt);
                                          final addedby =
                                              varTodo.get<String>('Addedby')!;
                                          final ObjId =
                                              varTodo.get<String>('objectId')!;

                                          //*************************************

                                          return _complaintCard(
                                              createdAt: createdat,
                                              fineCharge: Charge,
                                              createdBy: addedby,
                                              id: ObjId,
                                              fine_to: fine_to);
                                        },
                                      );
                                    }
                                }
                              })),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Container(
                        height: SizeConfig.screenHeight * 0.04,
                        width: SizeConfig.screenWidth,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.04),
                          child: Text(
                            "Issue a Fine",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                                  'Select Charge Type',
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
                                items: ChargeList.map((item) =>
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
                                  ChargeSelected = value.toString();
                                },
                                onSaved: (value) {
                                  ChargeSelected = value.toString();
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
                                  'Select Member to Issue',
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
                                    return 'Please select Parcel Time';
                                  }
                                },
                                onChanged: (value) {
                                  MemberSelected = value.toString();
                                },
                                onSaved: (value) {
                                  MemberSelected = value.toString();
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
                                      child: Text("Issue",
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
                                          String Fine_issued =
                                              userdata.read('name');
                                          var firstObject = ParseObject('Dues');
                                          firstObject.set(
                                              'Addedby', Fine_issued.trim());
                                          firstObject.set(
                                              'Fine_to', MemberSelected.trim());
                                          firstObject.set(
                                              'Charge', ChargeSelected.trim());
                                          await firstObject.save();
                                        } finally {
                                          setState(() {
                                            ChargeSelected = '';
                                            MemberSelected = '';
                                            Flushbar(
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              flushbarStyle:
                                                  FlushbarStyle.GROUNDED,
                                              message: "Fine Issued",
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
        QueryBuilder<ParseObject>(ParseObject('Dues'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results!.reversed.toList() as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<List<ParseObject>> getMemberFine({required String Member}) async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Dues'));
    queryTodo.whereContains('Fine_to', Member);
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
      {required String fine_to,
      required String fineCharge,
      required String createdBy,
      required String createdAt,
      required String id}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fine_to,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 4),
            ),
            Text(
              fineCharge,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.015,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  try {
                    var todo = ParseObject('Dues')..objectId = id;
                    await todo.delete();
                  } finally {
                    setState(() {});
                    Flushbar(
                      flushbarPosition: FlushbarPosition.TOP,
                      flushbarStyle: FlushbarStyle.GROUNDED,
                      message: "Fine Paid",
                      icon: Icon(
                        Icons.info_outline,
                        size: 28.0,
                        color: Colors.blue[300],
                      ),
                      duration: const Duration(seconds: 3),
                      leftBarIndicatorColor: Colors.blue[300],
                    ).show(context);
                  }
                },
                child: Text(
                  "Fine Paid",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                ),
              ),
            ),
            Text(
              "Fine Issued by $createdBy On $createdAt",
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
