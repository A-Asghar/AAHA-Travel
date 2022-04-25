import 'package:aaha/services/packageManagement.dart';
import 'package:flutter/material.dart';
import 'AgHomeAgView.dart';
import 'MyBottomBarDemo.dart';
import 'loginScreen.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/agencyManagement.dart';

class signupAgency extends StatelessWidget {
  const signupAgency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _name = TextEditingController();
    final _phoneNum = TextEditingController();
    final _email = TextEditingController();
    final _password = TextEditingController();
    final _confirmPassword = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: NetworkImage(
              'https://i.ibb.co/r70cMRh/rm222batch3-mind-01.jpg',
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
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text('Sign Up',
                              style: TextStyle(
                                fontSize: 50,

                              )),
                        ),
                        userInput('Agency Name', TextInputType.text, _name),
                        userInput(
                            'Phone Number', TextInputType.phone, _phoneNum),
                        userInput('Email', TextInputType.name, _email),
                        userInput('Password', TextInputType.visiblePassword,
                            _password),
                        userInput('Confirm Password',
                            TextInputType.visiblePassword, _confirmPassword),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                              child: SizedBox(
                            width: 200,
                            height: 45,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.indigo.shade800),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide(
                                              color: Colors.blueGrey)))),
                              onPressed: () {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _email.text,
                                        password: _password.text)
                                    .then((signedInUser) {
                                  agencyManagement(
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .storeNewAgency(signedInUser.user,
                                          _name.text, _phoneNum.text, context);
                                  packageManagement.Agencyid=signedInUser.user!.uid;
                                }).catchError((e) {
                                  print(e);
                                  signupErrorDialog(e.code, context);
                                });
                              },
                              child: Text('Sign Up ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void signupErrorDialog(String e, context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('The following error has occurred : '),
          content: Text(e.toString()),
        );
      });
}

Widget userInput(String hintTitle, TextInputType keyboardType, controller) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
        // color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25),
      child: TextField(
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
