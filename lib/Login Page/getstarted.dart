import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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
            // if(currentIndex!=2)
            //   InkWell(
            //     onTap: () {
            //       moveForward();
            //     },
            //     child: const CircleAvatar(
            //       backgroundColor: CupertinoColors.systemBlue,
            //       radius: 30,
            //       child: Icon(Icons.arrow_forward_rounded, color: Colors.white,),
            //     ),
            //   ),
            if(currentIndex!=6)
              Column(
                children: [
                  Container(
                    child: ElevatedButton(onPressed: (){},
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
                    child: ElevatedButton(onPressed: (){},
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
