import 'package:cryptobase/Login%20Page/getstarted.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "CryptoBase",
      debugShowCheckedModeBanner: false,
      home: GetStarted(),
      
    );
  }
}

