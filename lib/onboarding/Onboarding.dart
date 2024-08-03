import 'package:connect/Const/route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../login/Login_page.dart';
import '../login/register_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int pageIndex = 0;
  var box = Hive.box("login");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(
                "assets/splashbg.png",
                fit: BoxFit.cover,
              )),
          Column(children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                children: [
                  Center(
                    child: Image.asset(
                      "assets/onboard1.png",
                      fit: BoxFit.cover,
                      height: 206,
                      width: 218,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      "assets/onboard2.png",
                      fit: BoxFit.cover,
                      height: 206,
                      width: 218,
                    ),
                  ),
                ],
              ),
            ),
            DotsIndicator(
              decorator: const DotsDecorator(activeColor: Colors.white),
              dotsCount: 2,
              position: int.parse(pageIndex.toString()),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 65),
                    child: InkWell(
                      onTap: () {
                        newPage(context: context, child: LoginScreen());
                      },
                      child: Container(
                        height: 55,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                            child: Text(
                          "লগ ইন",
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                newPage(context: context, child: SingUpPage());
              },
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "নতুন?",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: " রেজিস্টার করুন।"),
              ])),
            ),
            SizedBox(
              height: 20,
            ),
          ])
        ],
      ),
    );
  }
}
