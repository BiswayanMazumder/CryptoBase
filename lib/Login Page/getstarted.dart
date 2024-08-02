import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobase/Home%20Screen/welcomepage.dart';
import 'package:cryptobase/Login%20Page/emaillogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  List<String> images = [
    'assets/images/crypto_image-removebg-preview.png',
    'assets/images/cartoon-crypto-wallet-w78xVP5-600-removebg-preview.png',
    'assets/images/funny-bitcoin-meme-illustration-style-600nw-1939129615-removebg-preview.png'
  ];
  List<String> heading = [
    'Real-Time Graphs',
    'Wallet Security',
    'Financial Support'
  ];
  List<String> subheading = [
    'Get the real time graph with\nmarket history and info',
    'Secure Online and Offline\nwallets with our security',
    'Take professional financial advice\nfrom our professionals at any time'
  ];

  int currentIndex = 0;
  late PageController _pageController;
  late Timer _timer;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  bool isloading=false;
  void _handleSignIn() async {
    try {
      setState(() {
        isloading=true;
      });
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
        print('Username ${_googleSignIn.currentUser!.displayName}');
        print('Photo ${_googleSignIn.currentUser!.photoUrl}');
        // await _googleSignIn.signOut();
        final User? user = authResult.user;
        if (user != null) {
          print('User UID: ${user.uid}');
          await _firestore.collection('User Details').doc(user.uid).set({
            'Name':_googleSignIn.currentUser!.displayName,
            'Email':_googleSignIn.currentUser!.email,
            'Profile Pic':_googleSignIn.currentUser!.photoUrl!=null?_googleSignIn.currentUser!.photoUrl:'https://plus.unsplash.com/premium_photo-1700268374954-f06052915608?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            'Time Of Registration':FieldValue.serverTimestamp(),
          });
          setState(() {
            isloading=false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
        }
        // Now the user should appear in Firebase Authentication
      } else {
        // User cancelled sign-in
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
        _pageController.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget buildBullet(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == currentIndex ? Colors.white : Colors.white.withOpacity(0.5),
      ),
    );
  }

  void moveForward() {
    setState(() {
      currentIndex = (currentIndex + 1) % images.length;
      _pageController.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232f3f),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300, // Adjust the height as needed
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                          }
                          return Center(
                            child: SizedBox(
                              width: Curves.easeInOut.transform(value) * MediaQuery.of(context).size.width,
                              height: Curves.easeInOut.transform(value) * 300,
                              child: child,
                            ),
                          );
                        },
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  // Positioned(
                  //   bottom: 16.0,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: List.generate(
                  //       images.length,
                  //           (index) => buildBullet(index),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              heading[currentIndex],
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            Text(
              subheading[currentIndex],
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            if(currentIndex!=2)
              InkWell(
                onTap: () {
                  moveForward();
                },
                child: const CircleAvatar(
                  backgroundColor: CupertinoColors.systemBlue,
                  radius: 30,
                  child: Icon(Icons.arrow_forward_rounded, color: Colors.white,),
                ),
              ),
            if(currentIndex==2)
              Column(
                children: [
                  Container(
                    child: ElevatedButton(onPressed: (){
                      _handleSignIn();
                    },
                        style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(5),
                            shadowColor: MaterialStatePropertyAll(Colors.black),
                            backgroundColor: MaterialStatePropertyAll(CupertinoColors.systemBlue)
                        ),
                        child:  Text('Continue with Google',style:  GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ElevatedButton(onPressed: (){},
                        style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(5),
                            shadowColor: MaterialStatePropertyAll(Colors.black),
                            backgroundColor: MaterialStatePropertyAll(CupertinoColors.systemBlue)
                        ),
                        child:  Text('Continue with Apple',style:  GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,width:0.5,),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EmailLogin(),));
                    },
                        style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(0),
                            backgroundColor: MaterialStatePropertyAll(Colors.transparent)
                        ),
                        child:  Text('Continue with Email',style:  GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),)),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
