import 'package:aaha/addPackage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'services/bookingManagement.dart';
import 'package:flutter/material.dart';
import 'signupAgency.dart';
import 'main.dart';
import 'Agency.dart';
import 'services/packageManagement.dart';

class paymentInvoice extends StatefulWidget {
  final Package1 package;
  const paymentInvoice({Key? key, required this.package}) : super(key: key);

  @override
  State<paymentInvoice> createState() => _paymentInvoiceState();
}

DateTime date = DateTime.now();
bool validate2 = false;
TextEditingController _controller2 = TextEditingController();
DateTime travelEndDate = DateTime.now();
DateTime? travelStartDate = DateTime.now();
String startDate = '';
String endDate = '';

class _paymentInvoiceState extends State<paymentInvoice> {
  @override
  void initState() {
    startDate = 'Select Date';
    endDate = '';
    travelEndDate = DateTime.now();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Payment Invoice',
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
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                'Schedule:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            selectSchedule(package: widget.package),
            Center(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                              child: Image.network(
                                  'https://res.cloudinary.com/okay-rent-a-car/images/v1617474656/content/images/payment-method-no-credit-card-needed/payment-method-no-credit-card-needed.webp')),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: const Text(
                                  'Payment Amount ',
                                  style: TextStyle(fontSize: 24),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  '\$' + widget.package.Price,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    // fontWeight: FontWeight.bold,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 3.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              userInput('Name on card', TextInputType.text),
                              userInput('Card Number', TextInputType.number),
                              Row(
                                children: [
                                  Expanded(
                                    child: userInput(
                                        'Expiry Date', TextInputType.datetime),
                                  ),
                                  Expanded(
                                    child: userInput(
                                        'Security Code', TextInputType.number),
                                  ),
                                ],
                              ),
                              userInput(
                                  'ZIP / Postal code', TextInputType.number),
                              allButton(
                                  buttonText: 'Pay Now',
                                  onPressed: () async {
                                    if (travelEndDate.day ==
                                        DateTime.now().day) {
                                      showAlertDialog(
                                        context: context,
                                        title: 'A problem has occurred',
                                        content:
                                            'You did not select a start date !',
                                      );
                                    } else {
                                      bookingManagement().storeNewBooking(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          widget.package.agencyId,
                                          widget.package.pid,
                                          travelEndDate);
                                      showAlertDialog(
                                          context: context,
                                          title: 'Success',
                                          content:
                                              'Your holiday has been successfully booked');
                                    }
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget userInput(String hintTitle, TextInputType keyboardType) {
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
          hintStyle: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        ),
        keyboardType: keyboardType,
      ),
    ),
  );
}

class selectSchedule extends StatefulWidget {
  final Package1 package;
  const selectSchedule({Key? key, required this.package}) : super(key: key);

  @override
  State<selectSchedule> createState() => _selectScheduleState();
}

class _selectScheduleState extends State<selectSchedule> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: IconButton(
              icon: Icon(Icons.calendar_today_outlined),
              onPressed: () async {
                travelStartDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2025));
                travelEndDate = travelStartDate!
                    .add(Duration(days: int.parse(widget.package.Days)));
                setState(() {
                  startDate = (travelStartDate!.day.toString() +
                      "/" +
                      travelStartDate!.month.toString() +
                      "/" +
                      travelStartDate!.year.toString());
                  endDate = (travelEndDate!.day.toString() +
                      "/" +
                      travelEndDate!.month.toString() +
                      "/" +
                      travelEndDate!.year.toString());
                });
              },
            )),
        Text(startDate),
        Text(endDate == '' ? '' : ' till '),
        Text(endDate),
      ],
    );
  }
}
