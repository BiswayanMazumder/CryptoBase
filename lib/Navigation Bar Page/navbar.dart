import 'package:cryptobase/Deposit%20INR/deposithome.dart';
import 'package:cryptobase/Home%20Screen/welcomepage.dart';
import 'package:cryptobase/PortFolio/userportfolio.dart';
import 'package:cryptobase/Profile%20Page/Your%20Account%20Page/account_homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  // final _controller = NotchBottomBarController(index: 0);

  int _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  final List screens=[
    WelcomeScreen(),
    DepositHome(),
    PortFolio(),
    AccountHomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      backgroundColor: const Color(0xFF232f3f),

      bottomNavigationBar: GNav(
          haptic: true,
          curve: Curves.bounceInOut,
          rippleColor: Colors.yellow,
          tabActiveBorder: Border.all(color: Colors.green,
              style: BorderStyle.solid),
          hoverColor: Colors.white,
          activeColor: Colors.black,
          color: Colors.deepPurpleAccent,
          // rippleColor: Colors.green,
          tabBackgroundColor: Colors.green,
          selectedIndex: _index,
          // tabBorder: Border.all(color: Colors.red),
          gap: 1,
          onTabChange: (value){
            setState(() {
              _index=value;
            });
          },
          tabs: const [
            GButton(icon: Icons.home,
              text: 'HomePage',
              rippleColor: Colors.green,
              backgroundColor: Colors.cyan,
            ),
            GButton(icon: Icons.money,text: 'Wallet',
              backgroundColor: Colors.lightGreenAccent,
            ),
            GButton(icon: Icons.attach_money_outlined,text: 'Portfolio',
              backgroundColor: Colors.yellowAccent,
            ),
            GButton(icon: Icons.person,text: 'Profile',
              backgroundColor: Colors.deepOrangeAccent,
              haptic: true,
              debug: true,
            ),
          ]
      ),
    );
  }
}
