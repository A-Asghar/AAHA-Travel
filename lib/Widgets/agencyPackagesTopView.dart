import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Views/Agencies/addPackage.dart';
import '../Views/Traveller/otherDetails.dart';
import '../services/agencyManagement.dart';

class topView extends StatelessWidget {
  final agencyID;
  final agencyView;
  const topView({Key? key, required this.agencyID,required this.agencyView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<agencyProvider>().getPhotoUrlUsinguid(agencyID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Image.network(
                  'https://i.ibb.co/3dyzPVD/dylan-gillis-Kdeq-A3a-Tn-BY-unsplash.jpg',
                ),
                Positioned(
                  top: 250,
                  left: 30,
                  child: CircularProfileAvatar(
                    snapshot.data.toString(),
                    radius: 55,
                  ),
                ),
                Positioned(
                    top: 300,
                    left: 150,
                    child: Row(
                      children: [
                        FutureBuilder<String>(
                          future: context
                              .read<agencyProvider>()
                              .getAgencyNameUsinguid(agencyID),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.toString(),
                                style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),
                              );
                            }
                            return const CircularProgressIndicator(
                              color: Colors.black,
                            );
                          },
                        ),
                        Text("                       "),
                      ],
                    )),
                agencyView
                    ? Positioned(
                        child: FloatingActionButton(
                          heroTag: null,
                          child: Icon(Icons.add),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                  builder: (Context) => addPackage(),
                                ))
                                .then((value) => isSaved = false)
                                .then((value) {
                              daysController.clear();
                            }).then((value) => Navigator.pop(context));
                          },
                          backgroundColor: Colors.black,
                        ),
                        top: 240,
                        right: 40,
                      )
                    : Positioned(
                        top: 240,
                        right: 40,
                        child: Container(),
                      )
              ]);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
