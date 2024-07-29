import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DepositHome extends StatefulWidget {
  const DepositHome({Key? key}) : super(key: key);

  @override
  State<DepositHome> createState() => _DepositHomeState();
}

class _DepositHomeState extends State<DepositHome> {
  bool istransaction=true;
  int walletbalance=0;
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
  List <dynamic> paymentamount=[];
  List<dynamic> paymentstatus=[];
  Future<void> paymentstatusfetch() async{
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('Payment Status').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          paymentstatus=docsnap.data()?['Status'];
        });
        // print(paymentstatus);
      }
    }catch(e){
      print(e);
    }

  }
  Future<void> paymentamountfetch() async{
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('Payment Amount').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          paymentamount=docsnap.data()?['Amount'];
        });
        // print(paymentamount);
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
    paymentstatusfetch();
    paymentamountfetch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232f3f),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Text('INR Wallet',style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text('${walletbalance} INR',style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      istransaction=true;
                    });
                  },
                  child: Text('TRANSACTIONS',style: GoogleFonts.poppins(
                    color: istransaction? Colors.white:Colors.grey,
                    fontWeight: FontWeight.w600
                  ),),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      istransaction=false;
                    });
                  },
                  child: Text('EXCHANGE',style: GoogleFonts.poppins(
                      color:istransaction? Colors.grey:Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
                ),
              ],
            ),
             const SizedBox(
               height: 20,
             ),
             for(int i=0;i<paymentamount.length;i++)
               Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 30),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         if(paymentstatus[i])
                           Text('Processing Deposit',style: GoogleFonts.poppins(
                               color: Colors.white,
                               fontWeight: FontWeight.w500,
                                fontSize: 18
                           ),),
                         if(!paymentstatus[i])
                           Text('Deposit',style: GoogleFonts.poppins(
                               color: Colors.white,
                               fontWeight: FontWeight.w500,
                               fontSize: 18
                           ),),

                       ],
                     )
                   ],
                 ),
               ),
             SizedBox(
              height: MediaQuery.sizeOf(context).height/1.4,
            ),
            Container(
              width: double.infinity,
              height:78,
              color: const Color(0xFF1c2835),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 70,
                    width: MediaQuery.sizeOf(context).width/2.5,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text('DEPOSIT',style: GoogleFonts.poppins(
                        color: Colors.white,fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: MediaQuery.sizeOf(context).width/2.5,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text('WITHDRAW',style: GoogleFonts.poppins(
                          color: Colors.white,fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
