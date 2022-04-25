import 'package:flutter/material.dart';
import 'Agency.dart';

class AgHomeTvView extends StatefulWidget {
  const AgHomeTvView({Key? key}) : super(key: key);

  @override
  _AgHomeTvViewState createState() => _AgHomeTvViewState();
}

class _AgHomeTvViewState extends State<AgHomeTvView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      'https://media.istockphoto.com/photos/creative-concept-for-travel-agency-office-picture-id498890336?s=2048x2048',
                    ),
                    Positioned(
                      top: 250,
                      left: 30,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                          'https://image.shutterstock.com/image-vector/abstract-modern-monogram-xyz-letter-260nw-1281772879.jpg',
                        ),
                      ),
                    ),
                    Positioned(
                        top: 300,
                        left: 150,
                        child: Text(
                          'XYZ TRAVELS',
                          style: TextStyle(fontSize: 30),
                        )),
                  ]),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 70, 15, 0),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 40,
                              child: Container(
                                width: 345,
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        PackageList[index].PName + '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Days:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('\b' + PackageList[index].Days + ''),
                                      Text(
                                        'Price:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          '\$' + PackageList[index].Price + ''),
                                      Text(
                                        'Description:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(PackageList[index].Desc + ''),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
