import 'package:aaha/services/bookingManagement.dart';
import 'package:aaha/services/packageManagement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'otherDetails.dart';
import 'Widgets/userInput.dart';
import 'addPackage.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bookingHistoryListTraveller(),
    );
  }
}

class bookingHistoryListTraveller extends StatefulWidget {
  @override
  State<bookingHistoryListTraveller> createState() =>
      _bookingHistoryListTravellerState();
}

class _bookingHistoryListTravellerState
    extends State<bookingHistoryListTraveller> {
  final CollectionReference Packages =
      FirebaseFirestore.instance.collection('Bookings');
  File? file;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  UploadTask? task;
  List<String> ImgUrls = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Packages.where('travellerID',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('travelEndDate', isLessThan: DateTime.now())
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading . .. ");
        }

        return ListView.builder(
          itemCount: snapshot.data.docs.length,
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
                          snapshot.data.docs[index]['packageName'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        snapshot.data.docs[index]['hasRated']
                            ? Text('Rated')
                            : InkWell(
                                onTap: () {
                                  final _dialog = RatingDialog(
                                    initialRating: 1.0,
                                    title: const Text(
                                      'Rate Your Trip',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // encourage your user to leave a high rating?
                                    message: Text(
                                      'How was your experience with ' +
                                          snapshot.data.docs[index]
                                              ['agencyName'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    // your app's logo?
                                    image: const FlutterLogo(size: 100),
                                    submitButtonText: 'Submit',
                                    commentHint: 'Write your review here.',
                                    onCancelled: () => print('cancelled'),
                                    onSubmitted: (response) {
                                      bookingManagement().updateHasRated(
                                          snapshot.data.docs[index].id);
                                      packageManagement().updateReviewCount(
                                          snapshot.data.docs[index]
                                              ['packageID']);
                                      packageManagement().updateRating(
                                          snapshot.data.docs[index]
                                              ['packageID'],
                                          response.rating);
                                    },
                                  );

                                  // show the dialog
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        true, // set to false if you want to force a rating
                                    builder: (context) => _dialog,
                                  );
                                },
                                child: Text(
                                  ' Rate \n Now',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(snapshot.data.docs[index]
                                  ['packageNumOfDays'] +
                              ' Days'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            InkWell(
                              child: Icon(Icons.camera_alt_outlined),
                              onTap: () {
                                Dialog addPictures = Dialog(
                                    child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          selectImages();
                                        },
                                        icon: Icon(Icons.camera_alt)),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        child: GridView.builder(
                                            itemCount: imageFileList!.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 6,
                                              mainAxisSpacing: 6,
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white70),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                        child: Image.file(
                                                          File(imageFileList![
                                                                  index]
                                                              .path),
                                                          fit: BoxFit.scaleDown,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      task != null
                                                          ? buildUploadStatus(
                                                              task!)
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ));
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        addPictures);
                              },
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(snapshot
                                      .data
                                      .docs[index]['packageDescription']
                                      .length <
                                  120
                              ? snapshot.data.docs[index]['packageDescription']
                              : snapshot.data.docs[index]['packageDescription']
                                  .substring(0, 120)),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ended On:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(DateFormat('EEE, MMM d, ' 'yy').format(
                              (snapshot.data.docs[index]['travelEndDate']
                                      as Timestamp)
                                  .toDate())),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data.docs[index]['agencyName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                            Text(
                              '\$ ' + snapshot.data.docs[index]['packagePrice'],
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
          },
        );
      },
    );
  }

  void selectImages() async {
    final List<XFile>? selectedImages =
    await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" +
        imageFileList!.length.toString());
    setState(() {});
    await uploadFile(imageFileList!);
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future uploadFile(List _images) async {
    _images.forEach((_photo) async {
      if (_photo == null) {
        return;
      }
      ;
      File file = File(_photo.path);
      final fileName = basename(file.path);
      final destination = '$fileName';
      int i = 1;
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref =
        storage.ref().child(packageManagement.Packid + '___' + fileName);
        i = i + 1;
        String url = '';
        task = ref.putFile(file);
        setState(() {});
        TaskSnapshot taskSnapshot = await task!.whenComplete(() {});
        taskSnapshot.ref.getDownloadURL().then(
              (value) {
            url = value;
            ImgUrls.add(url);
            print(ImgUrls[0] +
                '\n...................................................................................................................');
            print("Done: $value");
          },
        );
        final urlString = ref.getDownloadURL();
      } catch (e) {
        print('error occured');
        print(e);
      }
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
