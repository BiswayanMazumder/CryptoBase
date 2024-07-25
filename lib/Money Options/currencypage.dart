import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  int index_clicked=2;
  void changeindex(int currentindex) {
    setState(() {
      for (int i = 0; i < isselected.length; i++) {
        if (i == currentindex) {
          isselected[i] = true;
        } else {
          isselected[i] = false;
        }
      }
      index_clicked = currentindex; // Update the index_clicked
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
    'TRY',
    'WRX'
  ];

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
                  padding: const EdgeInsets.only(left: 20,top: 20), // Adjust vertical padding as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap:(){
                          changeindex(index);
                          // print(index_clicked);

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
        ],
      ),
    );
  }
}
