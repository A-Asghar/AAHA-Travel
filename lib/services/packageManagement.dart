import 'package:aaha/AgHomeAgView.dart';
import 'package:aaha/Agency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:aaha/MyBottomBarDemo.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'agencyManagement.dart';
import 'package:aaha/agencyhome.dart';

class packageManagement {
  static String Agencyid = '';
  static String Packid = '';
  static List<Package> p1 = [];

  static CollectionReference Packages =
      FirebaseFirestore.instance.collection('Packages');
  static storeNewPackage(
      user, name, desc, days, price, location, rating, context, ImgUrls) {
    final docp = FirebaseFirestore.instance.collection('Packages').doc();
    Packid = docp.id;

    p.pid = docp.id;

    docp.set({
      'Agency id': user.uid,
      'Agency Name': AgencyHomeState.Agencyname,
      'Package id': p.pid,
      'Package name': name,
      'description': desc,
      'days': days,
      'price': price,
      'Location': location,
      'Rating': rating,
      'ImgUrls': ImgUrls,
      'photoUrl': 'https://images.pexels.com/photos/326058/pexels-photo-326058.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    }).then((value) {
      Package p = Package(docp.id, name, AgencyHomeState.Agencyname, price,
          days, desc, location, rating, user.uid, ImgUrls);
      packageProvider.getList1().add(p);
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AgHomeAgView(),
      ));
    });
  }

  static UpdatePackage(Package p, user, name, desc, days, price, location,
      rating, context, ImgUrls) async {
    print(p.pid);
    await FirebaseFirestore.instance.collection('Packages').doc(p.pid).update({
      'Agency id': user.uid,
      'Agency Name': AgencyHomeState.Agencyname,
      'Package id': p.pid,
      'Package name': name,
      'description': desc,
      'days': days,
      'price': price,
      'Location': location,
      'Rating': rating,
      'ImgUrls': ImgUrls,
      'photoUrl': 'https://cdn-icons-png.flaticon.com/512/32/32441.png',
    }).then((value) {
      Navigator.of(context).pop();
    }).catchError((error) => print(error));
  }

  //static
  static updatePackageName(name) async {
    await Packages.doc(p.pid).update({'Package name': name});
  }

  updatePackagePhoneNum(desc) {
    Packages.doc(p.pid).update({'description': desc});
  }

  updatePackageDays(days) {
    Packages.doc(p.pid).update({'days': days});
  }

  updatePackagePrice(price) {
    Packages.doc(p.pid).update({'price': price});
  }

  updatePackageRating(rating) {
    Packages.doc(p.pid).update({'rating': rating});
  }

  updatePackagePhotoUrl(photoUrl) {
    Packages.doc(p.pid).update({'photoUrl': photoUrl});
  }

  static removePackage(pid) {
    final docp = FirebaseFirestore.instance.collection('Packages').doc(pid);
    docp.delete();
  }

  static Package fromJson(Map<String, dynamic> json) {
    List<String>? strings =
        (json['ImgUrls'] as List)?.map((item) => item as String)?.toList();
    Package p1 = Package(
      json['Package id'],
      json['Package name'],
      json['Agency Name'],
      json['price'],
      json['days'],
      json['description'],
      json['Location'],
      json['Rating'],
      json['Agency id'],
      strings!,
    );
    return p1;
  }


  static getPackages() async {
    await FirebaseFirestore.instance
        .collection('Packages')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        p1.add(packageManagement.fromJson(doc.data() as Map<String, dynamic>));
      });
    });
    for (var i = 0; i < p1.length; i++) {
      print(Agencyid);
      print(p1[i].agencyId);
      if (p1[i].agencyId == Agencyid) PackageList.add(p1[i]);
    }
  }

  Future<List<Package>> getPackagesForTravellers() async {
    List<Package> packageListForTravellerHomePage = [];
    final QuerySnapshot querysnapshotPackages =
        await FirebaseFirestore.instance.collection('myCollection').get();
    final List<DocumentSnapshot> documentsPackages = querysnapshotPackages.docs;
    documentsPackages.forEach((package) {
      packageListForTravellerHomePage.add(
          packageManagement.fromJson(package.data() as Map<String, dynamic>));
    });
    return packageListForTravellerHomePage;
  }
}

class packageProvider extends ChangeNotifier {
  String name = 'DummyName';
  String AgencyId = '111';
  String days = '00';
  String desc = 'About package';
  String price = '20';
  String photoUrl = 'https://images.pexels.com/photos/326058/pexels-photo-326058.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  void updatePackage(Package p, name, desc, days, price, location, ImgUrls) {
    for (var i = 0; i < PackageList.length; i++) {
      if (PackageList[i].pid == p.pid) {
        PackageList[i].PName = name;
        PackageList[i].Desc = desc;
        PackageList[i].Days = days;
        PackageList[i].Price = price;
        PackageList[i].Location = location;
        PackageList[i].ImgUrls = ImgUrls;
      }
    }

    notifyListeners();
  }

  void setPackages() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await packageManagement.getPackages();
    });

    notifyListeners();
  }

  static List<Package> getList1() {
    return PackageList;
  }

  List<Package> getList() {
    return PackageList;
  }


  Future<String>? getName(var p) async {
    var document =
        await FirebaseFirestore.instance.collection('Packages').doc(p.pid);
    await document.get().then((document) {
      print(document['Package name']);
      name = document['Package name'];
      notifyListeners();
    });
    return name;
  }

  Future<String>? getAgencyId(var p) async {
    var document =
        await FirebaseFirestore.instance.collection('Packages').doc(p.pid);
    await document.get().then((document) {
      print(document['Agency Id']);
      AgencyId = document['Agency Id'];
      notifyListeners();
    });
    return AgencyId;
  }

  Future<String>? getDays(var p) async {
    var document =
        await FirebaseFirestore.instance.collection('Packages').doc(p.pid);
    await document.get().then((document) {
      print(document['days']);
      days = document['days'];
      notifyListeners();
    });
    return days;
  }

  Future<String>? getDescription(var p) async {
    var document =
        await FirebaseFirestore.instance.collection('Packages').doc(p.pid);
    await document.get().then((document) {
      print(document['description']);
      desc = document['description'];
      notifyListeners();
    });
    return desc;
  }

  Future<String>? getPrice(var p) async {
    var document =
        await FirebaseFirestore.instance.collection('Packages').doc(p.pid);
    await document.get().then((document) {
      print(document['price']);
      price = document['price'];
      notifyListeners();
    });
    return price;
  }

  Future<String>? getPhotoUrl(var p) async {
    var document =
        await FirebaseFirestore.instance.collection('Packages').doc(p.pid);
    await document.get().then((document) {
      print(document['photoUrl']);
      photoUrl = document['photoUrl'];
      notifyListeners();
    });
    return photoUrl;
  }

  void RemovePackage(Package p) {
    PackageList.remove(p);
    packageManagement.p1.remove(p);
    packageManagement.removePackage(p.pid);
    notifyListeners();
    //FirebaseApi.createTodo(task);
  }
}
