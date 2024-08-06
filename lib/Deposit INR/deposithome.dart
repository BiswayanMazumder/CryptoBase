import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobase/Deposit%20INR/paymentpage.dart';
import 'package:cryptobase/Deposit%20INR/refundpage.dart';
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
  bool isloaded=false;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Future<void>fetchbalance() async{
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('Wallet Balance').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          walletbalance=(docsnap.data()?['Balance'] as double).round();
        });
      }
    }catch(e){
      print(e);
    }
  }
  List <dynamic> paymentamount=[];
  List <dynamic> refundamount=[];
  List<dynamic> paymentstatus=[];
  Future<void> paymentstatusfetch() async{
    final user=_auth.currentUser;
    // await paymentamountfetch();
    try{
      final docsnap=await _firestore.collection('Payment Status').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          paymentstatus=docsnap.data()?['Status'];
        });
      }
    }catch(e){
      print(e);
    }

  }
  Future<void> paymentamountfetch() async{
    await paymentstatusfetch();
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('Payment Amount').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          paymentamount=docsnap.data()?['Amount'];
          isloaded=true;
        });
        // print(paymentamount);
      }
    }catch(e){
      print(e);
    }

  }
  Future<void> refundamountfetch() async{
    await paymentstatusfetch();
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('Payment Refund').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          refundamount=docsnap.data()?['Amount'];
          // isloaded=true;
        });
        print(refundamount);
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
    // paymentstatusfetch();
    paymentamountfetch();
    refundamountfetch();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF232f3f),
      bottomNavigationBar: Row(
        children: [
          Container(
            height: 70,
            width: MediaQuery.sizeOf(context).width,
            color: const Color(0xFF1c2835),
            child:  Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(),));
                    },
                    child: Container(
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
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RefundPage(),));
                    },
                    child: Container(
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
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
              child: Text('${walletbalance.round()} INR',style: GoogleFonts.poppins(
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
                  child: Text('WITHDRAWAL',style: GoogleFonts.poppins(
                      color:istransaction? Colors.grey:Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
                ),
              ],
            ),
             const SizedBox(
               height: 20,
             ),
         isloaded?   istransaction? Column(
               children: [
                 for(int i=0;i<paymentamount.length;i++)
                   Padding(
                     padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 30),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(right: 5),
                               child: Icon(Icons.check,
                                 size: 20,color:Colors.green),
                             ),
                               Text('Deposit Credited',style: GoogleFonts.poppins(
                                   color: Colors.green,
                                   fontWeight: FontWeight.w500,
                                   fontSize: 15
                               ),),
                             const Spacer(),
                             Text('${paymentamount[i]} INR',style: GoogleFonts.poppins(
                               color: Colors.green,
                               fontWeight: FontWeight.w600,

                             ),)
                           ],
                         ),
                       ],
                     ),
                   ),
               ],
             ):Column(
           children: [
             for(int i=0;i<refundamount.length;i++)
               Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 30),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(right: 5),
                           child: Icon(Icons.check,
                               size: 20,color:Colors.green),
                         ),
                         Text('Withdrawal Successful',style: GoogleFonts.poppins(
                             color: Colors.green,
                             fontWeight: FontWeight.w500,
                             fontSize: 15
                         ),),
                         const Spacer(),
                         Text('${refundamount[i]} INR',style: GoogleFonts.poppins(
                           color: Colors.green,
                           fontWeight: FontWeight.w600,

                         ),)
                       ],
                     ),
                   ],
                 ),
               ),
           ],
         ): Column(
               children: [
                 SizedBox(
                            height: MediaQuery.sizeOf(context).height/5,

                          ),
                 const CircularProgressIndicator(
                   color: Colors.white,
                 ),
               ],
             ),

             SizedBox(
              height: MediaQuery.sizeOf(context).height/1.4,
            ),
            // Container(
            //   width: double.infinity,
            //   height:78,
            //   color: const Color(0xFF1c2835),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Container(
            //         height: 70,
            //         width: MediaQuery.sizeOf(context).width/2.5,
            //         decoration: const BoxDecoration(
            //           color: Colors.blue,
            //           borderRadius: BorderRadius.all(Radius.circular(10))
            //         ),
            //         child: Center(
            //           child: Text('DEPOSIT',style: GoogleFonts.poppins(
            //             color: Colors.white,fontWeight: FontWeight.bold,
            //             fontSize: 15
            //           ),),
            //         ),
            //       ),
            //       Container(
            //         height: 70,
            //         width: MediaQuery.sizeOf(context).width/2.5,
            //         decoration: const BoxDecoration(
            //             color: Colors.blue,
            //             borderRadius: BorderRadius.all(Radius.circular(10))
            //         ),
            //         child: Center(
            //           child: Text('WITHDRAW',style: GoogleFonts.poppins(
            //               color: Colors.white,fontWeight: FontWeight.bold,
            //               fontSize: 15
            //           ),),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
