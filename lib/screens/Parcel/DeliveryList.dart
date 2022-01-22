// ignore_for_file: camel_case_types, file_names, prefer_typing_uninitialized_variables

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:mygate/config/size_config.dart';

class deliveryList extends StatefulWidget {
  const deliveryList({Key? key}) : super(key: key);

  @override
  _deliveryListState createState() => _deliveryListState();
}

class _deliveryListState extends State<deliveryList> {
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
            "Delivery Management",
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
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Parcel'));
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
                    final Name = varTodo.get<String>('AddedBy')!;
                    final Type = varTodo.get<String>('type')!;
                    final time = varTodo.get<String>('time')!;
                    final ObjectId = varTodo.get<String>('objectId')!;
                    final room_no = varTodo.get<String>('roomno')!;

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
                                  "Name :- $Name \nFlat Number :-$room_no\nArriving Time :- $time",
                                  //overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.008,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.blockSizeVertical * 1),
                                  width: SizeConfig.screenWidth * 0.28,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Type == "Food Delivery"
                                          ? Colors.red[300]
                                          : Colors.amber),
                                  child: Center(
                                    child: Text(
                                      Type,
                                    ),
                                  ),
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
                          IconButton(
                              onPressed: () async {
                                try {
                                  var todo = ParseObject('Parcel')
                                    ..objectId = ObjectId;
                                  await todo.delete();
                                } finally {
                                  Flushbar(
                                    flushbarPosition: FlushbarPosition.TOP,
                                    flushbarStyle: FlushbarStyle.GROUNDED,
                                    message: "Request Deleted",
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
                              icon: Icon(
                                Icons.clear,
                                size: SizeConfig.blockSizeVertical * 4,
                              )),
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
