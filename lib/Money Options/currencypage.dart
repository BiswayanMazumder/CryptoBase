import 'package:cryptobase/Home%20Screen/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {

  void changeindex(int currentindex) async{

    setState(() {
      for (int i = 0; i < isselected.length; i++) {
        if (i == currentindex) {
          isselected[i] = true;
        } else {
          isselected[i] = false;
        }
      }
      index_clicked = currentindex;
    });
  }

  List isselected=[false,false,true,false,false,false,false,false,
    false,false,false];
  List currency = [
    'USDT',
    'BTC',
    'INR',
    'IDR',
    'RUB',
    'UAH',
    'NGN',
    'SAR',
    'EUR',
  ];
  int index_clicked=2;
  void readfetcheddata()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? counter = prefs.getInt('selected_currency');
    // print(counter);
    if(counter!=null){
      setState(() {
        index_clicked=counter;
        changeindex(counter);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readfetcheddata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232f3f),
      appBar: AppBar(
        backgroundColor: const Color(0xFF232f3f),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'CryptoBase',
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            color: const Color(0xFF1c2835),
            child: Column(
              children: [
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        'Select your preferred display currency for all markets.',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currency.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20,top: 42), // Adjust vertical padding as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap:()async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          changeindex(index);
                          await prefs.setInt('selected_currency', index_clicked);
                          await prefs.setString('selected_currency_name', currency[index]);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
                        },
                        child: Row(
                          children: [
                            Text(
                              currency[index],
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            if(isselected[index])
                              const Padding(
                                padding:EdgeInsets.only(right: 20),
                                child: Icon(Icons.check,color: Colors.white,),
                              )
                          ],
                        ),
                      )
                    ],
                  )
                );
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: const Color(0xFF1c2835),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap:()async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          changeindex(2);
                          setState(() {
                            index_clicked=2;
                          });
                          await prefs.setInt('selected_currency', 2);
                          await prefs.setString('selected_currency_name','INR');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
                      },
                        child: Text(
                          'Reset',
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
