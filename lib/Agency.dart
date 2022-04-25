
import 'services/packageManagement.dart';
class Agency{
  String AName;
  String PhNo;
  String Password;
  String About;
  Agency(this.AName,this.PhNo,this.Password,this.About){
    AName=this.AName;
    PhNo=this.PhNo;
    Password=this.Password;
    About=this.About;
  }
}
Agency a = Agency('XYZ', '03331234567', 'Password', 'Lorem Ipsum is simply dummy text of the\n printing and typesetting industry');
Agency a1 = Agency('XYZ1', '03331234567', 'Password', 'Lorem Ipsum is simply dummy text of the\n printing and typesetting industry');
List<Agency> AgencyList =[a,a1,a,a];
Package1 p = Package1('123','Karachi 1','XYZ', '200', '15', 'Lorem Ipsum is simply dummy text of the \n printing and typesetting industry','',0,'',[]);
List<Package1> PackageList =[p];
class Package1{
  String pid;
  String PName;
  String Aname;
  String Price;
  String Days;
  String Desc;
  String Location;
  int rating;
  String agencyId;
  List<String> ImgUrls=[];
  Package1(this.pid,this.PName,this.Aname,this.Price,this.Days,this.Desc,this.Location,this.rating, this.agencyId,this.ImgUrls){
    PName=this.PName;
    Price=this.Price;
    Aname=this.Aname;
    Days=this.Days;
    Desc=this.Desc;
    Location=this.Location;
    rating=this.rating;
    agencyId=this.agencyId;
    ImgUrls=this.ImgUrls;
  }
}
