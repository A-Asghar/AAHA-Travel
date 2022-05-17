import 'package:url_launcher/url_launcher.dart';

class GoogleMapLauncher {
  GoogleMapLauncher._();

  // static Future<void> openMap1(double latitude, double longitude) async {
  //   String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  //   if (await canLaunchUrlString(googleUrl)) {
  //     await launchUrlString(googleUrl);
  //   } else {
  //     throw 'Could not open the map.';
  //   }
  // }
  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

}