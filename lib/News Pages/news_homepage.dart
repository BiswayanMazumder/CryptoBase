import 'dart:convert';

import 'package:cryptobase/Environment%20Files/.env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:google_fonts/google_fonts.dart';
class News_HomePage extends StatefulWidget {
  const News_HomePage({Key? key}) : super(key: key);

  @override
  State<News_HomePage> createState() => _News_HomePageState();
}

class _News_HomePageState extends State<News_HomePage> {
  List<dynamic> title=[];
  List<dynamic> author=[];
  List<dynamic>URL=[];
  bool loadeddata=false;
  List<dynamic>urltoimage=[];
  final headers = {
    'x-rapidapi-key': Environment.rapidapikey,
  };
  Future<void> getnews()async{
    final response=await https.get(Uri.parse(Environment.News_ENDPOINT),
    );
    if(response.statusCode==200){
      Map<String,dynamic> news = json.decode(response.body);
      List<dynamic>Items=news["articles"];
      // print(Items);
      List<dynamic> Title = Items.map((coin) => coin['title']).toList();
      List<dynamic>Author=Items.map((coin) => coin['author']).toList();
      List<dynamic> url=Items.map((coin) => coin['url']).toList();
      List<dynamic> URLTOIMAGE=Items.map((coin) => coin['urlToImage']).toList();
      // print(URLTOIMAGE);
      setState(() {
        title=Title;
        author=Author;
        URL=url;
        urltoimage=URLTOIMAGE;
        loadeddata=true;
      });
    }
    // print(title);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnews();
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
          'FinanceFlash',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: loadeddata?Column(
          children: [
            for(int i=0;i<title.length;i++)
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                child: Column(
                  children: [
                    if(urltoimage[i]!=null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Image(image: NetworkImage(urltoimage[i])),
                      ),
                    Text(title[i],style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                    ),),
                    if(author[i]!=null)
                      Row(
                        children: [
                          Text(author[i],style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 15
                          ),),
                        ],
                      ),
                  ],
                ),
              )
          ],
        ):Padding(
          padding:  EdgeInsets.only(top: MediaQuery.sizeOf(context).width/2),
          child: Column(
            children: [
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
