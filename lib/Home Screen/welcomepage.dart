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
    );
  }
}
