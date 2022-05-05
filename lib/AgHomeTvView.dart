// import 'package:aaha/AgHomeAgView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Agency.dart';
import 'package:flutter/material.dart';
import 'package:aaha/pkg_detail_pg_travellers.dart';
import 'Widgets/agencyPackagesTopView.dart';

class AgHomeTvView extends StatefulWidget {
  // final Agency1 agency;
  final agencyID;
  const AgHomeTvView({Key? key, required this.agencyID}) : super(key: key);

  @override
  _AgHomeTvViewState createState() => _AgHomeTvViewState();
}

class _AgHomeTvViewState extends State<AgHomeTvView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                topView(agencyID: widget.agencyID, agencyView: false),
                agencyPackageList(
                  agencyID: widget.agencyID,
                ),
              ],
            ),
          ),
        ),
      ),
      //bottomNavigationBar: MyBottomBarDemo(),
    );
  }
}

class agencyPackageList extends StatelessWidget {
  final agencyID;
  agencyPackageList({required this.agencyID});

  final CollectionReference Packages =
      FirebaseFirestore.instance.collection('Packages');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Packages.where('Agency id', isEqualTo: agencyID).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.docs.length > 0) {
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var package = snapshot.data.docs[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PkgDetailTraveller(
                            package: Package1(
                                package['Package id'],
                                package['Package name'],
                                package['Agency Name'],
                                package['price'],
                                package['days'],
                                package['description'],
                                package['Location'],
                                double.parse(package['Rating'].toString()),
                                package['Agency id'],
                                package['photoUrl'],
                                package['ImgUrls'].cast<String>(),
                                package['otherDetails'].cast<String>(),
                                package['isSaved']),
                          ),
                        ));
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 40,
                              child: Container(
                                width: 345,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.docs[index]
                                              ['Package name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Days:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('\b' +
                                            snapshot.data.docs[index]['days'] +
                                            ''),
                                        Text(
                                          'Price:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('\$' +
                                            snapshot.data.docs[index]['price'] +
                                            ''),
                                        Text(
                                          'Description:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Text(
                                                snapshot.data.docs[index]
                                                        ['description'] +
                                                    '')),
                                      ],
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ]),
                    );
                  }),
            );
          }

          return const Center(
            child: Text('Looks like this agency has not added any packages !'),
          );
        });
  }
}
