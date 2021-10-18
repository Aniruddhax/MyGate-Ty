// ignore_for_file: camel_case_types

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygate/config/size_config.dart';
import 'package:mygate/screens/home_screen.dart';
import 'package:mygate/screens/login/signup.dart';
import 'package:mygate/screens/splash_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class resilogin extends StatefulWidget {
  const resilogin({Key? key}) : super(key: key);

  @override
  _resiloginState createState() => _resiloginState();
}

class _resiloginState extends State<resilogin> {
  // Password obscure variable
  bool _isObscure = true;

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // form key
  final resiemail = TextEditingController();
  final resipass = TextEditingController();

  // form key

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    SizeConfig().init(context);
    final userdata = GetStorage();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[100],
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottom),
            child: Stack(
              children: <Widget>[
                const first_ellipse(),
                const second_ellipse(),
                Center(
                    child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.11,
                      ),
                      Text(
                        "Login For Residential Members",
                        style: GoogleFonts.nunito(
                          fontSize: SizeConfig.blockSizeVertical * 2,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Text(
                        "Welcome Back !",
                        style: GoogleFonts.nunito(
                          fontSize: SizeConfig.blockSizeVertical * 2.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      SvgPicture.asset(
                        "assets/resilogin.svg",
                        height: SizeConfig.screenHeight * 0.20,
                        width: SizeConfig.screenWidth * 0.30,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 17,
                            right: SizeConfig.blockSizeHorizontal * 17),
                        child: TextFormField(
                          controller: resiemail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter a Valid Email Address';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            resiemail.text = value!;
                          },
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
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
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.mail),
                              labelText: "E-Mail",
                              hintText: "abc@gmail.com"),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 17,
                            right: SizeConfig.blockSizeHorizontal * 17),
                        child: TextFormField(
                          controller: resipass,
                          obscureText: _isObscure,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                          },
                          onSaved: (value) {
                            resipass.text = value!;
                          },
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
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
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.vpn_key),
                              labelText: "Password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: SizedBox(
                          height: SizeConfig.screenHeight * 0.08,
                          width: SizeConfig.screenWidth * 0.75,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.cyan),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.blockSizeVertical * 2),
                                )),
                            child: Center(
                              child: Text("Login",
                                  style: GoogleFonts.nunito(
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.4,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                  final QueryBuilder<ParseObject> parseQuery =
                                      QueryBuilder<ParseObject>(
                                          ParseObject('MyGate'));
                                  parseQuery
                                    ..whereContains('role', 'Residential')
                                    ..whereContains(
                                        'email', resiemail.text.trim())
                                    ..whereContains(
                                        'passwd', resipass.text.trim());
                                  final ParseResponse parseResponse =
                                      await parseQuery.query();
                                  if (parseResponse.success &&
                                      parseResponse.results != null) {
                                    final object = (parseResponse
                                        .results!.first) as ParseObject;

                                    String? useremail =
                                        object.get<String>('email');
                                    String? username =
                                        object.get<String>('name');
                                    String? userrole =
                                        object.get<String>('role');

                                    
                                    userdata.write('name', username);
                                    userdata.write('email', useremail);
                                    userdata.write('role', userrole);
                                    userdata.write('isloggedin', true);

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const homescreen()));
                                  } else {
                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      flushbarStyle: FlushbarStyle.GROUNDED,
                                      message:
                                          "Wrong Credentials or You have a Different Role Account",
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 28.0,
                                        color: Colors.blue[300],
                                      ),
                                      duration: const Duration(seconds: 3),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    ).show(context);
                                  }
                                }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.03,
                      ),
                      Wrap(
                        children: [
                          Text("Don’t have an account ? ",
                              style: GoogleFonts.nunito(
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                fontWeight: FontWeight.w400,
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const signup()));
                            },
                            child: Text("Sign Up",
                                style: GoogleFonts.nunito(
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.cyan,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.035,
                      ),
                      Text(
                          ' # Note :- If You have forgotten your Password,\nPlease contact the Administrator.',
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
