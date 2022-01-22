// ignore_for_file: camel_case_types, file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:mygate/config/size_config.dart';

class Fine_List extends StatefulWidget {
  const Fine_List({Key? key}) : super(key: key);

  @override
  _Fine_ListState createState() => _Fine_ListState();
}

class _Fine_ListState extends State<Fine_List> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[150],
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
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Society Dues",
            style: GoogleFonts.nunito(
              fontSize: SizeConfig.blockSizeVertical * 3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.screenHeight * 0.01,
              ),
              Container(
                height: SizeConfig.screenHeight * 0.04,
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                  child: Text(
                    "Issued Fines :-",
                    style: GoogleFonts.nunito(
                      fontSize: SizeConfig.blockSizeVertical * 2.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListBuilder(
                future: getList,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ParseObject>> getList() async {
    final userdata = GetStorage();
    String Finecheck = userdata.read('name');

    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Dues'));
    queryTodo.whereContains('Fine_to', Finecheck);
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results!.reversed.toList() as List<ParseObject>;
    } else {
      return [];
    }
  }
}

class ListBuilder extends StatelessWidget {
  final future;
  const ListBuilder({
    Key? key,
    this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ParseObject>>(
        future: future(),
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
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    //*************************************
                    //Get Parse Object Values
                    final varTodo = snapshot.data![index];
                    final fine_to = varTodo.get<String>('Fine_to')!;
                    final Charge = varTodo.get<String>('Charge')!;
                    final varcreatedAt = varTodo.get<DateTime>('createdAt')!;
                    final addedby = varTodo.get<String>('Addedby')!;
                    final ObjId = varTodo.get<String>('objectId')!;
                    String createdat =
                        DateFormat.yMMMd('en_US').format(varcreatedAt);

                    //*************************************

                    // ignore: sized_box_for_whitespace
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.008,
                                ),
                                Text(
                                  Charge,
                                  //overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.008,
                                ),
                                Text(
                                  "Fine Issued By $addedby on $createdat",
                                  //overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.008,
                                ),
                                const Divider(
                                  thickness: 2,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
          }
        });
  }
}
