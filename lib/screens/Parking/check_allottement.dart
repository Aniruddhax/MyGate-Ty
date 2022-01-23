import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygate/config/size_config.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class check_allottment extends StatefulWidget {
  check_allottment({Key? key}) : super(key: key);

  @override
  _check_allottmentState createState() => _check_allottmentState();
}

class _check_allottmentState extends State<check_allottment> {
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
        QueryBuilder<ParseObject>(ParseObject('Parking'));
    queryTodo.orderByAscending('Spot');
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results!.toList() as List<ParseObject>;
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
                  width: 100, height: 100, child: CircularProgressIndicator()),
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
                  final Name = varTodo.get<String>('to');
                  final Type = varTodo.get<String>('Type');
                  final room_no = varTodo.get<String>('Room_no');
                  final spot = varTodo.get<String>('spot');

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
                              Row(
                                children: [
                                  Text(
                                    "Name :- ",
                                    //overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 4),
                                  ),
                                  Text(
                                    Name ?? "Spot Not Allotted",
                                    //overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 4),
                                  ),
                                ],
                              ),
                              Text(
                                "Parking Spot :- $spot",
                                //overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Flat Number :- ",
                                    //overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 4),
                                  ),
                                  Text(
                                    Name == null
                                        ? "Spot Not Allotted"
                                        : "Info Not Added",
                                    //overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 4),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.008,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.blockSizeVertical * 1),
                                width: SizeConfig.screenWidth * 0.28,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Type == null
                                        ? Colors.green[200]
                                        : Colors.amber),
                                child: Center(
                                  child: Text(
                                    Type ?? "Spot Not Allotted",
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
                      ],
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
