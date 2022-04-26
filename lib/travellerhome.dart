import 'package:aaha/Agency.dart';
import 'package:aaha/loginUser.dart';
import 'package:aaha/services/agencyManagement.dart';
import 'package:aaha/services/packageManagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pkg_detail_pg_travellers.dart';
import 'searchPage.dart';
import 'topTravelDestinations.dart';
import 'services/travellerManagement.dart';
import 'AgHomeTvView.dart';
import 'Agency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class TravellerHome extends StatefulWidget {
  const TravellerHome({Key? key}) : super(key: key);

  @override
  State<TravellerHome> createState() => _TravellerHomeState();
}

class _TravellerHomeState extends State<TravellerHome> {

  @override

  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((_) {
     //  context.read<agencyProvider>().setAgencies();
      context.read<packageProvider>().setPackagesTraveler();

      // context.watch<TaskProvider>().setTodos();

    });


    super.initState();
  }
  final List<String> images = [
    'https://wander-lush.org/wp-content/uploads/2020/01/KatpanaColdDesertPakistanSuthidaloedchaiyapanCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/12/Beautiful-places-in-Pakistan-Naltar-Valley-lake-MolviDSLRGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/RohtasFortPakistanSimonImagesCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/RakaposhiMountainPakistanSkazzjyCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/12/Beautiful-places-in-Pakistan-Swat-Valley-KhwajaSaeedGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/12/Beautiful-places-in-Pakistan-Hunza-Valley-undefinedGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/12/Beautiful-places-in-Pakistan-Passu-Cones-SiddiquiGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/PassuConesPakistanSuthidaloedchaiyapanCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/PhanderLakePakistanKanokwanPonokCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/Beautiful-places-in-Pakistan-Hingol-National-Park-LukasBischoffGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/MargalaHillsPakistanNaqshCanvaPro.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: FutureBuilder<String>(
            future: context
                .read<travellerProvider>()
                .getName(FirebaseAuth.instance.currentUser),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Hi, ' +
                  snapshot.data!.toString(),
                  style: TextStyle(color: Colors.black),
                );
              }
              return CircularProgressIndicator(
                color: Colors.black,
              );
            },
          ),
actions: [
  IconButton(onPressed: (){
    packageManagement.p1=[];
    PackageList=[];
    loginUser.agencyListLocal=[];
    agencyManagement.AgenciesList=[];
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }, icon: Icon(Icons.logout, color: Colors.black,))
],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 250,
                width: 400,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://wallpaperaccess.com/full/51364.jpg',
                      ),
                      fit: BoxFit.fill,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Where do you wish to go?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      padding: const EdgeInsets.all(1),
                      height: 40,
                      width: 350,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                      ),
                      //alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search for Places',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //hintStyle: TextStyle(),
                                ),
                                cursorColor: Colors.black,
                                cursorHeight: 20,
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: InkWell(
                                child: Icon(Icons.search,
                                    size: 30, color: Colors.grey.shade700),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => searchPage()));
                                },
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Container(
                    //margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Top Travel Packages',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: InkWell(
                            // onTap: null,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      topTravelDestinations()));
                            },
                            child: Text('See All'),
                          ),
                        ),
                        packageList(),
                        const ListTile(
                          title: Text(
                            'Top Rated Agencies',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: InkWell(
                            onTap: null,
                            child: Text('See All'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 8),
                          child: SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: loginUser.agencyListLocal.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index1) {
                                        // if (index1.isEven) {
                                        //   return const VerticalDivider(
                                        //     width: 5,
                                        //     color: Colors.white,
                                        //   );
                                        // }

                                        return Row(
                                          children: [
                                            VerticalDivider(
                                              width: 10,
                                              color: Colors.white,
                                            ),
                                            ClipRRect(

                                              borderRadius: BorderRadius.circular(
                                                  25), // Image border
                                              child: SizedBox.fromSize(
                                                size: const Size.fromRadius(
                                                    50), // Image radius
                                                child: InkWell(
                                                  onTap:(){

                                                    for(var i=0;i<packageManagement.p1.length;i++){
                                                      print(packageManagement.p1[i].agencyId);
                                                      print(context.read<agencyProvider>().getAgencyList()[index1].uid);
                                                      setState(() {
                                                        if(packageManagement.p1[i].agencyId==context.read<agencyProvider>().getAgencyList()[index1].uid){
                                                          PackageList.add(packageManagement.p1[i]);
                                                        }
                                                      });
                                                    }
                                                    print(loginUser.agencyListLocal.length);
                                                    print(packageManagement.p1.length);
                                                    print(PackageList.length);


                                                    //PackageList=[];
                                                    // setState(() {
                                                    //   WidgetsBinding.instance?.addPostFrameCallback((_) async{
                                                    //     await context.read<packageProvider>().getListForTraveler(context.read<agencyProvider>().getAgencyList()[index].uid);
                                                    //
                                                    //
                                                    //   });
                                                    //
                                                    // });
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AgHomeTvView(agency:context.read<agencyProvider>().getAgencyList()[index1]))).then((value) => PackageList=[]);
                                                  } ,
                                                  child: Container(

                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              images[index1]),
                                                          fit: BoxFit.cover),
                                                    ),
                                                    child:  Center(
                                                      child: Text(
                                                        loginUser.agencyListLocal[index1].AName,
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<List> retrievePackages() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection("Packages").get();
    return snapshot.docs
        .map((docSnapshot) => Package1.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}

class packageList extends StatelessWidget {
  final CollectionReference packs =
  FirebaseFirestore.instance.collection('Packages');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: packs.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {

                          var package = snapshot.data.docs[index];
                          return Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(25), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(50), // Image radius
                              child: InkWell(
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
                                          package['Rating'],
                                          package['Agency id'],
                                          package['ImgUrls'].cast<String>(),
                                        ),
                                      )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data.docs[index]['photoUrl'],
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Center(
                                    child: Text(
                                      snapshot.data.docs[index]['Package name'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
          ;
        });
  }
}
