import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'signupAgency.dart';
import 'main.dart';

class loginSignup extends StatelessWidget {
  const loginSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: null,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Stack(
                          children: [
                            Container(
                                child: Image.network(
                                    'https://i.ibb.co/kXW1hQb/image-removebg-preview-5.png',
                                    fit: BoxFit.fill)),
                            Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  iconSize: 40,
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () => Navigator.pop(context, false),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 20),
                        child: mainImage(),
                      ),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: allButton(
                            buttonText: 'Login',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginScreen() ));
                            },
                          )),
                      allButton(buttonText: 'SignUp', onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => signupAgency() ));
                      })
                    ]),
              ),
            ),
          )),
    );
  }
}
