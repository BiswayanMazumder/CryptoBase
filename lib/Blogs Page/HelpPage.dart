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
    final user=_auth.currentUser;
    await _firestore.collection('Customer Care Chats').doc(user!.uid).set(
        {
          'Chats':FieldValue.arrayUnion([response.text])
        },SetOptions(merge: true));
    print(response.text);
    _helptext.clear();
  }
  List<dynamic>userchats=[];
  List<dynamic>customercarechats=[];
  Future<void> fetcholdchats()async{
    final user=_auth.currentUser;
    final docsnap=await _firestore.collection('User Chats').doc(user!.uid).get();
    if(docsnap.exists){
      setState(() {
        userchats=docsnap.data()?['Chats'];
      });
    }
    final docsnaps=await _firestore.collection('Customer Care Chats').doc(user!.uid).get();
    if(docsnap.exists){
      setState(() {
        customercarechats=docsnaps.data()?['Chats'];
      });
    }
    print(customercarechats);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetcholdchats();
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
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: _firestore.collection('User Chats').doc(_auth.currentUser!.uid).snapshots(),
              builder: (context, userChatSnapshot) {
                if (userChatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!userChatSnapshot.hasData) {
                  return Center(child: Text('No messages found'));
                }

                // Safely cast user chat data
                final userChatsData = userChatSnapshot.data!.data() as Map<String, dynamic>?;
                final userChats = userChatsData?['Chats'] as List<dynamic>? ?? [];

                return StreamBuilder<DocumentSnapshot>(
                  stream: _firestore.collection('Customer Care Chats').doc(_auth.currentUser!.uid).snapshots(),
                  builder: (context, customerCareChatSnapshot) {
                    if (customerCareChatSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!customerCareChatSnapshot.hasData) {
                      return Center(child: Text('No messages found'));
                    }

                    // Safely cast customer care chat data
                    final customerCareChatsData = customerCareChatSnapshot.data!.data() as Map<String, dynamic>?;
                    final customerCareChats = customerCareChatsData?['Chats'] as List<dynamic>? ?? [];

                    // Combine both chats in interleaved order
                    List<Map<String, dynamic>> interleavedChats = [];
                    final maxLength = userChats.length > customerCareChats.length
                        ? userChats.length
                        : customerCareChats.length;

                    for (int i = 0; i < maxLength; i++) {
                      if (i < userChats.length) {
                        interleavedChats.add({'text': userChats[i], 'isUser': true});
                      }
                      if (i < customerCareChats.length) {
                        interleavedChats.add({'text': customerCareChats[i], 'isUser': false});
                      }
                    }

                    return ListView.builder(
                      itemCount: interleavedChats.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Row(
                          children: [
                            interleavedChats[index]['isUser']
                                ? const Spacer()
                                : Container(),
                            Container(
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: interleavedChats[index]['isUser']
                                    ? const Color(0xFF1c2895)
                                    : const Color(0xFF1c2835),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    '${interleavedChats[index]['text']}\n',
                                    overflow: TextOverflow.visible,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      if (_helptext.text != '') {
                        setState(() {
                          items.add(_helptext.text);
                          isowner.add(true);
                        });
                        final user = _auth.currentUser;
                        await _firestore.collection('User Chats').doc(user!.uid).set(
                          {
                            'Chats': FieldValue.arrayUnion([_helptext.text])
                          },
                          SetOptions(merge: true),
                        );
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
