import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool isLogin = true;
  bool _errorMessage = false;
  bool showPw = false;
  bool loginfail=false;
  String loginerrormessage='';
  Future<void> login ()async{
    try{
      _auth.signInWithEmailAndPassword(email: _emailController.text,
          password: _passwordController.text);
    }catch(e){
      print(e);
      setState(() {
        loginfail=true;
        loginerrormessage=e.toString();
      });
    }
  }
  Future<void> signup() async{
    final user=_auth.currentUser;
    try{
      _auth.createUserWithEmailAndPassword(email: _emailController.text,
          password: _passwordController.text);
      _firestore.collection('User Details').doc(user!.uid).set({
        'Email':_emailController.text,
        'Name':_nameController.text,
        'Date Of Registration':FieldValue.serverTimestamp()
      });
    }catch(e){

    }
  }
  void changePage() {
    setState(() {
      isLogin = !isLogin;
    });
    print(isLogin);
  }

  void hidePw() {
    setState(() {
      showPw = !showPw;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail(String email) {
    setState(() {
      _errorMessage = !_isEmailValid(email);
    });
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232f3f),
      appBar: AppBar(
        backgroundColor: const Color(0xFF232f3f),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left:0),
              child: Text(
                'Continue Using Email ID',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: const Color(0xFF232f6f)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: changePage,
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          color: isLogin ? Colors.white : Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: changePage,
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          color: isLogin ? Colors.blueAccent : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 39),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _errorMessage ? Colors.red : Colors.blueGrey,
                    width: _errorMessage?2:0.9,
                  ),
                ),
                child: TextField(
                  controller: _emailController,
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '  Email',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onChanged: _validateEmail,
                ),
              ),
            ),
            _errorMessage?Text('Please enter a valid email address',style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.w600
            ),):Text(''),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 0.9),
                ),
                child: TextField(
                  obscureText: !showPw,
                  style: GoogleFonts.poppins(color: Colors.white),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: '  Password',
                    suffixIcon: InkWell(
                      onTap: hidePw,
                      child: Icon(
                        showPw
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                        color: showPw ? Colors.blue : Colors.white,
                      ),
                    ),
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),

            if (isLogin)
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.poppins(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  _validateEmail(_emailController.text);
                  // Add your login or sign-up logic here
                },
                child: InkWell(
                  onTap: (){
                    isLogin?login():signup();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        isLogin ? 'LOGIN' : 'SIGN UP',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            loginfail?Text('Failed to login',style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.w600
            ),):Text('',style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.w600
            ),),
          ],
        ),
      ),
    );
  }
}
