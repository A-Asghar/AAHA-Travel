import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class topTravelDestinations extends StatelessWidget {
  const topTravelDestinations({Key? key}) : super(key: key);

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
          "Top Travel Destinations",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: topPackages(),
    );
  }
}

class topPackages extends StatefulWidget {
  @override
  _topPackagesState createState() => _topPackagesState();
}

class _topPackagesState extends State<topPackages> {
  @override
  Widget build(BuildContext context) {
    CollectionReference Packages =
        FirebaseFirestore.instance.collection('Packages');
    return StreamBuilder(
      stream: Packages.orderBy('sales').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.docs.length > 0) {
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: ListTile(
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
                                  'Package ' +
                                      snapshot.data.docs[index]['Package name'],
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
                                snapshot.data.docs[index]['days'] + ' Days',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data.docs[index]['Agency Name'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text(
                                  '\$ ' + snapshot.data.docs[index]['price'],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
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

class Tile {
  String name;
  String company;
  String price;
  String url;
  String days = '12 Days';

  Tile({
    required this.name,
    required this.company,
    required this.price,
    required this.url,
  });
}
