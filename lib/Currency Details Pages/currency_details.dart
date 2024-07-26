import 'package:cryptobase/Money%20Options/currencypage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Currency_Details extends StatefulWidget {
  final String price;
  final String low_24;
  final String high24h;
  final String volume;
  const Currency_Details({Key? key, required this.price,required this.high24h,required this.low_24,required this.volume});

  @override
  State<Currency_Details> createState() => _Currency_DetailsState();
}

class _Currency_DetailsState extends State<Currency_Details> {
  String currency = '';
  String? cryptoname='';
  int? Cryptoprice;
  double? percentage_24h;
  Icon currencyicon = Icon(Icons.currency_rupee, color: Colors.white);
  bool datafetched=false;
  Future<void> readfetcheddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? counter = prefs.getString('selected_currency_name');
    final String? CryptoName = prefs.getString('Crypto_Symbol');
    final double? percchange=prefs.getDouble('Crypto_24h');
    final int? cryptoprice=prefs.getInt('Crypto_Price');
    if (counter != null) {
      setState(() {
        cryptoname=CryptoName;
        currency = counter;
        percentage_24h=percchange;
        Cryptoprice=cryptoprice;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setcurrencyicon();
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
              decoration: const BoxDecoration(

              ),
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
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child:const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration:const BoxDecoration(
                          color: Color(0xFFF232F3F),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('${cryptoname.toString().toUpperCase()} / ${currency}',style:
                              GoogleFonts.poppins(color: Colors.grey,fontWeight: FontWeight.w500,
                              fontSize: 12
                              ),),
                            ),

                          ],
                        ),
                      ),
                      ),
                      InkWell(
                        child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.star_border_purple500_sharp,color: Colors.yellow,)),
                      ),
                      const Spacer(),
                      Padding(
                        padding:  EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: percentage_24h!>=0?Colors.green:Colors.red,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child:  Center(
                                  child: Text(
                                    '${percentage_24h?.toStringAsFixed(2)}%',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                            ),
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
                        Text('Vol: ${widget.volume}',style: GoogleFonts.poppins(
                          color: Colors.grey,
                            fontSize: 12,
                          fontWeight: FontWeight.w600
                        ),),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text('High: ${(widget.high24h)}',style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text('Low: ${widget.low_24}',style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 550,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(color: const Color(0xFF1c2835),),
            )
          ],
        ),
      ),
    );
  }
}
