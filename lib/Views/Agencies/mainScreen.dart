import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginSignupScreen.dart';
import '../Traveller/loginSignupScreenTraveller.dart';
import '../Traveller/travellerProfile.dart';
import 'main.dart';
import '../../Widgets/allButton.dart';

class mainScreen extends StatelessWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/main-Screen.png'),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: null, // Your app bar
          body: Column(
            children: [
              Expanded(
                  child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  child: allButton(
                    buttonText: 'For Travellers',
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                loginSignupScreenTraveller())),
                  ),
                ),
              )),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    child: allButton(
                      buttonText: 'For Agencies',
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => loginSignupScreen(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
