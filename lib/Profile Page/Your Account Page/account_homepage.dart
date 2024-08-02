import 'package:click_to_copy/click_to_copy.dart';
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

class AccountHomePage extends StatefulWidget {
  const AccountHomePage({Key? key}) : super(key: key);
  @override
  State<AccountHomePage> createState() => _AccountHomePageState();
}

class _AccountHomePageState extends State<AccountHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int walletbalance = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showaddress = false;
  Future<void> fetchbalance() async {
    final user = _auth.currentUser;
    try {
      final docsnap =
          await _firestore.collection('Wallet Balance').doc(user!.uid).get();
      if (docsnap.exists) {
        setState(() {
          walletbalance = docsnap.data()?['Balance'];
        });
      }
    } catch (e) {
      print(e);
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
      });
      print('address fetched');
    }
  }

  String username = '';
  Future<void> fetchname() async {
    final user = _auth.currentUser;
    try {
      final docsnap =
          await _firestore.collection('User Details').doc(user!.uid).get();
      if (docsnap.exists) {
        setState(() {
          username = docsnap.data()?['Name'];
        });
        print('Username ${username}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchbalance();
    getwalletaddress();
    fetchname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1c2835),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Container(
                height: 110,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFF232f3f),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
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
                            '$username',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 25,
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
                                fontSize: 25,
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
                                  await ClickToCopy.copy(walletaddress);
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
                                child: Icon(
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
                                fontSize: 25,
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
            )
          ],
        ),
      ),
    );
  }
}
