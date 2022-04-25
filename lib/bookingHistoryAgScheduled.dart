import 'package:flutter/material.dart';

class ScheduledAg extends StatelessWidget {
  const ScheduledAg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String descriptionText = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s' ;

    return Scaffold(
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Stack(
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trip $index',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),

                      ],
                    ),
                    subtitle: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('15 Days'),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Desciption:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            maxLines: 1,textAlign: TextAlign.start ),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            descriptionText.substring(0,120) + '...'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Customer name',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),),
                          Text(
                            'Package Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}