import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  int walletbalance=0;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchbalance();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1c2835),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(left: 20,right: 20,top:50),
            child: Container(
              height: 180,
              width: MediaQuery.sizeOf(context).width,
              decoration:const BoxDecoration(
                color:  Color(0xFF232f3f),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(padding: EdgeInsets.only(left:10,right:10,top:20,bottom:10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Trading Balance',style: GoogleFonts.poppins(
                        color: Colors.grey
                      ),),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text('₹${walletbalance}',style: GoogleFonts.poppins(
                          color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                      ),),

                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:10),
                        child: Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width/2.5,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Center(
                            child: Text('ADD FUNDS',style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width/2.5,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Center(
                            child: Text('WITHDRAW',style: GoogleFonts.poppins(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500
                            ),),
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
