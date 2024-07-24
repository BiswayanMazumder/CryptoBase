import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232f3f),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2835),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text('CryptoBase',style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17
        ),),
        actions: const[
           Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.currency_rupee_sharp,color: Colors.white,),
          )
        ],
        leading: const InkWell(
          child: Icon(Icons.person_add_alt_rounded,color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      height: 190,
                      width: MediaQuery.sizeOf(context).width-70,
                      decoration:  BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('Confused about\ncrypto taxes?',style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                                ),),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Simplify your taxes\nwith '),
                                      TextSpan(
                                        text: 'TaxNodes',
                                        style: TextStyle(color: Colors.yellow),
                                      ),
                                      TextSpan(text: '!'),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Get a ₹200 coupon\non sign-up',style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              ],
                            ),
                            const Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/cryptoba'
                                'se-admin.appspot.com/o/Home%20Screen%20Card%20Images%2Fpngtree-smiling-woma'
                                'n-counting-money-banknotes-png-image_8792772-removebg-preview.png?alt=medi'
                                'a&token=78242793-6f0f-4085-8460-efe7acc5eaeb'))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20), // Adding space between boxes
                    Container(
                      height: 190,
                      width: MediaQuery.sizeOf(context).width-70,
                      decoration:  BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('Confused about\ncrypto?',style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                ),),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Simplify your gyaan\nwith '),
                                      TextSpan(
                                        text: 'CryptoNews',
                                        style: TextStyle(color: Colors.yellow),
                                      ),
                                      TextSpan(text: '!'),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Click to get news!',style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              ],
                            ),
                            const Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/c'
                                'ryptobase-admin.appspot.com/o/Home%20Screen%20Card%20Images%2Fimages-rem'
                                'ovebg-preview.png?alt=media&token=7a41982e-dd9e-416f-80ee-3d1d91a23c0c',
                            ),width: 160,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20), // Adding space between boxes
                    // Container(
                    //   height: 160,
                    //   width: MediaQuery.sizeOf(context).width-70,
                    //   decoration: const BoxDecoration(
                    //     color: Colors.blue,
                    //     borderRadius: BorderRadius.all(Radius.circular(8)),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: const BoxDecoration(color: const Color(0xFF1c2835),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child:  Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.wallet,color: Colors.blue,),),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text('Deposit INR',style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        child: Icon(Icons.arrow_forward,color: Colors.blue,),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
