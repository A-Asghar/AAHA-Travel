import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pkg_detail_pg_travellers.dart';
import 'signupAgency.dart';
import 'loginScreen.dart';

class searchPage extends StatelessWidget {
  final searchTerm;
  const searchPage({Key? key, required this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leadingWidth: 0,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.filter_list_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Search for destinations",
                fillColor: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: searchResults(
        searchTerm: searchTerm,
      ),
    );
  }
}

class searchResults extends StatefulWidget {
  final String searchTerm;
  const searchResults({Key? key, required this.searchTerm}) : super(key: key);

  @override
  State<searchResults> createState() => _searchResultsState();
}

class _searchResultsState extends State<searchResults> {
  @override
  Widget build(BuildContext context) {
    CollectionReference Packages =
        FirebaseFirestore.instance.collection('Packages');
    return StreamBuilder(
      stream:
          Packages.where('Location', isEqualTo: widget.searchTerm.toLowerCase()).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        // color: Colors.black,
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
                                  Text('Package ' +
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data.docs[index]['Agency Name'],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  Text('\$ '+
                                    snapshot.data.docs[index]['price'],
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
          return (Text('Not Found'));
        }
      },
    );
  }
}
