import 'package:aaha/services/agencyManagement.dart';
import 'package:aaha/services/travellerManagement.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Agencies/Agency.dart';
import 'SignupTraveller.dart';

import 'MyBottomBarDemo1.dart';

import '../../Widgets/userInput.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class loginUser extends StatefulWidget {
  static List<Agency1> agencyListLocal = [];

  @override
  State<loginUser> createState() => _loginUserState();
}

class _loginUserState extends State<loginUser> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.blueAccent, size: 80))
          : Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/signup-agency.jpg'),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          iconSize: 40,
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white70,),
                          onPressed: () => Navigator.pop(context, false),
                        )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 560,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    'Log In ',
                                    style: TextStyle(
                                      fontSize: 50,
                                    ),
                                  )),
                              SizedBox(height: 15),
                              userInput('Email', TextInputType.emailAddress,
                                  _email, false, 40),
                              userInput(
                                  'Password',
                                  TextInputType.visiblePassword,
                                  _password,
                                  true,
                                  20),
                              Container(
                                height: 55,
                                padding: const EdgeInsets.only(
                                    top: 5, left: 70, right: 70),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  color: Colors.indigo.shade800,
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: _email.text,
                                            password: _password.text)
                                        .then((signedInUser) async {
                                      if (await travellerManagement(
                                              uid: signedInUser.user!.uid)
                                          .isTraveller()) {
                                        WidgetsBinding.instance
                                            ?.addPostFrameCallback((_) async {
                                          context
                                              .read<agencyProvider>()
                                              .setAgencies();
                                          loginUser.agencyListLocal =
                                              await context
                                                  .read<agencyProvider>()
                                                  .getAgencyList();
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              MyBottomBarDemo1(),
                                        ));
                                        _email.clear();
                                        _password.clear();
                                      } else {
                                        loginErrorDialog(
                                            'You are registered as an agency !',
                                            context);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    }).catchError((e) {
                                      print(e);
                                      loginErrorDialog(e.code, context);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(thickness: 0, color: Colors.white),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account yet ? ',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (Context) => SignupTraveller(),
                                      ));
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
    );
  }

  void loginErrorDialog(String e, context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('The following error has occurred : '),
            content: Text(e.toString()),
          );
        });
  }
}
