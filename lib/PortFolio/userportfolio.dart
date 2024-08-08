import 'dart:convert';
import 'package:cryptobase/Currency%20Details%20Pages/currency_details.dart';
import 'package:cryptobase/Money%20Options/currencypage.dart';
import 'package:http/http.dart' as https;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobase/Environment%20Files/.env.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortFolio extends StatefulWidget {
  const PortFolio({super.key});

  @override
  State<PortFolio> createState() => _PortFolioState();
}

class _PortFolioState extends State<PortFolio> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String username = '';
  Future<void> fetchname() async {
    final user = _auth.currentUser;
    try {
      final docsnap =
          await _firestore.collection('User Details').doc(user!.uid).get();
      if (docsnap.exists) {
        setState(() {
          username = docsnap.data()?['Name'];
        });
        if (kDebugMode) {
          print('Username $username');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
      if (kDebugMode) {
        print(e);
      }
    }
  }

  List<dynamic> paymentamount = [];
  List<dynamic> refundamount = [];
  int paymentsum = 0;
  int refundsum = 0;
  Future<void> paymentamountfetch() async {
    // await paymentstatusfetch();
    final user = _auth.currentUser;
    try {
      final docsnap =
          await _firestore.collection('Payment Amount').doc(user!.uid).get();
      if (docsnap.exists) {
        setState(() {
          paymentamount = docsnap.data()?['Amount'];

          // isloaded=true;
        });
        for (int num in paymentamount) {
          setState(() {
            paymentsum += num;
          });
        }
        // print(paymentamount);
        // print(paymentsum);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> refundamountfetch() async {
    // await paymentstatusfetch();
    final user = _auth.currentUser;
    try {
      final docsnap =
          await _firestore.collection('Payment Refund').doc(user!.uid).get();
      if (docsnap.exists) {
        setState(() {
          refundamount = docsnap.data()?['Amount'];
          // isloaded=true;
        });
        // print(refundamount);
        for (int num in refundamount) {
          setState(() {
            refundsum += num;
          });
          if (kDebugMode) {
            print(refundamount);
          }
          if (kDebugMode) {
            print(refundsum);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  bool isprofit = false;
  int profitloss = 0;
  int profitperc = 0;
  bool isrefreshing = false;
  void getprofitorloss() async {
    await refundamountfetch();
    await paymentamountfetch();
    if (kDebugMode) {
      print('Payment $paymentsum');
    }
    setState(() {
      profitloss = (refundsum - paymentsum);
      profitperc =
          ((((paymentsum - refundsum) / paymentsum) * 100).toInt()).abs();
    });
    if (kDebugMode) {
      print('profit $profitloss');
    }
    if (kDebugMode) {
      print('perc $profitperc');
    }
    if ((paymentsum - refundsum) > 0) {
      setState(() {
        isprofit = true;
      });
    }
  }

  List<dynamic> portfolioname = [];
  List<dynamic> portfoliovolume = [];
  Future<void> portfoliocurrencyfetch() async {
    // await paymentstatusfetch();
    final user = _auth.currentUser;
    try {
      final docsnap = await _firestore
          .collection('Portfolio Currency')
          .doc(user!.uid)
          .get();
      if (docsnap.exists) {
        setState(() {
          portfolioname = docsnap.data()?['Currency'];

          // isloaded=true;
        });
        if (kDebugMode) {
          print(portfolioname);
        }
        // print(paymentsum);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> portfoliovolumefetch() async {
    // await paymentstatusfetch();
    final user = _auth.currentUser;
    try {
      final docsnap = await _firestore
          .collection('Portfolio Currency Volume')
          .doc(user!.uid)
          .get();
      if (docsnap.exists) {
        setState(() {
          portfoliovolume = docsnap.data()?['Currency'];

          // isloaded=true;
        });
        if (kDebugMode) {
          print(portfoliovolume);
        }
        // print(paymentsum);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  List<dynamic> name = [];
  List<dynamic> images = [];
  List<dynamic> price = [];
  List<dynamic> percentage_24h = [];
  List<dynamic> symbols = [];
  List<dynamic> pops = [];
  List<dynamic> high_24h = [];
  List<dynamic> low_24h = [];
  List<dynamic> total_volume = [];
  List<dynamic> pricehistory = [];
  List<dynamic> market_cap = [];
  List<dynamic> circ_supply = [];
  List<dynamic> max_supply = [];
  List<dynamic> total_supply = [];
  List<dynamic> commonindexes = [];
  Future<void> fetchapidetails() async {
    final response = await https.get(Uri.parse(Environment.API_ENDPOINT));
    if (response.statusCode == 200) {
      List<dynamic> coins = json.decode(response.body);

      // Extract names from each coin object
      List<dynamic> names = coins.map((coin) => coin['name']).toList();
      List<dynamic> image = coins.map((coin) => coin['image']).toList();
      List<dynamic> prices =
          coins.map((coin) => coin['current_price']).toList();
      List<dynamic> perc_change =
          coins.map((coin) => coin['price_change_percentage_24h']).toList();
      List<dynamic> symbol = coins.map((coin) => coin["symbol"]).toList();
      List<dynamic> popularity =
          coins.map((coin) => coin['market_cap_rank']).toList();
      List<dynamic> volume = coins.map((coin) => coin["total_volume"]).toList();
      List<dynamic> High24h = coins.map((coin) => coin['high_24h']).toList();
      List<dynamic> Low24h = coins.map((coin) => coin['low_24h']).toList();
      List<dynamic> market_capital =
          coins.map((coin) => coin['market_cap']).toList();
      List<dynamic> Circulation_supply =
          coins.map((coin) => coin["circulating_supply"]).toList();
      List<dynamic> pricesFlattened =
          coins.map((coin) => coin['sparkline_in_7d']['price']).toList();
      List<dynamic> Max_Supply =
          coins.map((coin) => coin["max_supply"]).toList();
      List<dynamic> Total_Supply =
          coins.map((coin) => coin['total_supply']).toList();
      // Update the state with the fetched data
      setState(() {
        name = names;
        price = prices;
        percentage_24h = perc_change;
        images = image;
        symbols = symbol;
        pops = popularity;
        total_volume = volume;
        high_24h = High24h;
        low_24h = Low24h;
        pricehistory = pricesFlattened;
        market_cap = market_capital;
        circ_supply = Circulation_supply;
        max_supply = Max_Supply;
        total_supply = Total_Supply;
      });
      await portfoliocurrencyfetch();
      List<dynamic> originalnames = [];
      for (int i = 0; i < portfolioname.length; i++) {
        originalnames.add(portfolioname[i].toString().toLowerCase());
      }

      for (int i = 0; i < originalnames.length; i++) {
        for (int j = 0; j < symbols.length; j++) {
          if (originalnames[i] == symbols[j]) {
            commonindexes.add(j);
          }
        }
      }
      if (kDebugMode) {
        print(commonindexes);
        print(symbols);
      }
    } else {
      if (kDebugMode) {
        print('Failed to fetch data');
      }
    }
    // print(pricehistory[5]);
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
    portfoliocurrencyfetch();
    portfoliovolumefetch();
    fetchapidetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1c2835),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 80, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    username,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Row(
                        children: [
                          Text(
                            'My Wallet',
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              isrefreshing ? 'Refreshing' : 'Click to Refresh',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 10),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isrefreshing = true;
                                  });
                                  try {
                                    fetchbalance();
                                    paymentamountfetch();
                                    refundamountfetch();
                                    getprofitorloss();
                                    setState(() {
                                      isrefreshing = false;
                                    });
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print(e);
                                    }
                                  }
                                },
                                child: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: [
                          Text(
                            '$walletbalance INR',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 20),
                      child: Row(
                        children: [
                          isprofit
                              ? const Icon(
                                  Icons.trending_up,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.trending_down_rounded,
                                  color: Colors.red,
                                ),
                          Text(
                            ' $profitperc%',
                            style: GoogleFonts.poppins(
                                color: isprofit ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'MY WALLET',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              for (int num in commonindexes)
                InkWell(
                  // onTap: (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) =>Currency_Details(
                  //       price: price[num].toString(),
                  //       high24h: high_24h[num].toString(),
                  //       low_24: low_24h[num].toString(),
                  //       volume: total_volume[num].toString(),
                  //       pricehistory: pricehistory[num],
                  //       total_supply: total_supply[num].toString(),
                  //       max_supply: max_supply[num].toString(),
                  //       market_cap: market_cap[num].toString(),
                  //       popularity: pops[num].toString(),
                  //       circulating_supply: circ_supply[num].toString()
                  //   ),));
                  // },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20, bottom: 40),
                            child: Image(
                              image: NetworkImage(images[num]),
                              height: 50,
                              width: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Text(
                              '${name[num]}\n${symbols[num].toString().toUpperCase()}',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40,right: 10),
                            child: Icon(percentage_24h[num]>0? Icons.trending_up:Icons.trending_down,
                            color: percentage_24h[num]>0?Colors.green:Colors.red,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40,right: 10),
                            child: Text(
                              '${(percentage_24h[num]).abs()}%',
                              style: GoogleFonts.poppins(
                                  color:percentage_24h[num]>0? Colors.green:Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                          ),
                        ],
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
