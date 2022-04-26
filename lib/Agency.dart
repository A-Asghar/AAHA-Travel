import 'package:cloud_firestore/cloud_firestore.dart';

import 'services/packageManagement.dart';

class Agency {
  String AName;
  String PhNo;
  String Password;
  String About;
  Agency(this.AName, this.PhNo, this.Password, this.About) {
    AName = this.AName;
    PhNo = this.PhNo;
    Password = this.Password;
    About = this.About;
  }
}

Agency a = Agency('XYZ', '03331234567', 'Password',
    'Lorem Ipsum is simply dummy text of the\n printing and typesetting industry');
Agency a1 = Agency('XYZ1', '03331234567', 'Password',
    'Lorem Ipsum is simply dummy text of the\n printing and typesetting industry');
List<Agency> AgencyList = [a, a1, a, a];
Package p = Package(
    '123',
    'Karachi 1',
    'XYZ',
    '200',
    '15',
    'Lorem Ipsum is simply dummy text of the \n printing and typesetting industry',
    '',
    0,
    '', []);
List<Package> PackageList = [p];
List<Package> packageListTravellerHome = [];

class Package {
  String pid;
  String PName;
  String Aname;
  String Price;
  String Days;
  String Desc;
  String Location;
  int rating;
  String agencyId;
  List<String> ImgUrls = [];
  Package(this.pid, this.PName, this.Aname, this.Price, this.Days, this.Desc,
      this.Location, this.rating, this.agencyId, this.ImgUrls) {
    PName = this.PName;
    Price = this.Price;
    Aname = this.Aname;
    Days = this.Days;
    Desc = this.Desc;
    Location = this.Location;
    rating = this.rating;
    agencyId = this.agencyId;
    ImgUrls = this.ImgUrls;
  }

  Package.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      :
      pid = doc.id,
        PName = doc.data()!["PName"],
        Price = doc.data()!["Price"],
        Aname = doc.data()!["Aname"],
        Days = doc.data()!["Days"],
        Desc = doc.data()!["Desc"],
        Location = doc.data()!["Location"],
        rating = doc.data()!["rating"],
        agencyId = doc.data()!["agencyId"],
        ImgUrls = doc.data()!["ImgUrls"]
  {}

}


