import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class PortFolio extends StatefulWidget {
  const PortFolio({super.key});

  @override
  State<PortFolio> createState() => _PortFolioState();
}

class _PortFolioState extends State<PortFolio> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  String username='';
  Future<void> fetchname() async{
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('User Details').doc(user!.uid).get();
      if (docsnap.exists){
        setState(() {
          username=docsnap.data()?['Name'];
        });
        print('Username ${username}');
      }
    }catch(e){
      print(e);
    }

  }
  int walletbalance = 0;
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
  List <dynamic> paymentamount=[];
  List <dynamic> refundamount=[];
  int paymentsum=0;
  int refundsum=0;
  Future<void> paymentamountfetch() async{
    // await paymentstatusfetch();
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('Payment Amount').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          paymentamount=docsnap.data()?['Amount'];

          // isloaded=true;
        });
        for( int num in paymentamount){
          setState(() {
            paymentsum+=num;
          });
        }
        // print(paymentamount);
        // print(paymentsum);
      }
    }catch(e){
      print(e);
    }

  }
  Future<void> refundamountfetch() async{
    // await paymentstatusfetch();
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('Payment Refund').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          refundamount=docsnap.data()?['Amount'];
          // isloaded=true;
        });
        // print(refundamount);
        for( int num in refundamount){
          setState(() {
            refundsum+=num;
          });
          print(refundamount);
          print(refundsum);
        }
      }
    }catch(e){
      print(e);
    }

  }
  bool isprofit=false;
  int profitloss=0;
  int profitperc=0;
  bool isrefreshing=false;
  void getprofitorloss()async{
    await refundamountfetch();
    await paymentamountfetch();
    print('Payment $paymentsum');
    setState(() {
      profitloss=(refundsum-paymentsum);
      profitperc=((((paymentsum-refundsum)/paymentsum)*100).toInt()).abs();
    });
    print('profit $profitloss');
    print('perc $profitperc');
    if((paymentsum-refundsum)>0){
      setState(() {
        isprofit=true;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchname();
    fetchbalance();
    paymentamountfetch();
    refundamountfetch();
    getprofitorloss();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1c2835),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,top: 80,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text('Welcome Back',style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 18
                  ),),
                ],
              ),
              Row(
                children: [
                  Text(username,style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                // height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFF232f3f),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 20),
                      child: Row(
                        children: [
                          Text('My Wallet',style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                          ),),
                          const Spacer(),
                           Padding(padding: EdgeInsets.only(left: 10),
                           child: Text(isrefreshing?'Refreshing':'Click to Refresh',style: GoogleFonts.poppins(
                             color: Colors.white,
                             fontWeight: FontWeight.w400,
                             fontSize: 12
                           ),),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(right: 20,left: 10),
                             child: InkWell(
                              onTap: (){
                                setState(() {
                                  isrefreshing=true;
                                });
                                try{
                                  fetchbalance();
                                  paymentamountfetch();
                                  refundamountfetch();
                                  getprofitorloss();
                                  setState(() {
                                    isrefreshing=false;
                                  });
                                }catch(e){

                                }
                              },
                                child: const Icon(Icons.refresh,color: Colors.white,)),
                           ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: [
                          Text('$walletbalance INR',style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 30
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 10,bottom: 20),
                      child: Row(
                        children: [
                         isprofit?const Icon(Icons.trending_up,color: Colors.green,):
                         const Icon(Icons.trending_down_rounded,color: Colors.red,),
                          Text(' $profitperc%',style: GoogleFonts.poppins(
                              color:isprofit?Colors.green: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
