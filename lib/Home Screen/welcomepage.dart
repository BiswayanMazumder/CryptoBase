import 'dart:convert';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobase/Blogs%20Page/HelpPage.dart';
import 'package:cryptobase/Currency%20Details%20Pages/currency_details.dart';
import 'package:cryptobase/Currency%20Details%20Pages/seeallmarketdetails.dart';
import 'package:cryptobase/Deposit%20INR/deposithome.dart';
import 'package:cryptobase/Environment%20Files/.env.dart';
import 'package:cryptobase/Login%20Page/getstarted.dart';
import 'package:cryptobase/Money%20Options/currencypage.dart';
import 'package:cryptobase/News%20Pages/news_homepage.dart';
import 'package:cryptobase/Profile%20Page/Your%20Account%20Page/account_homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vibration/vibration.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String currency = '';
  Icon currencyicon = Icon(Icons.currency_rupee, color: Colors.white);
  bool datafetched = false;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<void> readfetcheddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? counter = prefs.getString('selected_currency_name');
    if (counter != null) {
      setState(() {
        currency = counter;
      });
    } else {
      prefs.setString('selected_currency_name', 'INR');
    }
  }

  void _vibrate() {
    if (Vibration.hasVibrator() != null) {
      Vibration.vibrate(duration: 1000); // Vibrate for 1 second
    }
  }

  void setcurrencyicon() async {
    await readfetcheddata();
    setState(() {
      if (currency == 'USDT') {
        currencyicon = Icon(Icons.currency_lira, color: Colors.white);
      } else if (currency == 'INR')
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
  void generatenotifications()async{
    await fetchname();
    await fetchapidetails();
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true
    );
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10, // Unique ID for the notification
        channelKey: 'basic_channel', // The channel where the notification will be sent
        title: 'Hello ${username}',
        body: 'Indian markets are likely to open on a positive note,tracking global cues.\n'
            '• ${name[0]} : ${price[0]}\n'
            '• ${name[1]} : ${price[1]}\n'
            '• ${name[2]} : ${price[2]}\n',
        notificationLayout: NotificationLayout.Messaging,
      ),
    );
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
  String username='';
  Future<void> fetchname() async{
    final user=_auth.currentUser;
    try{
      final docsnap=await _firestore.collection('User Details').doc(user!.uid).get();
      if (docsnap.exists){
        setState(() {
          username=docsnap.data()?['Name'];
        });
        print('Username ${username}');
      }
    }catch(e){
      print(e);
    }

  }
  String walletaddress='';
  Future<void> generatewalletaddress()async{
    final random = Random();
    final tenDigitNumber = 10000 + random.nextInt(90000);
    setState(() {
      walletaddress='CB$tenDigitNumber';
    });
    print('CB$tenDigitNumber');
  }
  Future<void> recordlogintimes()async{
    try{
      final user=_auth.currentUser;
      await _firestore.collection('Login Records').doc(user!.uid).set({
        'Login Time':FieldValue.arrayUnion([DateTime.now()])
      },SetOptions(merge: true));
    }catch(e){
      print(e);
    }
  }
  Future<void> storewalletaddress()async{
    final user=_auth.currentUser;
    final docsnap=await _firestore.collection('Wallet ID').doc(user!.uid).get();
    if(docsnap.exists){
      setState(() {
        walletaddress=docsnap.data()?['Wallet Address'];
      });
      print('address fetched');
    }else{
      await generatewalletaddress();
      await _firestore.collection('Wallet ID').doc(user!.uid).set({
        'Wallet Address':walletaddress
      },SetOptions(merge: true));
      await _firestore.collection('All IDs').doc('Wallet IDs').set({
        'Wallet Address':FieldValue.arrayUnion([walletaddress])
      },SetOptions(merge: true));
      print('address written');
    }
  }
  @override
  void initState() {
    super.initState();
    readfetcheddata();
    setcurrencyicon();
    fetchapidetails();
    fetchname();
    storewalletaddress();
    generatenotifications();
    recordlogintimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232f3f),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2835),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'CryptoBase',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                // generatenotifications();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrencyPage(),
                  ),
                );
              },
              child: currencyicon,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 10),
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => AccountHomePage(),
          //         ),
          //       );
          //     },
          //     child:const Icon(Icons.person,color: Colors.white,),
          //   ),
          // ),
        ],
        leading:  InkWell(
          onTap: ()async{
            try{
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              _auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStarted(),));
            }catch(e){

            }
          },
          child: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0,left: 20),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Welcome Back '),
                        TextSpan(
                          text: username,
                          style: GoogleFonts.poppins(
                              color: Colors.yellow),
                        ),
                        const TextSpan(text: '!'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        // generatewalletaddress();
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => const HelpSection(),));
                      },
                      child: Container(
                        height: 190,
                        width: MediaQuery.sizeOf(context).width - 70,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Confused about\ncrypto taxes?',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
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
                                        const TextSpan(
                                            text: 'Simplify your taxes\nwith '),
                                        TextSpan(
                                          text: 'Agents',
                                          style: GoogleFonts.poppins(
                                              color: Colors.yellow),
                                        ),
                                        const TextSpan(text: '!'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Get a ₹200 coupon\non sign-up',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const Image(
                                image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/cryptoba'
                                  'se-admin.appspot.com/o/Home%20Screen%20Card%20Images%2Fpngtree-smiling-woma'
                                  'n-counting-money-banknotes-png-image_8792772-removebg-preview.png?alt=medi'
                                  'a&token=78242793-6f0f-4085-8460-efe7acc5eaeb',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20), // Adding space between boxes
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => News_HomePage(),));
                      },
                      child: Container(
                        height: 190,
                        width: MediaQuery.sizeOf(context).width - 70,
                        decoration: BoxDecoration(
                          color: Colors.green.shade700,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Confused about\nbusiness?',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
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
                                        TextSpan(
                                            text: 'Simplify your gyaan\nwith '),
                                        TextSpan(
                                          text: 'News',
                                          style: GoogleFonts.poppins(
                                              color: Colors.yellow),
                                        ),
                                        TextSpan(text: '!'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Click to get news!',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const Image(
                                image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/c'
                                  'ryptobase-admin.appspot.com/o/Home%20Screen%20Card%20Images%2Fimages-rem'
                                  'ovebg-preview.png?alt=media&token=7a41982e-dd9e-416f-80ee-3d1d91a23c0c',
                                ),
                                width: 160,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20), // Adding space between boxes
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepositHome(),));
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1c2835),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.wallet,
                          color: Colors.blue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Deposit INR',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: InkWell(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Most Active',
                    style: GoogleFonts.poppins(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Based on traded values and price variations',
                    style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            datafetched
                ? Container(
                    height: 150, // Set the height of the ListView
                    child: ListView.builder(
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: InkWell(
                            onTap: () async {
                              // print(name[index]);
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('Crypto_Selected', name[index]);
                              prefs.setDouble(
                                  'Crypto_24h', percentage_24h[index]);
                              // prefs.setInt('Crypto_Price',price[index]);
                              prefs.setString('Crypto_Symbol', symbols[index]);
                              prefs.setInt('Crypto_Popu', pops[index]);
                              // Vibration.vibrate(duration: 1000);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Currency_Details(
                                      price: price[index].toString(),
                                      high24h: high_24h[index].toString(),
                                      pricehistory: pricehistory[index],
                                      low_24: low_24h[index].toString(),
                                      volume: total_volume[index].toString(),
                                      circulating_supply:
                                          circ_supply[index].toString(),
                                      market_cap: market_cap[index].toString(),
                                      max_supply: max_supply[index].toString(),
                                      popularity: pops[index].toString(),
                                      total_supply:
                                          total_supply[index].toString(),
                                    ),
                                  ));
                            },
                            child: Container(
                              height: 200,
                              width: 300,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1c2835),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 10),
                                        child: Text(
                                          name[index],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 20),
                                        child: Image(
                                          image: NetworkImage(images[index]),
                                          height: 50,
                                          width: 80,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 10),
                                        child: Text(
                                          '\₹${price[index]}',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 15),
                                        child: Text(
                                          '${percentage_24h[index]}%',
                                          style: GoogleFonts.poppins(
                                            color: percentage_24h[index] >= 0
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: percentage_24h[index] >= 0
                                            ? Icon(
                                                Icons.arrow_drop_up,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.red,
                                              ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'New Listing',
                    style: GoogleFonts.poppins(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey.shade900,
                      child: Text(
                        '3',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Market launches in the last 15 days',
                    style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            datafetched
                ? Container(
                    height: 150, // Set the height of the ListView
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        index += 8;
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: InkWell(
                            onTap: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('Crypto_Selected', name[index]);
                              prefs.setDouble(
                                  'Crypto_24h', percentage_24h[index]);
                              // prefs.setInt('Crypto_Price',price[index]);
                              prefs.setString('Crypto_Symbol', symbols[index]);
                              prefs.setInt('Crypto_Popu', pops[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Currency_Details(
                                      price: price[index].toString(),
                                      high24h: high_24h[index].toString(),
                                      low_24: low_24h[index].toString(),
                                      volume: total_volume[index].toString(),
                                      pricehistory: pricehistory[index],
                                      circulating_supply:
                                          circ_supply[index].toString(),
                                      market_cap: market_cap[index].toString(),
                                      max_supply: max_supply[index].toString(),
                                      popularity: pops[index].toString(),
                                      total_supply:
                                          total_supply[index].toString(),
                                    ),
                                  ));
                            },
                            child: Container(
                              height: 200,
                              width: 300,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1c2835),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 10),
                                        child: Text(
                                          name[index],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 20),
                                        child: Image(
                                          image: NetworkImage(images[index]),
                                          height: 50,
                                          width: 80,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 10),
                                        child: Text(
                                          '\₹${price[index]}',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 15),
                                        child: Text(
                                          '${percentage_24h[index]}%',
                                          style: GoogleFonts.poppins(
                                            color: percentage_24h[index] >= 0
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: percentage_24h[index] >= 0
                                            ? Icon(
                                                Icons.arrow_drop_up,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.red,
                                              ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : CircularProgressIndicator(
                    color: Colors.white,
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Market',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.only(right: 35),
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MarketDetails(),));
                    },
                    child: Text(
                      'See all',
                      style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  )),
            ]),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                // height: 750,
                decoration: const BoxDecoration(
                  color: Color(0xFF1c2835),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Row(
                          children: [
                            Text(
                              'Trending Pairs',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                'Price',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              '24h change%',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 10),
                    datafetched
                        ? ListView.builder(
                            shrinkWrap:
                                true, // Ensure ListView takes only the space it needs
                            itemCount: 8, // Replace with your itemCount
                            itemBuilder: (context, index) {
                              index+=10;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: InkWell(
                                      onTap: () async {
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            'Crypto_Selected', name[index]);
                                        prefs.setDouble('Crypto_24h',
                                            percentage_24h[index]);
                                        // prefs.setInt('Crypto_Price',price[index]);
                                        prefs.setString(
                                            'Crypto_Symbol', symbols[index]);
                                        prefs.setInt(
                                            'Crypto_Popu', pops[index]);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Currency_Details(
                                                price: price[index].toString(),
                                                high24h:
                                                    high_24h[index].toString(),
                                                low_24:
                                                    low_24h[index].toString(),
                                                volume: total_volume[index]
                                                    .toString(),
                                                pricehistory:
                                                    pricehistory[index],
                                                circulating_supply:
                                                    circ_supply[index]
                                                        .toString(),
                                                market_cap: market_cap[index]
                                                    .toString(),
                                                max_supply: max_supply[index]
                                                    .toString(),
                                                popularity:
                                                    pops[index].toString(),
                                                total_supply:
                                                    total_supply[index]
                                                        .toString(),
                                              ),
                                            ));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            '${name[index]}',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: Text(
                                              '\₹${price[index]}',
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
                                                      percentage_24h[index] >= 0
                                                          ? Colors.green
                                                          : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${percentage_24h[index].toStringAsFixed(2)}%',
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
                              );
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
