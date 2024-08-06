
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobase/Deposit%20INR/paymentpage.dart';
import 'package:cryptobase/Deposit%20INR/refundpage.dart';
import 'package:cryptobase/Home%20Screen/welcomepage.dart';
import 'package:cryptobase/Login%20Page/emaillogin.dart';
import 'package:cryptobase/Login%20Page/getstarted.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
class AccountHomePage extends StatefulWidget {
  const AccountHomePage({Key? key}) : super(key: key);
  @override
  State<AccountHomePage> createState() => _AccountHomePageState();
}

class _AccountHomePageState extends State<AccountHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int walletbalance = 0;
  File? _selectedimage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showaddress = false;
  Future<void> fetchbalance() async {
    final user = _auth.currentUser;
    try {
      final docsnap =
          await _firestore.collection('Wallet Balance').doc(user!.uid).get();
      if (docsnap.exists) {
        setState(() {
          walletbalance = (docsnap.data()?['Balance']);
        });
      }
    } catch (e) {
      print(e);
    }
  }
  String _randomString = '';
  String generateRandomAlphanumeric(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(length, (_) => chars[random.nextInt(chars.length)]).join();
  }
  Future<void> _generateRandomString() async{
    final user=_auth.currentUser;
    final docsnap=await _firestore.collection('Referral Codes').doc(user!.uid).get();
    if(docsnap.exists){
      setState(() {
        _randomString=docsnap.data()?['Referral Code'];
      });
    }else{
      setState(() {
        _randomString = generateRandomAlphanumeric(10);
      });
      await _firestore.collection('Referral Codes').doc(user!.uid).set({
        'Referral Code':_randomString
      });
      await _firestore.collection('All Referral Codes').doc('User Referral').set(
          {
            'Codes':FieldValue.arrayUnion([_randomString])
          },SetOptions(merge: true));
      // print('written');
    }
  }
  String walletaddress = '';
  Future<void> getwalletaddress() async {
    final user = _auth.currentUser;
    final docsnap =
        await _firestore.collection('Wallet ID').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        walletaddress = docsnap.data()?['Wallet Address'];
        dataloaded=true;
      });
      print('address fetched');
    }
  }

  String username = '';
  List<dynamic> namesplit=[];
  bool dataloaded=false;
  Future<void> fetchname() async {
    final user = _auth.currentUser;
    try {
      final docsnap =
          await _firestore.collection('User Details').doc(user!.uid).get();
      if (docsnap.exists) {
        setState(() {
          username = docsnap.data()?['Name'];
          namesplit=username.split(' ');
          dataloaded=true;
        });
        print('Username ${username}');
        print('Splitted ${namesplit}');
      }
    } catch (e) {
      print(e);
    }
  }
  String currency='';

  Future<void> readfetcheddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? counter = prefs.getString('selected_currency_name');
    if (counter != null) {
      setState(() {
        currency = counter;
      });
    } else {
      prefs.setString('selected_currency_name', 'INR');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchbalance();
    getwalletaddress();
    fetchname();
    readfetcheddata();
    _generateRandomString();
    // getwalletaddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1c2835),
      body:dataloaded? SingleChildScrollView(
        child: Column(
          children: [
             Padding(padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
            child: Center(
              child: InkWell(
                onTap: ()async{
                  print('Clicked');
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.image, // Specify that you want images
                  );

                  if (result != null) {
                    // Get the selected file
                    PlatformFile file = result.files.first;

                    // Print file details
                    print('File name: ${file.name}');
                    print('File size: ${file.size} bytes');
                    print('File path: ${file.path}');
                    setState(() {
                      _selectedimage = File(result.files.single.path!);
                    });
                  } else {
                    // User canceled the picker
                    print('No file selected');
                  }
                },
                child:CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  backgroundImage: _selectedimage == null
                      ? AssetImage('assets/images/crypto_image-removebg-preview.png') as ImageProvider
                      : FileImage(_selectedimage!) as ImageProvider,
                ),

              ),
            ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                height: 110,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFF232f3f),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'User Name',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            username,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                height: 110,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFF232f3f),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Preferred Currency',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            currency,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                height: 130,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFF232f3f),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Referral Code',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            _randomString,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Refer to friend and get 200 INR in bonus',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                height: 180,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                    color: Color(0xFF232f3f),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Trading Balance',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            '₹$walletbalance',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentPage(),
                                    ));
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    'ADD FUNDS',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RefundPage(),
                                    ));
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: Colors.blue, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    'WITHDRAW',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFF232f3f),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Wallet Address',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: InkWell(
                                onTap: () async {

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Copied Wallet Address',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.copy,
                                  color: Colors.grey,
                                  size: 15,
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            showaddress ? '$walletaddress' : '*********',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  showaddress = true;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    'SHOW ADDRESS',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  showaddress = false;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: Colors.blue, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    'HIDE ADDRESS',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ):Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height/2,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
