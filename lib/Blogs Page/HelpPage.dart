import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptobase/Environment%20Files/.env.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
class HelpSection extends StatefulWidget {
  const HelpSection({super.key});

  @override
  State<HelpSection> createState() => _HelpSectionState();
}

class _HelpSectionState extends State<HelpSection> {
  TextEditingController _helptext = TextEditingController();
  List<String?> items = [];
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  List<bool> isowner = [];
  bool ismessagetyped=false;
  Future<void> getresponse() async {
    // Access your API key as an environment variable (see "Set up your API key" above)
    final apiKey = Environment.geminiapi;
    if (apiKey == null) {
      print('No \$API_KEY environment variable');
      // exit(1);
    }
    // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [Content.text(_helptext.text)];
    final response = await model.generateContent(content);
    setState(() {
      items.add(response.text);
      isowner.add(false);

    });
    print(response.text);
    _helptext.clear();
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
          'CryptoBase Support',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        leading: InkWell(
          onTap: () async {
            try {
              Navigator.pop(context);
            } catch (e) {
              // Handle the error if necessary
            }
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          items.isEmpty?Expanded(child: Column(
            children: [
               SizedBox(
                height: MediaQuery.sizeOf(context).height/2.5,
              ),
              Center(
                child: Text('Welcome To CryptoBase Support',style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
              )
            ],
          )): Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ListTile(
                title: Row(
                  children: [
                    isowner[index] ? const Spacer() : Container(),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: isowner[index] ? const Color(0xFF1c2835) : const Color(0xFF1c2895),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start, // Center vertically
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                              child: Text(
                                '${items[index]}\n',
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                                textAlign: TextAlign.center, // Center text horizontally
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _helptext,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: ()async{
                      if(_helptext.text!=''){
                        setState(() {
                          items.add(_helptext.text);
                          isowner.add(true);
                        });
                        final user=_auth.currentUser;
                        getresponse();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}