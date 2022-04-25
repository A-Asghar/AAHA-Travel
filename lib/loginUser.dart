import 'package:aaha/services/travellerManagement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SignupTraveller.dart';
import 'AgHomeAgView.dart';
import 'MyBottomBarDemo1.dart';
import 'travellerProfile.dart';

class loginUser extends StatefulWidget {
  @override
  State<loginUser> createState() => _loginUserState();
}

class _loginUserState extends State<loginUser> {
  final _email = TextEditingController();

  final _password = TextEditingController();

  Widget userInput(
      String hintTitle, TextInputType keyboardType, controller, obscureText) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        // color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.fill,
              image: NetworkImage(
                'https://i.ibb.co/r70cMRh/rm222batch3-mind-01.jpg-',
              ),
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
                      icon: Icon(Icons.arrow_back_ios),
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
                          userInput(
                              'Email', TextInputType.emailAddress, _email, false),
                          userInput('Password', TextInputType.visiblePassword,
                              _password,true),
                          Container(
                            height: 55,
                            padding: const EdgeInsets.only(
                                top: 5, left: 70, right: 70),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: Colors.indigo.shade800,
                              onPressed: () async {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _email.text,
                                        password: _password.text)
                                    .then((signedInUser) async {
                                  if (await travellerManagement(
                                          uid: signedInUser.user!.uid)
                                      .isTraveller()) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => MyBottomBarDemo1(),
                                    ));
                                  } else {
                                    loginErrorDialog(
                                        'You are registered as an agency !',
                                        context);
                                  }
                                }).catchError((e) {
                                  print(e);
                                  loginErrorDialog(e.code, context);
                                });
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          const Center(
                            child: Text('Forgot password ?'),
                          ),
                          SizedBox(height: 10),
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
                                  Navigator.of(context).push(MaterialPageRoute(
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
