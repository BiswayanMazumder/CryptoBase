import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  bool islogin=true;
  void changepage(){
    setState(() {
      islogin=!islogin;
      // print(islogin);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232f3f),
      appBar: AppBar(
        backgroundColor: Color(0xFF232f3f),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:const Icon(Icons.arrow_back,color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Continue Using Email ID',style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color:const Color(0xFF232f6f))
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        changepage();
                      },
                      child: Text('Login',style: GoogleFonts.poppins(
                          color: islogin?Colors.white:Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),),
                    ),
                    InkWell(
                      onTap: (){
                        changepage();
                      },
                      child: Text('Sign Up',style: GoogleFonts.poppins(
                          color: islogin?Colors.blueAccent:Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey,width: 0.9)
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '  Email',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey,width: 0.9)
                ),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: '  Password',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      )
                  ),
                ),
              ),
            ),
            islogin?Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Forgot Password',style: GoogleFonts.poppins(color: Colors.blueGrey,
                    fontWeight: FontWeight.w400
                  ),),
                ),
              ],
            ):const Text(''),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Center(
                  child: islogin?Text('LOGIN',style: GoogleFonts.poppins(color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),):Text('SIGN UP',style: GoogleFonts.poppins(color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
