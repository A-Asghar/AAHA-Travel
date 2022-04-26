
import 'package:aaha/services/agencyManagement.dart';
import 'services/packageManagement.dart';
import 'package:provider/provider.dart';
import 'package:aaha/services/packageManagement.dart';
import 'package:aaha/services/travellerManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AgHomeAgView.dart';
import 'ProfileAgency.dart';
import 'addPackage.dart';
import 'bookingHistory.dart';
import 'loginScreen.dart';
import 'mainScreen.dart';
import 'paymentInvoice.dart';
import 'searchPage.dart';
import 'signupAgency.dart';
import 'topTravelDestinations.dart';
import 'travellerProfile.dart';
import 'travellerhome.dart';
import 'AgHomeTvView.dart';
import 'Agency.dart';
import 'agencyhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//check git push
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAtN39RIKKARPM3pdZ9LipIkX0FLGnm45s", // Your apiKey
      appId: "1:99687925149:android:527af34c12272e38885b74", // Your appId
      messagingSenderId: "99687925149", // Your messagingSenderId
      projectId: "assignment4-e9d53", // Your projectId
      storageBucket:"assignment4-e9d53.appspot.com",
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => travellerProvider()),
        ChangeNotifierProvider(create: (_) => agencyProvider()),
        ChangeNotifierProvider(create: (_) => packageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new mainScreen(),
    );
  }
}

class allButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const allButton({Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.indigo.shade800,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.blueGrey)))),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}

class mainImage extends StatefulWidget {
  const mainImage({Key? key}) : super(key: key);

  @override
  _mainImageState createState() => _mainImageState();
}

class _mainImageState extends State<mainImage> {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Image.network(
          'https://i.ibb.co/hMfcXgs/ezgif-com-gif-maker.jpg',
        ),
      ),
    );
  }
}
