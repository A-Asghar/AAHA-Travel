import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'packageManagement.dart';
import '../Agency.dart';

class bookingManagement {
  CollectionReference Bookings =
      FirebaseFirestore.instance.collection('Bookings');

  storeNewBooking(travellerID,agencyID,packageID,travelEndDate ) {
    Bookings.add({
      'travellerID' : travellerID,
      'agencyID':agencyID,
      'packageID' : packageID,
      'travelEndDate' : Timestamp.fromDate(travelEndDate)
    });


  }
}




