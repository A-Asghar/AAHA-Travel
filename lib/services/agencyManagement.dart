import 'package:aaha/Agency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:aaha/MyBottomBarDemo.dart';
import 'package:provider/provider.dart';
class agencyManagement {
  final String uid;
  agencyManagement({required this.uid});
  CollectionReference Agency =
      FirebaseFirestore.instance.collection('Agencies');
  storeNewAgency(user, name, phoneNum, context) {

    Agency.doc(uid).set({
      'email': user.email,
      'uid': user.uid,
      'name': name,
      'phoneNum': phoneNum,
      'about': 'About you',

      'photoUrl': 'https://cdn-icons-png.flaticon.com/512/32/32441.png',
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyBottomBarDemo(),
      ));
    });
  }

  updateAgencyName(name) async {
    await Agency.doc(uid).update({'name': name});
  }

  updateAgencyPhoneNum(phoneNum) {
    Agency.doc(uid).update({'phoneNum': phoneNum});
  }

  updateAgencyAbout(about) {
    Agency.doc(uid).update({'about': about});
  }

  updateAgencyPhotoUrl(photoUrl) {
    Agency.doc(uid).update({'photoUrl': photoUrl});
  }

  Future<bool> isAgency() async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('Agencies');

      var doc = await collectionRef.doc(uid).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }
}

class agencyProvider extends ChangeNotifier {
  String name = 'DummyName';
  String email = 'DummyEmail@DummyEmail.com';
  String phoneNum = '00000000000';
  String about = 'About you';
  String photoUrl = 'https://flyclipart.com/thumb2/person-icon-137546.png';

  Future<String>? getName(var user) async {
    var document =
        await FirebaseFirestore.instance.collection('Agencies').doc(user.uid);
    await document.get().then((document) {
      print(document['name']);
      name = document['name'];
      notifyListeners();
    });
    return name;
  }

  Future<String>? getEmail(var user) async {
    var document =
        await FirebaseFirestore.instance.collection('Agencies').doc(user.uid);
    await document.get().then((document) {
      print(document['email']);
      email = document['email'];
      notifyListeners();
    });
    return email;
  }

  Future<String>? getPhoneNum(var user) async {
    var document =
        await FirebaseFirestore.instance.collection('Agencies').doc(user.uid);
    await document.get().then((document) {
      print(document['phoneNum']);
      phoneNum = document['phoneNum'];
      notifyListeners();
    });
    return phoneNum;
  }

  Future<String>? getAbout(var user) async {
    var document =
        await FirebaseFirestore.instance.collection('Agencies').doc(user.uid);
    await document.get().then((document) {
      print(document['about']);
      about = document['about'];
      notifyListeners();
    });
    return about;
  }

  Future<String>? getPhotoUrl(var user) async {
    var document =
        await FirebaseFirestore.instance.collection('Agencies').doc(user.uid);
    await document.get().then((document) {
      print(document['photoUrl']);
      photoUrl = document['photoUrl'];
      notifyListeners();
    });
    return photoUrl;
  }
}
