// ignore_for_file: camel_case_types

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:mygate/config/size_config.dart';
import 'package:intl/intl.dart';

class noticeboard extends StatefulWidget {
  const noticeboard({Key? key}) : super(key: key);

  @override
  _noticeboardState createState() => _noticeboardState();
}

class _noticeboardState extends State<noticeboard> {
  final title = TextEditingController();
  final content = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[100],
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh))
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/homeBg.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          backgroundColor: Colors.transparent, // 1
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Notice Board",
            style: GoogleFonts.nunito(
              fontSize: SizeConfig.blockSizeVertical * 3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final userdata = GetStorage();
            String rolechecker = userdata.read('role');

            if (rolechecker == 'Committee') {
              showalertdialog();
            } else {
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                flushbarStyle: FlushbarStyle.GROUNDED,
                message: "Only Committee Members are allowed to Add Notice",
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
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: FutureBuilder<List<ParseObject>>(
                    future: getTodo(),
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
                            return ListView.builder(
                              //reverse: true,
                              controller: _scrollController,
                              padding: EdgeInsets.all(
                                  SizeConfig.blockSizeHorizontal * 3),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                //*************************************
                                //Get Parse Object Values
                                final varTodo = snapshot.data![index];
                                final varTitle = varTodo.get<String>('title')!;
                                final varcontent =
                                    varTodo.get<String>('content')!;
                                final varcreatedAt =
                                    varTodo.get<DateTime>('createdAt')!;
                                String createdat = DateFormat.yMMMd('en_US')
                                    .format(varcreatedAt);
                                final varCreatedBy =
                                    varTodo.get<String>('CreatedBy')!;

                                //*************************************

                                return Padding(
                                  padding: EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 2),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            varTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    6),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.005,
                                          ),
                                          Text(
                                            varcontent,
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.005,
                                          ),
                                          Text(
                                            createdat,
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.005,
                                          ),
                                          Text(
                                            varCreatedBy,
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.005,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      }
                    })),
          ],
        ),
      ),
    );
  }

  Future<List<ParseObject>> getTodo() async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Notice'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results!.reversed.toList() as List<ParseObject>;
    } else {
      return [];
    }
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
              title: const Text(
                "Add Notice",
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Center(
                    child: Text(
                      "Title :-",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 3,
                    controller: title,
                    onSaved: (value) {
                      title.text = value!;
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  const Center(
                    child: Text(
                      "Content :-",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 4,
                    controller: content,
                    onSaved: (value) {
                      content.text = value!;
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.07,
                      width: SizeConfig.screenWidth * 0.50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.cyan),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeVertical * 2),
                            )),
                        child: Center(
                          child: Text("Add Notice ",
                              style: GoogleFonts.nunito(
                                fontSize: SizeConfig.blockSizeVertical * 2.4,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        onPressed: () async {
                          final userdata = GetStorage();
                          String creatorname = userdata.read('name');
                          try {
                            var firstObject = ParseObject('Notice');
                            firstObject.set('title', title.text.trim());
                            firstObject.set('content', content.text.trim());
                            firstObject.set('CreatedBy', creatorname.trim());
                            await firstObject.save();
                          } finally {
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              message: "Notice Added...Please Refresh",
                              icon: Icon(
                                Icons.info_outline,
                                size: 28.0,
                                color: Colors.blue[300],
                              ),
                              duration: const Duration(seconds: 3),
                              leftBarIndicatorColor: Colors.blue[300],
                            ).show(context);
                            title.clear();
                            content.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
