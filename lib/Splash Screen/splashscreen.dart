import 'package:cryptobase/Home%20Screen/welcomepage.dart';
import 'package:cryptobase/Login%20Page/getstarted.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth=FirebaseAuth.instance;
    final user=_auth.currentUser;
    return EasySplashScreen(
      logo: Image(image: AssetImage('assets/images/crypto_image-removebg-preview.png')),
      title: Text(
        "CrptoBase",
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color(0xFF232f3f),
      showLoader: true,
      loadingText: Text("Loading...",style: GoogleFonts.poppins(
        color: Colors.white
      ),),
      navigator: user!=null?WelcomeScreen():GetStarted(),
      durationInSeconds: 5,
    );
  }
}