import 'package:cryptobase/Login%20Page/getstarted.dart';
import 'package:cryptobase/Splash%20Screen/splashscreen.dart';
import 'package:cryptobase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth=FirebaseAuth.instance;
    final user=_auth.currentUser;
    return  MaterialApp(
      title: "CryptoBase",
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      
    );
  }
}

