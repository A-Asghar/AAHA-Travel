import 'package:aaha/Pkg_details_Ag.dart';
import 'package:provider/provider.dart';
import 'editPackage.dart';
import 'addPackage.dart';
import 'ProfileAgency.dart';
import 'Agency.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'MyBottomBarDemo.dart';
import 'services/packageManagement.dart';
import 'package:aaha/pkg_detail_pg_travellers.dart';
class AgHomeAgView extends StatefulWidget {
  const AgHomeAgView({Key? key}) : super(key: key);

  @override
  _AgHomeAgViewState createState() => _AgHomeAgViewState();
}

class _AgHomeAgViewState extends State<AgHomeAgView> {

  @override
  void initState() {
    // TODO: implement initState
    //context.read<packageProvider>().setPackages();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
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
                          child: Row(
                            children: [
                              Text(
                                'XYZ TRAVELS',
                                style: TextStyle(fontSize: 30),
                              ),
                              Text("                       "),
                            ],
                          )),
                      Positioned(
                        child: FloatingActionButton(
                          heroTag: null,
                          child: Icon(Icons.add),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (Context) => addPackage(),
                            ));
                          },
                          backgroundColor: Colors.black,
                        ),
                        top: 240,
                        right: 40,
                      ),
                    ]),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      //scrollDirection: Axis.horizontal,
                      itemCount: context.read<packageProvider>().getList().length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap:(){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (Context) => PkgDetailAgency(pack: PackageList[index]),
                            ));
                          } ,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                  elevation: 40,
                                  child: Container(
                                    width: 345,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              context.read<packageProvider>().getList()[index].PName + '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Days:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text('\b' +
                                                context.read<packageProvider>().getList()[index].Days +
                                                ''),
                                            Text(
                                              'Price:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text('\$' +
                                                context.read<packageProvider>().getList()[index].Price +
                                                ''),
                                            Text(
                                              'Description:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                child: Text(context.read<packageProvider>().getList()[index].Desc + '')),
                                          ],
                                        ),
                                        Column(children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (Context) =>
                                                      editPackage(p:context.read<packageProvider>().getList()[index]),
                                                  
                                                )).then((value) => setState((){}));
                                              },
                                              child: Icon(Icons.edit)),
                                          TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext ctx) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Please Confirm'),
                                                        content: const Text(
                                                            'Are you sure to remove the task?'),
                                                        actions: [
                                                          // The "Yes" button
                                                          TextButton(
                                                              onPressed: () {
                                                                // Remove the box
                                                                //   packageManagement.removePackage(PackageList[index].pid);
                                                                //   packageManagement.removePackage(packageManagement.p1[index].pid);
                                                                setState(() {

                                                                });
                                                                  context.read<packageProvider>().RemovePackage(PackageList[index]);

                                                                  // Close the dialog

                                                                Navigator.of(
                                                                        ctx)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  'Yes')),
                                                          TextButton(
                                                              onPressed: () {
                                                                // Close the dialog
                                                                Navigator.of(
                                                                        ctx)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  'No'))
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ])
                                      ]),
                                    ),
                                  ),
                                ),
                              ]),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      //bottomNavigationBar: MyBottomBarDemo(),
    );

  }
}

