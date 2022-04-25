import 'package:aaha/Agency.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'MyBottomBarDemo.dart';
import 'signupAgency.dart';
import 'loginScreen.dart';
import 'MyBottomBarDemo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aaha/services/packageManagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'dart:io';
import 'package:aaha/pkg_detail_pg_travellers.dart';
import 'package:image_picker/image_picker.dart';
TextEditingController _nameController= TextEditingController();
TextEditingController _descController= TextEditingController();
TextEditingController _daysController= TextEditingController();
TextEditingController _priceController= TextEditingController();
TextEditingController _locationController= TextEditingController();

class addPackage extends StatefulWidget {
  const addPackage({Key? key}) : super(key: key);
  @override
  _addPackage createState() => _addPackage();


  }
class _addPackage extends State<addPackage> {
  File? file;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  UploadTask? task;
  List<String> ImgUrls1=[];
  // final ImagePicker _picker = ImagePicker();
  // late File _image;
  // bool uploadStatus = false;
  // _imageFromCamera() async {
  //   final PickedFile? pickedImage =
  //   await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
  //   if (pickedImage == null) {
  //     showAlertDialog(
  //         context: context,
  //         title: "Error Uploading!",
  //         content: "No Image was selected.");
  //     return;
  //   }
  //   final File fileImage = File(pickedImage.path);
  //
  //   if (imageConstraint(fileImage)) {
  //     setState(() {
  //       _image = fileImage;
  //     });
  //   }
  // }
  // _imageFromGallery() async {
  //   final PickedFile? pickedImage =
  //   await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
  //   if (pickedImage == null) {
  //     showAlertDialog(
  //         context: context,
  //         title: "Error Uploading!",
  //         content: "No Image was selected.");
  //     return;
  //   }
  //   final File fileImage = File(pickedImage.path);
  //   if (imageConstraint(fileImage))
  //     setState(() {
  //       _image = fileImage;
  //     });
  // }
  // bool imageConstraint(File image) {
  //   if (!['bmp', 'jpg', 'jpeg']
  //       .contains(image.path.split('.').last.toString())) {
  //     showAlertDialog(
  //         context: context,
  //         title: "Error Uploading!",
  //         content: "Image format should be jpg/jpeg/bmp.");
  //     return false;
  //   }
  //   if (image.lengthSync() > 100000) {
  //     showAlertDialog(
  //         context: context,
  //         title: "Error Uploading!",
  //         content: "Image Size should be less than 100KB.");
  //     return false;
  //   }
  //   return true;
  // }
  @override
  Widget build(BuildContext context) {
    final filename = file !=null ? file!.path.toString() : ('No file selected');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // floatingActionButton:
      //     FloatingActionButton.extended(onPressed: () {}, label: null,
      //         ),
      appBar: AppBar(
        title: const Text(
          'Add Package',
          style: (TextStyle(color: Colors.black, fontSize: 30)),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),



    body: SingleChildScrollView(
      child: Center(
          child: Column(
            children: [
              userInput('Package Name', TextInputType.text,_nameController),
              userInput('Description', TextInputType.text,_descController),
              userInput('Days', TextInputType.text,_daysController),
              userInput('Price', TextInputType.number,_priceController),
              userInput('Location', TextInputType.text,_locationController),

              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Gallery',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
Padding(padding: EdgeInsets.fromLTRB(0, 0, 20 , 10), child: IconButton(onPressed: (){
                                                                                     //_imageFromGallery();
                                                                                      selectImages();

                                                                                    }, icon: Icon(Icons.camera_alt_outlined)),)

                  ],
                ),

              ),
              Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width * 0.9,
                //height: MediaQuery.of(context).size.height * 0.5-10,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: GridView.builder(
                      itemCount: imageFileList!.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,

                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          //height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0x44000000),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: 95,
                                  width: 110,
                                  child: Image.file(File(imageFileList![index].path),
                                    fit: BoxFit.fill,

                                  ),
                                ),
                                SizedBox(height: 5),
                                task != null ? buildUploadStatus(task!) : Container(),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
               // SizedBox(
               //  height: 40,
               // ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Colors.indigo.shade800,
                  onPressed: () async{


                      print(ImgUrls1.length);
                    await packageManagement.storeNewPackage(FirebaseAuth.instance.currentUser, _nameController.text, _descController.text, _daysController.text, _priceController.text,_locationController.text, 0, context,ImgUrls1);
                      setState(() {

                      });
                      _nameController.clear();
                      _descController.clear();
                      _daysController.clear();
                      _priceController.clear();
                      _locationController.clear();




                    // FirebaseAuth.instance
                    //     .createUserWithEmailAndPassword(
                    //     email: _email.text,
                    //     password: _password.text)
                    //     .then((signedInUser) {
                    //   agencyManagement(
                    //       uid: FirebaseAuth
                    //           .instance.currentUser!.uid)
                    //       .storeNewAgency(signedInUser.user,
                    //       _name.text, _phoneNum.text, context);
                    // }).catchError((e) {
                    //   print(e);
                    //   signupErrorDialog(e.code, context);
                    // });

                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
    ),
     // bottomNavigationBar: MyBottomBarDemo(),
    );
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if(result==null) return;
    final path = result.files.toList();
    setState(() {
     // file=File(path.iterator);
    });
  }
  void selectImages() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState((){});
    await uploadFile(imageFileList!);
  }
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future uploadFile(List _images) async {
    _images.forEach((_photo)async{
      if (_photo == null) {

        return;
      };
      File file = File( _photo.path );
      final fileName = basename(file.path);
      final destination = '$fileName';
      int i=1;
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
         Reference ref = storage
            .ref()
            .child(packageManagement.Packid+'___'+fileName);
         i=i+1;
        String url='';
        task = ref.putFile(file);
        setState(() {

        });
         TaskSnapshot taskSnapshot = await task!.whenComplete(() {});
         taskSnapshot.ref.getDownloadURL().then(
               (value){
                 url=value;
                 ImgUrls1.add(url);
                 print(ImgUrls1[0]+'\n...................................................................................................................');
                 print("Done: $value");},
         );
        final urlString = ref.getDownloadURL();

       //print(ImgUrls1.length+200);





        //return urlString;
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
Widget userInput(String hintTitle, TextInputType keyboardType, TextEditingController a) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      // color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25),
      child: TextField(
        // controller: controller,
        decoration: InputDecoration(
          hintText: hintTitle,
          hintStyle: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic),
        ),
        keyboardType: keyboardType,
        controller: a,
      ),
    ),
  );
}
showAlertDialog({required BuildContext context, required String title, required String content}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ""),
          content: Text(content ?? ""),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Continue'),
              ),
            ),
          ],
        );
      });
}
