import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controllar/register/register_controllar.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RegisterControllar>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/icon/logo2.png",
                scale: 2,
              ),

              const SizedBox(
                height: 30,
              ),
              Text(
                'নতুন একাউন্ট তৈরি করুন',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color.fromRGBO(229, 29, 32, 1),
                    fontFamily: 'IrabotiMJ',
                    fontSize: 23.sp,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffd9d9d9)),
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                    ),
                    child: TextField(
                      controller: controller.fullNameControllar,
                      decoration: const InputDecoration(
                        hintText: "নাম",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
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
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffd9d9d9)),
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                    ),
                    child: TextField(
                      controller: controller.profileTaglineControllar,
                      decoration: const InputDecoration(
                        hintText: 'প্রফাইল টেগ্লাইন',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
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
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffd9d9d9)),
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                    ),
                    child: TextField(
                      controller: controller.conpanyNameControllar,
                      decoration: const InputDecoration(
                        hintText: "আপনার বর্তমান কোম্পানি",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
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
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffd9d9d9)),
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                    ),
                    child: Form(
                      key: _formKey2,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if (value!.isEmpty) {
                            return 'Please enter an phone number';
                          } else if (value.length!=11) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                        controller: controller.phoneControllar,
                        decoration: const InputDecoration(
                          hintText: "ফোন",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'IrabotiMJ',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffd9d9d9)),
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: controller.emailControllar,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email address';
                          } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },


                        decoration: const InputDecoration(
                          hintText: "ইমেইল",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'IrabotiMJ',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffd9d9d9)),
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                    ),
                    child: TextField(
                      controller: controller.passswordControllar,
                      decoration: const InputDecoration(
                        hintText: "পাসওয়ার্ড",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
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
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffd9d9d9)),
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                    ),
                    child: TextField(
                      controller: controller.rePassworddControllar,
                      decoration: const InputDecoration(
                        hintText: "পাসওয়ার্ড পুনরায় লিখুন",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'IrabotiMJ',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()||_formKey2.currentState!.validate()) {
                    controller.getRegister(context);
                  }

                },
                child: controller.loder
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        width: 314,
                        height: 55,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(34),
                            topRight: Radius.circular(34),
                            bottomLeft: Radius.circular(34),
                            bottomRight: Radius.circular(34),
                          ),
                          color: Color.fromRGBO(229, 29, 32, 1),
                        ),
                        child: const Center(
                          child: Text(
                            'যোগ করুন',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(242, 243, 244, 1),
                                fontFamily: 'IrabotiMJ',
                                fontSize: 18,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'অলরেডি একাউন্ট আছে? লগ ইন করুন',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(151, 151, 151, 1),
                      fontFamily: 'IrabotiMJ',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
