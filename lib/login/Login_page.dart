import 'package:connect/Const/route.dart';
import 'package:connect/login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../BottomNav/bottomNavPage.dart';
import '../Home/HomePage.dart';
import '../controllar/login_controllar/login_controllar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool passwordVisible=true;


  @override
  Widget build(BuildContext context) {
    final  controller = Provider.of<LoginControllar>(context,listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // XpF (164:2015)
                margin: EdgeInsets.fromLTRB(0, 8, 0, 10),
                child: Text(
                  'স্বাগতম!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 38,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                // autogrouphcvpnkB (WyFvgBJMFxKRi2SQvGHCvP)
                // margin: EdgeInsets.fromLTRB(8.03, 0, 0, 4.94),
                child: Image.asset(
                  "assets/login.png",
                  width: 250,
                  height: 250,
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffd9d9d9)),
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0,),
                    child: TextField(
                      controller: controller.emailControllar,
                      decoration: InputDecoration(
                        hintText: "ইমেইল",
                        border:InputBorder.none,
                        hintStyle:   TextStyle(
                          color: Colors.black,
                          fontFamily: 'IrabotiMJ',
                          fontWeight: FontWeight.normal,

                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffd9d9d9)),
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0,),
                    child: TextField(
                      controller: controller.passwordControllar,
                      obscureText: controller.passvisible,
                      decoration: InputDecoration(
                        hintText: "পাসওয়ার্ড",
                        border:InputBorder.none,
                        hintStyle:   TextStyle(
                          color: Colors.black,
                          fontFamily: 'IrabotiMJ',
                          fontWeight: FontWeight.normal,
                        ),
                        suffixIcon: InkWell(
                          onTap: (){
                          setState(() {
                            controller.passwordVisivile();
                          });
                          },
                            child:controller.passvisible?Icon(Icons.visibility_off,color: Colors.black,):Icon(Icons.visibility,color: Colors.black,)),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                 controller.getLogin(context);
                },
                child: controller.loder?Center(child: CircularProgressIndicator(),):
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 20, 10),
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color(0xffe51d20),
                    borderRadius: BorderRadius.circular(34),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33e51d20),
                        offset: Offset(0, 6),
                        blurRadius: 7.5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'লগ  ইন',
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                          color: Color.fromRGBO(242, 243, 244, 1),
                          fontFamily: 'IrabotiMJ',
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                    'পাসওয়ার্ড ভূলে গিয়েছেন?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontFamily: 'IrabotiMJ',
                    )
                ),
              ),
              // Container(
              //   // Jdy (164:2017)
              //   margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              //   child: TextButton(
              //     onPressed: () {},
              //     style: TextButton.styleFrom(
              //       padding: EdgeInsets.zero,
              //     ),
              //     child: Text(
              //         'পাসওয়ার্ড ভূলে গিয়েছেন?',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: 18,
              //           fontFamily: 'IrabotiMJ',
              //         )
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: (){
                  newPage(context: context, child: SingUpPage());
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'নতুন?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 18,
                            fontFamily: 'IrabotiMJ',
                          )
                      ),
                      TextSpan(
                          text: ' রেজিস্টার করুন।',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'IrabotiMJ',
                          )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}