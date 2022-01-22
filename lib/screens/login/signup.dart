// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygate/config/size_config.dart';
import 'package:mygate/screens/splashscreen/splash_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:toggle_switch/toggle_switch.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  bool _isObscure = true;

  String Role = 'Committee';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final fullname = TextEditingController();
  final useremail = TextEditingController();
  final passwd = TextEditingController();
  final confirmpasswd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    SizeConfig().init(context);
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
                          height: SizeConfig.screenHeight * 0.09,
                        ),
                        Text(
                          "Welcome Onboard !",
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 17,
                              right: SizeConfig.blockSizeHorizontal * 17),
                          child: TextFormField(
                            controller: fullname,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{3,}$');
                              if (value!.isEmpty) {
                                return ("First Name cannot be Empty");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid name(Min. 3 Character)");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              fullname.text = value!;
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
                                prefixIcon: const Icon(Icons.mail),
                                labelText: "Enter Your Full Name",
                                hintText: "abc@gmail.com"),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 17,
                              right: SizeConfig.blockSizeHorizontal * 17),
                          child: TextFormField(
                            controller: useremail,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Enter Your Email");
                              }
                              // reg expression for email validation
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid email");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              useremail.text = value!;
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
                                prefixIcon: const Icon(Icons.mail),
                                labelText: "Enter Your E-Mail",
                                hintText: "abc@gmail.com"),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 17,
                              right: SizeConfig.blockSizeHorizontal * 17),
                          child: TextFormField(
                            controller: passwd,
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
                              passwd.text = value!;
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
                                prefixIcon: const Icon(Icons.vpn_key),
                                labelText: "Enter New Password",
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
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 17,
                              right: SizeConfig.blockSizeHorizontal * 17),
                          child: TextFormField(
                            controller: confirmpasswd,
                            obscureText: _isObscure,
                            validator: (value) {
                              if (confirmpasswd.text != passwd.text) {
                                return "Password don't match";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              confirmpasswd.text = value!;
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
                                prefixIcon: const Icon(Icons.vpn_key),
                                labelText: "Confirm Password",
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
                          height: SizeConfig.screenHeight * 0.05,
                        ),
                        Text(
                          "Select Role",
                          style: GoogleFonts.nunito(
                            fontSize: SizeConfig.blockSizeVertical * 2.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        ToggleSwitch(
                          animate: true,
                          curve: Curves.easeInCubic,
                          borderWidth: 0.5,
                          borderColor: const [Colors.black],
                          radiusStyle: true,
                          cornerRadius: 20.0,
                          minWidth: SizeConfig.screenHeight * 0.40,
                          //minHeight: SizeConfig.screenWidth * 0.08,
                          inactiveBgColor: Colors.white,
                          initialLabelIndex: 0,
                          totalSwitches: 3,
                          labels: const ['Committee', 'Residential', 'Staff'],
                          onToggle: (index) {
                            if (index == 0) {
                              Role = "Committee";
                            } else if (index == 1) {
                              Role = "Residential";
                            } else {
                              Role = "Staff";
                            }
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: SizedBox(
                            height: SizeConfig.screenHeight * 0.07,
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
                                    .whereContains(
                                        'email', useremail.text.trim());
                                  final ParseResponse parseResponse =
                                      await parseQuery.query();
                                  if (parseResponse.success &&
                                      parseResponse.results != null) {
                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      flushbarStyle: FlushbarStyle.GROUNDED,
                                      message:
                                          "Email Already is used by another Account",
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 28.0,
                                        color: Colors.blue[300],
                                      ),
                                      duration: const Duration(seconds: 3),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    ).show(context);
                                  } else {
                                    signup();
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Wrap(
                          children: [
                            Text("Already have an account ? ",
                                style: GoogleFonts.nunito(
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  fontWeight: FontWeight.w400,
                                )),
                            InkWell(
                              onTap: () {},
                              child: Text("Sign In",
                                  style: GoogleFonts.nunito(
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.cyan,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  Future signup() async {
    try {
      var firstObject = ParseObject('MyGate');
      firstObject.set('name', fullname.text.trim());
      firstObject.set('email', useremail.text.trim());
      firstObject.set('passwd', passwd.text.trim());
      firstObject.set('role', Role);
      await firstObject.save();
    } finally {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        message: "Account Created Successfully",
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
}
