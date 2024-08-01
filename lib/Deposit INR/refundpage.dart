import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobase/Environment%20Files/.env.dart';
import 'package:cryptobase/Home%20Screen/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
class RefundPage extends StatefulWidget {
  const RefundPage({Key? key}) : super(key: key);

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  @override
  int walletbalance=0;
  bool isrp=true;
  bool ismk=false;
  int amount=0;
  bool paymentsts=false;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Future<void>fetchbalance() async{
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('Wallet Balance').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          walletbalance=docsnap.data()?['Balance'];
        });
      }
    }catch(e){
      print(e);
    }
  }
  List<dynamic> orderid=[];
  Future<void> fetchorderid()async{
    final user=_auth.currentUser;
    if(user!=null){
      final docsnap=await _firestore.collection('Payment Order ID').doc(user.uid).get();
      if(docsnap.exists){
        setState(() {
          orderid=docsnap.data()?['Order ID'];
        });
      }
    }
    print(orderid);
  }
  Future<void> issuerefund() async {
    // Define retry parameters
    int retryCount = 3; // Number of retry attempts
    int currentAttempt = 0; // Track current attempt

    // Iterate over each order ID in the list
    for (int index = orderid.length - 1; index >= 0; index--) {
      final currentOrderId = orderid[index];
      bool success = false;

      while (currentAttempt < retryCount && !success) {
        try {
          final url = 'https://api.razorpay.com/v1/payments/$currentOrderId/refund';
          final keyId = Environment.razorpaykeyid;
          final keySecret = Environment.razorpaysecret;

          setState(() {
            amount = int.parse(_pricecontroller.text) * 100;
          });

          // Combine Key ID and Key Secret into a single string and encode in Base64
          final credentials = '$keyId:$keySecret';
          final encodedCredentials = base64Encode(utf8.encode(credentials));

          // Set up the headers including Basic Auth
          final headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Basic $encodedCredentials',
          };

          // Define the request body
          final body = jsonEncode({
            "amount": amount,
            "speed": "optimum",
          });

          // Make the POST request
          final response = await http.post(
            Uri.parse(url),
            headers: headers,
            body: body,
            encoding: Encoding.getByName('utf-8'),
          );

          // Handle the response
          if (response.statusCode == 200) {
            final responseBody = jsonDecode(response.body);
            final user = _auth.currentUser;

            await _firestore.collection('Payment Refund').doc(user!.uid).set({
              'Amount': FieldValue.arrayUnion([amount / 100]),
            },SetOptions(merge: true));

            var newamount = walletbalance - (amount / 100);
            print(newamount);

            await _firestore.collection('Wallet Balance').doc(user.uid).set({
              'Balance': newamount,
            });

            Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
            success = true; // Indicate success
          } else {
            final responseBody = jsonDecode(response.body);
            print('Failed to capture payment: ${responseBody['error']}');
            currentAttempt++; // Increment attempt counter
            if (currentAttempt >= retryCount) {
              print('Failed after $retryCount attempts for order ID $currentOrderId');
              success = true; // Move to next order ID
            }
          }
        } catch (e) {
          // Handle any other exceptions (e.g., network issues)
          print('Error: $e');
          currentAttempt++; // Increment attempt counter
          if (currentAttempt >= retryCount) {
            print('Failed after $retryCount attempts for order ID $currentOrderId');
            success = true; // Move to next order ID
          }
        }
      }

      // Reset attempt counter for the next order ID
      currentAttempt = 0;
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchbalance();
    fetchorderid();
  }
  final TextEditingController _pricecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232f3f),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2835),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text(
          'CryptoBase',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
              child: Container(
                height: 80,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                    color: Color(0xFF1c2935),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.wallet_outlined,color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('Current Balance',style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text('₹$walletbalance',style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 5),
              child: Row(
                children: [
                  Text(
                    'WITHDRAWAL WALLET',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 30,right: 20),
              child:InkWell(
                onTap: (){
                  setState(() {
                    ismk=false;
                    isrp=true;
                  });
                },
                child:  Container(
                  height: 200,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                      color:isrp?Color(0xFF1c2935): Color(0xFF232f3f),
                      border: Border.all(
                          color: isrp?Colors.transparent:Colors.white,
                          width: 0.5
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Instant withdrawal-RazorPay',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            const Spacer(),
                            isrp?  const Padding(
                              padding:  EdgeInsets.only(right: 20),
                              child: Icon(Icons.check,color: Colors.blue,),
                            ):Container()
                          ],
                        ),
                        Text(
                          '\nFees-₹0.00(Waived for limited time)',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '\nLimits:Rs.100 - Rs.50L',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Transaction:No daily limits',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Withrawal Time:Upto 3 hours',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 30,right: 20),
              child:InkWell(
                onTap: (){
                  print('clicked mobikwik');
                  setState(() {
                    ismk=true;
                    isrp=false;
                  });
                  print(ismk);
                },
                child:  Container(
                  height: 200,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                      color:ismk?Color(0xFF1c2935): Color(0xFF232f3f),
                      border: Border.all(
                          color:ismk? Colors.transparent:Colors.white,
                          width: 0.5
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Instant withdrawal-MobiKwik',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            const Spacer(),
                            ismk?  const Padding(
                              padding:  EdgeInsets.only(right: 20),
                              child: Icon(Icons.check,color: Colors.blue,),
                            ):Container()
                          ],
                        ),
                        Text(
                          '\nFees-₹10.00',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '\nLimits:Rs.100 - Rs.50L',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Transaction:No daily limits',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Withdrawal Time:Upto 4 hours',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PAYMENT AMOUNT',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height:50,
                    width: MediaQuery.sizeOf(context).width/2,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: _pricecontroller,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Amount to be withdrawn',
                            hintStyle: GoogleFonts.arbutusSlab(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w200
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: ()async{
                    setState(() {
                      amount=int.parse(_pricecontroller.text)*100;

                    });
                    issuerefund();
                  },
                      style:const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.blue)
                      ),
                      child: Text('Proceed to withdraw',style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
