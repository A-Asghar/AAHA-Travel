import 'package:flutter/material.dart';
import 'signupAgency.dart';
import 'main.dart';

class paymentInvoice extends StatelessWidget {
  const paymentInvoice({Key? key}) : super(key: key);

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
        child: Center(
          child: Container(
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
                  // color: Colors.red,
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
                        child: const Text(
                          '\$ 199',
                          style: TextStyle(
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
                            child:
                                userInput('Expiry Date', TextInputType.datetime),
                          ),
                          Expanded(
                            child:
                                userInput('Security Code', TextInputType.number),
                          ),
                        ],
                      ),

                      userInput('ZIP / Postal code', TextInputType.number),

                      allButton(buttonText: 'Pay Now', onPressed: () {})
                    ],
                  ),
                ),
              ],
            ),
          ),
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
          hintStyle: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic),
        ),
        keyboardType: keyboardType,
      ),
    ),
  );
}