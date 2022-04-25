import 'services/agencyManagement.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'signupAgency.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileAgency extends StatefulWidget {
  const ProfileAgency({Key? key}) : super(key: key);

  @override
  _ProfileAgencyState createState() => _ProfileAgencyState();
}

class _ProfileAgencyState extends State<ProfileAgency> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      ProfliePictureWidget(
                          future: context
                              .read<agencyProvider>()
                              .getPhotoUrl(currentUser)),
                      Column(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text('View Profile Picture')),
                          TextButton(
                              onPressed: () async {
                                var newPhotoUrl =
                                await updateDialog(context, 'photo url');
                                var agencyManagementObject =
                                agencyManagement(uid: currentUser!.uid);
                                if (newPhotoUrl != null) {
                                  setState(() {
                                    agencyManagementObject
                                        .updateAgencyPhotoUrl(newPhotoUrl);
                                  });
                                }
                              },
                              child: Text('Change Profile Picture')),
                        ],
                      ),
                    ],
                  ),
                  Text('\n'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // - - - Name - - -
                            Icon(Icons.person_outline_outlined),
                            userData(
                                future: context
                                    .read<agencyProvider>()
                                    .getName(currentUser)),
                            InkWell(
                              child: Icon(Icons.edit),
                              onTap: () async {
                                var newName = await updateDialog(context, 'name');
                                var agencyManagementObject =
                                agencyManagement(uid: currentUser!.uid);
                                if (newName != null) {
                                  setState(() {
                                    agencyManagementObject
                                        .updateAgencyName(newName);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      // - - - Email - - -
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.email_outlined),
                            userData(
                                future: context
                                    .read<agencyProvider>()
                                    .getEmail(currentUser)),
                            const Icon(Icons.key),
                          ],
                        ),
                      ),
                      // - - - Phone Number - - -
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.phone_outlined),
                            userData(
                                future: context
                                    .read<agencyProvider>()
                                    .getPhoneNum(currentUser)),
                            InkWell(
                              child: Icon(Icons.edit),
                              onTap: () async {
                                var newPhoneNum =
                                await updateDialog(context, 'phone number');
                                var agencyManagementObject =
                                agencyManagement(uid: currentUser!.uid);
                                if (newPhoneNum != null) {
                                  setState(() {
                                    agencyManagementObject
                                        .updateAgencyPhoneNum(newPhoneNum);
                                  });
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      // - - - About - - -
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.account_circle_outlined),
                            Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.72,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: userData(
                                    future: context
                                        .read<agencyProvider>()
                                        .getAbout(currentUser)),
                              ),
                            ),
                            InkWell(
                              child: Icon(Icons.edit),
                              onTap: () async {
                                var newAbout =
                                await updateDialog(context, 'about');
                                var agencyManagementObject =
                                agencyManagement(uid: currentUser!.uid);
                                if (newAbout != null) {
                                  setState(() {
                                    agencyManagementObject
                                        .updateAgencyAbout(newAbout);
                                  });
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      Text(
                        '\n        Location:\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: Image.network(
                          'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/master/w_320,c_limit/GoogleMapTA.jpg',
                        ),
                      ),

                      Text('\n'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateDialog(context, valueToBeChanged) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          var controller = TextEditingController();
          return AlertDialog(
            title: Text('Enter new ' + valueToBeChanged),
            content: TextField(
              controller: controller,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    controller.text != ""
                        ? Navigator.of(context).pop(controller.text)
                        : Navigator.of(context).pop();
                  },
                  child: Text('Update')),
            ],
          );
        });
  }
}

class ProfilePictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              'https://image.shutterstock.com/image-vector/abstract-modern-monogram-xyz-letter-260nw-1281772879.jpg',
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ProfliePictureWidget extends StatelessWidget {
  final Future<String>? future;
  const ProfliePictureWidget({Key? key, required this.future})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CircularProfileAvatar(snapshot.data.toString());
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class userData extends StatelessWidget {
  final Future<String>? future;
  const userData({Key? key, required this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                snapshot.data!.toString() == "" ? "Set Up" : snapshot.data!.toString(),
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
          );
        }
        return CircularProgressIndicator(
          color: Colors.blue,
        );
      },
    );
  }
}
