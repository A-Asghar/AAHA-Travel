import 'package:cloud_firestore/cloud_firestore.dart';

class bookingManagement {
  CollectionReference Bookings =
      FirebaseFirestore.instance.collection('Bookings');

  storeNewBooking(travellerID, agencyID, packageID, travelEndDate, packageName,
      packageNumOfDays, packageDescription, travellerName, packagePrice,agencyName,hasRated,location) {
    Bookings.add({
      'travellerID': travellerID,
      'agencyID': agencyID,
      'packageID': packageID,
      'travelEndDate': travelEndDate,
      'packageName': packageName,
      'packageNumOfDays': packageNumOfDays,
      'packageDescription': packageDescription,
      'travellerName': travellerName,
      'packagePrice': packagePrice,
      'agencyName':agencyName,
      'hasRated':hasRated,
      'location' : location,
      'ImgUrls': []
    });
  }

  storeReview(bookingID, review){
    Bookings.doc(bookingID).set({'ratingReview':review },SetOptions(merge: true));
  }
  getBookingsForAgency(agencyID) {
    Bookings.where('agencyID', isEqualTo: agencyID).get();
  }
  updateHasRated(bookingID) {
    Bookings.doc(bookingID).update({'hasRated': true});
  }
}
