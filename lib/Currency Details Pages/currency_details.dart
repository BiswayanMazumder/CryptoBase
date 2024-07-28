import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobase/Money%20Options/currencypage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Currency_Details extends StatefulWidget {
  final String price;
  final String low_24;
  final String high24h;
  final String volume;
  final String market_cap;
  final String circulating_supply;
  final String max_supply;
  final String total_supply;
  final String popularity;
  final List<dynamic> pricehistory; // Ensure the type is dynamic
  const Currency_Details(
      {Key? key,
        required this.price,
        required this.high24h,
        required this.low_24,
        required this.volume,
        required this.pricehistory,
        required this.total_supply,
        required this.max_supply,
        required this.market_cap,
        required this.popularity,
        required this.circulating_supply
      });

  @override
  State<Currency_Details> createState() => _Currency_DetailsState();
}

class _Currency_DetailsState extends State<Currency_Details> {
  String currency = '';
  String? cryptoname = '';
  bool isliked = false;
  int? Cryptoprice;
  double? percentage_24h;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Icon currencyicon = Icon(Icons.currency_rupee, color: Colors.white);
  bool datafetched = false;
  Future<void> readfetcheddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? counter = prefs.getString('selected_currency_name');
    final String? CryptoName = prefs.getString('Crypto_Symbol');
    final double? percchange = prefs.getDouble('Crypto_24h');
    final int? cryptoprice = prefs.getInt('Crypto_Price');
    // print(widget.pricehistory);
    if (counter != null) {
      setState(() {
        cryptoname = CryptoName;
        currency = counter;
        percentage_24h = percchange;
        Cryptoprice = cryptoprice;
      });
    }
  }

  void setcurrencyicon() async {
    await readfetcheddata();
    setState(() {
      if (currency == 'USDT')
        currencyicon = Icon(Icons.currency_lira, color: Colors.white);
      else if (currency == 'INR')
        currencyicon = Icon(Icons.currency_rupee, color: Colors.white);
      else if (currency == 'BTC')
        currencyicon = Icon(Icons.currency_bitcoin, color: Colors.white);
      else if (currency == 'IDR')
        currencyicon = Icon(Icons.currency_yen_rounded, color: Colors.white);
      else if (currency == 'SAR')
        currencyicon = Icon(Icons.currency_exchange, color: Colors.white);
      else if (currency == 'UAH')
        currencyicon = Icon(Icons.currency_yuan_sharp, color: Colors.white);
      else if (currency == 'NGN')
        currencyicon = Icon(Icons.currency_franc, color: Colors.white);
      else if (currency == 'RUB')
        currencyicon = Icon(Icons.currency_ruble_sharp, color: Colors.white);
      else if (currency == 'EUR')
        currencyicon = Icon(Icons.currency_pound, color: Colors.white);
    });
  }
  List _timestamp=[];
  bool isloaded=false;
  Future<void> _generateTimestamps() async {
    await Future.delayed(Duration(seconds: 1));
    final List<String> timestamps = [];
    final now = DateTime.now();

    for (int i = 0; i < 20 ;i++) {
      final timestamp = now.subtract(Duration(seconds: i)).toLocal();
      final formattedTimestamp = '${timestamp.hour}:${timestamp.minute}:${timestamp.second}';
      timestamps.add(formattedTimestamp);
    }

    setState(() {
      _timestamp = timestamps;
      isloaded=true;
    });
  }
  bool isfavourite=false;
  Future<void> favouriteactions()async{
    await readfetcheddata();
    setState(() {
      isfavourite=!isfavourite;
    });
    final user=_auth.currentUser;
    if(isfavourite){
      await _firestore.collection('Favourite Currencies').doc(user!.uid).set(
          {
            'Currency':FieldValue.arrayUnion([
              cryptoname.toString().toUpperCase(),
            ])
          }, SetOptions(merge: true));
    }
    if(!isfavourite){
      await _firestore.collection('Favourite Currencies').doc(user!.uid).update({
        'Currency':FieldValue.arrayRemove(
          [
            cryptoname.toString().toUpperCase()
          ]
        )
      });
    }
  }
  List<dynamic> getlikedcurrency=[];
  Future<void> fetchlikedcurrencies()async{
    final user=_auth.currentUser;
    await readfetcheddata();
    try{
      final docsnap=await _firestore.collection('Favourite Currencies').doc(user!.uid).get();
      if(docsnap.exists){
        setState(() {
          getlikedcurrency=docsnap.data()?['Currency'];
        });
      }
      if(getlikedcurrency.contains(cryptoname.toString().toUpperCase())){
        setState(() {
          isfavourite=true;
        });
      }
      else{
        setState(() {
          isfavourite=false;
        });
      }
      print(getlikedcurrency);
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setcurrencyicon();
    _generateTimestamps();
    fetchlikedcurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232f3f),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () {
                            // print(widget.pricehistory.length);
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: const BoxDecoration(
                                color: Color(0xFFF232F3F),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    '${cryptoname.toString().toUpperCase()} / ${currency}',
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          favouriteactions();
                        },
                        child: Icon(isfavourite?CupertinoIcons.star_fill:CupertinoIcons.star,
                          color: Colors.yellow,size: 15,),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: percentage_24h! >= 0
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    '${percentage_24h?.toStringAsFixed(2)}%',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                '₹${widget.price}',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          'Vol: ${(int.parse((widget.volume)) / 1000000000).toStringAsFixed(2)}B',
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            'High: ₹${(widget.high24h)}',
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            'Low: ₹${widget.low_24}',
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                color: const Color(0xFF1c2835),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Time',
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Price',
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 20),
                        child: Text(
                          'Volume',
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isloaded)
                    for (int i = 0; i < 20; i++) // Iterate up to pricehistory.length - 1
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.sizeOf(context).width,
                              color: (widget.pricehistory[i] is num && widget.pricehistory[i + 1] is num) && (widget.pricehistory[i] > widget.pricehistory[i + 1])
                                  ? Colors.green.withOpacity(0.3)
                                  : Colors.red.withOpacity(0.3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      _timestamp[i],
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(),
                                        child: Text(
                                          widget.pricehistory[i].toString(),
                                          style: GoogleFonts.poppins(
                                              color: (widget.pricehistory[i] is num && widget.pricehistory[i + 1] is num && widget.pricehistory[i] > widget.pricehistory[i + 1])
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: (widget.pricehistory[i] is num && widget.pricehistory[i + 1] is num && widget.pricehistory[i] > widget.pricehistory[i + 1])
                                            ? Icon(Icons.arrow_upward, color: Colors.green)
                                            : Icon(Icons.arrow_downward, color: Colors.red),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      '${(int.parse((widget.volume)) / 1000000000).toStringAsFixed(2)}B',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  if (!isloaded)
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  isloaded?Padding(
                    padding: const EdgeInsets.only(right:1),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                          child: Text('STATS',style: GoogleFonts.poppins(color: Colors.grey,fontWeight: FontWeight.w500,),),
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 2,left: 5),
                            child: Icon(CupertinoIcons.info,color: Colors.grey,size: 15,),
                          ),
                        )
                      ],
                    ),
                  ):Container(),
                  isloaded?Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: const Color(0xFF232f3f)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 20,top: 20),
                            child: Row(
                              children: [
                                Text('Market Cap',style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500
                                ),),
                                const Spacer(),
                                Text('₹${(int.parse(widget.market_cap)/1000000000).toStringAsFixed(2)}B',style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 20,top: 20),
                            child: Row(
                              children: [
                                Text('Circulating Supply',style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500
                                ),),
                                const Spacer(),
                                Text('₹${widget.circulating_supply}',style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 20,top: 20),
                            child: Row(
                              children: [
                                Text('Max Supply',style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500
                                ),),
                                const Spacer(),
                                Text('₹${widget.max_supply}B',style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 20,top: 20),
                            child: Row(
                              children: [
                                Text('Total Supply',style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500
                                ),),
                                const Spacer(),
                                Text('₹${widget.total_supply}B',style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                ),),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 20,top: 20),
                            child: Row(
                              children: [
                                Text('Popularity',style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500
                                ),),
                                const Spacer(),
                                Text('#${widget.popularity}',style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ):Container(),
                  const SizedBox(
                    height: 20,
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
