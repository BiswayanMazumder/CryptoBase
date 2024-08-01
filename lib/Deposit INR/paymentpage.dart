import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobase/Environment%20Files/.env.dart';
import 'package:cryptobase/Home%20Screen/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  int walletbalance=0;
  bool isrp=true;
  bool ismk=false;
  int amount=0;
  bool paymentsts=false;
  String orderid='';
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Future<void> createRazorpayOrder() async {
    final url = 'https://api.razorpay.com/v1/orders';
    final keyId = Environment.razorpaykeyid;
    final keySecret = Environment.razorpaysecret;
    setState(() {
      amount=int.parse(_pricecontroller.text)*100;
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
      'amount': amount,
      'currency': 'INR',
      'receipt': 'receipt#1',
      'notes': {
        'key1': 'value3',
        'key2': 'value2',
      },
    });

    // Make the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );

    // Handle the response
    if (response.statusCode == 200){
      final responseBody = jsonDecode(response.body);
      // Extract the `id` from the response
      final orderId = responseBody['id'];
      final user=_auth.currentUser;
      setState(() {
        orderid=orderId;
      });
      await _firestore.collection('Payment Order ID').doc(user!.uid).set({
        'Order ID':orderId,
        'Time Of Payment':FieldValue.serverTimestamp(),
      });
    } else {
      print('Failed to create order: ${response.statusCode}');
    }
  }
  Future<void> capturepayment(String? paymentid) async {
    final url = 'https://api.razorpay.com/v1/payments/${paymentid}/capture';
    final keyId = Environment.razorpaykeyid;
    final keySecret = Environment.razorpaysecret;
    setState(() {
      amount=int.parse(_pricecontroller.text)*100;
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
      'amount': amount,
      'currency': 'INR',
    });

    // Make the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );

    // Handle the response
    if (response.statusCode == 200){
      print('captured');
    }
  }
  void handlePaymentErrorResponse(PaymentFailureResponse response)async{
    print('payment failed');
    final user=_auth.currentUser;
  }
  void razorpaypayment() async{
    Razorpay razorpay = Razorpay();
    var options = {
      'key':Environment.razorpaykeyid,
      'amount': amount,
      'name': 'CryptoBase',
      'description': 'Wallet Deposit',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'external': {
        'wallets': ['paytm']
      },
      'order_id': orderid
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }
  void handlePaymentSuccessResponse(PaymentSuccessResponse response)async{
    // print('${(amount / 100)+walletbalance}');
    print('Successful');
    final user=_auth.currentUser;
    await fetchbalance();
    await capturepayment(response.paymentId);
    // await createRazorpayOrder();
    // final user=_auth.currentUser;
    setState(() {
      paymentsts=true;
    });
    print(paymentsts);
    await _firestore.collection('Payment Order ID').doc(user!.uid).set({
      'Order ID':response.paymentId,
      'Time Of Payment':FieldValue.serverTimestamp(),
    });
    try{
      await _firestore.collection('Payment Amount').doc(user!.uid).set({
        'Amount':FieldValue.arrayUnion([amount/100])
      },SetOptions(merge: true));
    }catch(e){
      print(e);
    }
    try{
        await _firestore.collection('Wallet Balance').doc(user!.uid).set({
          'Balance':(amount / 100)+walletbalance
        });
      Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
    }catch(e){
      print(e);
    }

  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
  }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchbalance();
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
                    'PAYMENT METHODS',
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
                              'Instant Payment-RazorPay',
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
                          'Processing Time:Upto 3 hours',
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
                              'Instant Payment-MobiKwik',
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
                          'Processing Time:Upto 4 hours',
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
                          hintText: 'Amount to be deposited',
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
                 ElevatedButton(onPressed: (){
                   setState(() {
                     amount=int.parse(_pricecontroller.text)*100;
                   });
                   razorpaypayment();
                 },
                     style:const ButtonStyle(
                       backgroundColor: MaterialStatePropertyAll(Colors.blue)
                     ),
                     child: Text('Proceed to pay',style: GoogleFonts.poppins(
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
