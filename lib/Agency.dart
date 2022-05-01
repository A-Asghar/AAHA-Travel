import 'package:cloud_firestore/cloud_firestore.dart';

import 'services/packageManagement.dart';

class Agency1 {
  String AName;
  String PhNo;
  String About;
  String Email;
  String PhotoUrl;
  String uid;
  Agency1(
      this.AName, this.PhNo, this.About, this.Email, this.PhotoUrl, this.uid) {
    AName = this.AName;
    PhNo = this.PhNo;
    About = this.About;
    Email = this.Email;
    PhotoUrl = this.PhotoUrl;
    uid = this.uid;
  }
}

Agency1 a = Agency1('XYZ', '03331234567', 'About', 'a@gmail.com', '', '000');
List<Agency1> AgencyList = [a, a, a];
List<Package1> PackageList = [];

class Package1 {
  String pid;
  String PName;
  String Aname;
  String Price;
  String Days;
  String Desc;
  String Location;
  double rating;
  String agencyId;
  String photoUrl;
  bool isSaved;
  List<String> ImgUrls = [];
  List<String> otherDetails = [];
  Package1(this.pid, this.PName, this.Aname, this.Price, this.Days, this.Desc,
      this.Location, this.rating, this.agencyId,this.photoUrl, this.ImgUrls,this.otherDetails,this.isSaved) {
    PName = this.PName;
    Price = this.Price;
    Aname = this.Aname;
    Days = this.Days;
    Desc = this.Desc;
    Location = this.Location;
    rating = this.rating;
    agencyId = this.agencyId;
    photoUrl=this.photoUrl;
    isSaved=this.isSaved;
    ImgUrls = this.ImgUrls;
    otherDetails= this.otherDetails;
  }
}
