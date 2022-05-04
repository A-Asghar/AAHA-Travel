import 'package:aaha/services/travellerManagement.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'EditUserProfile.dart';
import 'package:intl/intl.dart';
import 'Widgets/updateDialog.dart';
import 'Widgets/userData.dart';

class travellerProfile extends StatefulWidget {
  const travellerProfile({Key? key}) : super(key: key);

  @override
  State<travellerProfile> createState() => _travellerProfileState();
}

class _travellerProfileState extends State<travellerProfile> {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    final CollectionReference Bookings =
        FirebaseFirestore.instance.collection('Bookings');
    return StreamBuilder(
        stream: Bookings.where('travellerID',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading . .. ");
          }

          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text(
                    'Profile',
                    style: (TextStyle(color: Colors.black, fontSize: 30)),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.black.withOpacity(0.05),
                  elevation: 0,
                ),
                body: Column(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.23,
                              width: MediaQuery.of(context).size.width,
                              child: CoverPictureWidget(
                                future: context
                                    .read<travellerProvider>()
                                    .getCoverPhotoUrl(currentUser),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (Context) => EditUserProfile(),
                                  ));
                                  var newCoverUrl = await updateDialog(
                                      context, 'cover photo url');
                                  var travellerManagementObject =
                                      travellerManagement(
                                          uid: currentUser!.uid);
                                  if (newCoverUrl != null) {
                                    setState(() {
                                      travellerManagementObject
                                          .updateTravellerCoverPhoto(
                                              newCoverUrl);
                                    });
                                  }
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 5, 0, 10),
                                child: ProfilePictureWidget(
                                    future: context
                                        .read<travellerProvider>()
                                        .getPhotoUrl(currentUser)),
                              ),
                              Expanded(
                                  child: ListTile(
                                title: Text(
                                  (context
                                      .read<travellerProvider>()
                                      .getTravellerName(currentUser)),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                subtitle: Text((currentUser!.email.toString())),
                                contentPadding:
                                    EdgeInsets.fromLTRB(5, 0, 12, 0),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.62,
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (Context) => EditUserProfile(),
                            ));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.black.withOpacity(0.05)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side:
                                          BorderSide(color: Colors.black12)))),
                          child: const Text(
                            'Edit profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          )),
                    ),

                    Container(
                        margin: const EdgeInsets.only(top: 5.0, left: 5.0),
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder<String>(
                          future: context
                              .read<travellerProvider>()
                              .getAbout(currentUser),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var bio = snapshot.data!.toString().length < 30
                                  ? snapshot.data!.toString()
                                  : snapshot.data!.toString().substring(0, 30);
                              return Text(
                                '+Traveller Bio  ' + bio + ' . . .',
                                style: TextStyle(color: Colors.black),
                              );
                            }

                            return CircularProgressIndicator(
                              color: Colors.white,
                            );
                          },
                        )),
//Current city
                    Container(
                        margin: const EdgeInsets.only(top: 5.0, left: 5.0),
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder<String>(
                          future: context
                              .read<travellerProvider>()
                              .getCity(currentUser),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '+Current City  ' + snapshot.data!.toString(),
                                style: TextStyle(color: Colors.black),
                              );
                            }
                            return CircularProgressIndicator(
                              color: Colors.white,
                            );
                          },
                        )),
                    //  get joindate
                    Container(
                        margin: const EdgeInsets.only(top: 5.0, left: 5.0),
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder<String>(
                          future: context
                              .read<travellerProvider>()
                              .getjoinDate(currentUser),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '+Joined  ' + snapshot.data!.toString(),
                                style: TextStyle(color: Colors.black),
                              );
                            }
                            return CircularProgressIndicator(
                              color: Colors.white,
                            );
                          },
                        )),

                    SizedBox(
                      height: 48,
                      child: AppBar(
                        backgroundColor: Colors.black.withOpacity(0.05),
                        elevation: 0,
                        bottom: const TabBar(
                          indicatorColor: Colors.red,
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.travel_explore_outlined,
                                color: Colors.black,
                              ),
                            ),
                            Tab(
                                icon: Icon(
                              Icons.photo_album_outlined,
                              color: Colors.black,
                            )),
                            Tab(
                              icon: Icon(
                                Icons.reviews_outlined,
                                color: Colors.black,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.forum_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // create widgets for each tab bar here
                    Expanded(
                      child: TabBarView(
                        children: [
                          // first tab bar view widget
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(
                                10, 0, 10, 0), // color: Colors.red,

                            child: snapshot.data.docs.length == 0
                                ? const Center(
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Text('Travel More!',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center),
                                      ),
                                      subtitle: Text(
                                          'Places where you have travelled will be displayed here!',
                                          textAlign: TextAlign.center),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 8.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 6.0),
                                        child: Stack(
                                          children: [
                                            ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        snapshot.data
                                                                .docs[index]
                                                            ['location'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                      Text(snapshot.data
                                                                  .docs[index][
                                                              'packageNumOfDays'] +
                                                          ' Days'),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text('End Date:',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black)),
                                                      Text(
                                                        DateFormat(
                                                                'EEE, MMM d, '
                                                                'yy')
                                                            .format((snapshot
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'travelEndDate']
                                                                    as Timestamp)
                                                                .toDate()),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(
                                80, 0, 80, 0), // color: Colors.red,

                            child: const Center(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text('Add Photos!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                ),
                                subtitle: Text(
                                    'Photos you add will be displayed here!',
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(
                                80, 0, 80, 0), // color: Colors.red,

                            child: const Center(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text('Add reviews!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                ),
                                subtitle: Text(
                                    'Reviews you add will be displayed here',
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(
                                80, 0, 80, 0), // color: Colors.red,

                            child:  Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom: 10.0),
                                      child: Text('Our forum!',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center),
                                    ),
                                    subtitle: Text(
                                        'You can connect with people of same interest here!',
                                        textAlign: TextAlign.center),
                                  ),
                                  TextButton(onPressed: (){
                                    _launchURL(Uri.parse('https://www.reddit.com/r/AAHATravel/'));
                                  }, child: Text('Tap to open forum !')),
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ProfilePictureWidget extends StatelessWidget {
  final Future<String>? future;
  const ProfilePictureWidget({Key? key, required this.future})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CircularProfileAvatar(snapshot.data.toString());
        } else {
          return CircularProgressIndicator(color: Colors.grey);
        }
      },
    );
  }
}

class CoverPictureWidget extends StatelessWidget {
  final Future<String>? future;
  const CoverPictureWidget({Key? key, required this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.network(
            snapshot.data.toString(),
            fit: BoxFit.fill,
          );
        } else {
          return CircularProgressIndicator(
            color: Colors.white,
          );
        }
      },
    );
  }
}
