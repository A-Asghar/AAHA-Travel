import 'package:aaha/AgHomeAgView.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:aaha/pkg_detail_pg_travellers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";

import 'AgHomeTvView.dart';
import 'Agency.dart';

class topSellingAgencies extends StatelessWidget {
  const topSellingAgencies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Text(
          "Top Selling Agencies",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: topAgencies(),
    );
  }
}

class topAgencies extends StatefulWidget {
  @override
  _topAgenciesState createState() => _topAgenciesState();
}

class _topAgenciesState extends State<topAgencies> {
  @override
  Widget build(BuildContext context) {
    CollectionReference Agencies =
    FirebaseFirestore.instance.collection('Agencies');
    return StreamBuilder(
      stream: Agencies.orderBy('sales',descending: true).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.docs.length > 0) {
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var agency = snapshot.data.docs[index];
                return Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AgHomeTvView(
                                        agency: Agency1(
                                          agency['name'],
                                          agency['phoneNum'],
                                          agency['about'],
                                          agency['email'],
                                          agency['photoUrl'],
                                          agency['uid'],
                                        ),
                                      )
                                      ));
                        },
                        title: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                              snapshot.data.docs[index]['photoUrl']),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Agency ' +
                                      snapshot.data.docs[index]['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                snapshot.data.docs[index]['sales'].toString() + ' Sales',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Give them a call : '+
                                  snapshot.data.docs[index]['phoneNum'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        } else {
          return (Center(
            child: Text(
              'Not Found',
              style: TextStyle(fontSize: 25),
            ),
          ));
        }
      },
    );
  }
}


