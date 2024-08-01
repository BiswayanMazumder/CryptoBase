import 'dart:convert';
import 'package:cryptobase/Currency%20Details%20Pages/currency_details.dart';
import 'package:http/http.dart' as https;
import 'package:cryptobase/Environment%20Files/.env.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MarketDetails extends StatefulWidget {
  const MarketDetails({Key? key}) : super(key: key);

  @override
  State<MarketDetails> createState() => _MarketDetailsState();
}

class _MarketDetailsState extends State<MarketDetails> {
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
  bool datafetched=false;
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
        datafetched = true;
      });
    } else {
      print('Failed to fetch data');
    }
    // print(pricehistory[5]);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchapidetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232f3f),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2835),
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child:const Icon(Icons.arrow_back,color: Colors.white,),
        ),
        centerTitle: true,
        title: Text(
          'CryptoBase',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            for(int i=0;i<name.length;i++)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,bottom: 20),
                    child: InkWell(
                      onTap: () async {
                        // final SharedPreferences prefs = await SharedPreferences.getInstance();
                        final SharedPreferences prefs =
                        await SharedPreferences
                            .getInstance();
                        prefs.setString(
                            'Crypto_Selected', name[i]);
                        prefs.setDouble('Crypto_24h',
                            percentage_24h[i]);
                        // prefs.setInt('Crypto_Price',price[index]);
                        prefs.setString(
                            'Crypto_Symbol', symbols[i]);
                        prefs.setInt(
                            'Crypto_Popu', pops[i]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Currency_Details(
                                    price: price[i].toString(),
                                    high24h:
                                    high_24h[i].toString(),
                                    low_24:
                                    low_24h[i].toString(),
                                    volume: total_volume[i]
                                        .toString(),
                                    pricehistory:
                                    pricehistory[i],
                                    circulating_supply:
                                    circ_supply[i]
                                        .toString(),
                                    market_cap: market_cap[i]
                                        .toString(),
                                    max_supply: max_supply[i]
                                        .toString(),
                                    popularity:
                                    pops[i].toString(),
                                    total_supply:
                                    total_supply[i]
                                        .toString(),
                                  ),
                            ));
                      },
                      child: Row(
                        children: [
                          Text(name[i],style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16
                          ),),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              '\₹${price[i]}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20),
                            child: Container(
                                height: 50,
                                width: 70,
                                decoration: BoxDecoration(
                                  color:
                                  percentage_24h[i] >= 0
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    '${percentage_24h[i].toStringAsFixed(2)}%',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              )
          ],
        ),
      ),
    );
  }
}
