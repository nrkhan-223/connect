import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../controllar/userprofileController/userProfileController.dart';
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  TextEditingController name = TextEditingController();
  TextEditingController tagLine = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController companyWeb = TextEditingController();
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController retypeNewPass = TextEditingController();

  load()async{
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    var data = profile.profile!.msg!.userData!;

    name.text = data.fullName??"";
    tagLine.text = data.profileTagline??"";
    phone.text = data.phone??"";

    companyName.text = data.companyName??"";

  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final profile = Provider.of<ProfileProvider>(context, listen: false);
    var size=MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10).r,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:  Icon(
              Icons.arrow_back_ios, size: 25.w,  color: Colors.black,),
          ),
        ),
        title:  Text(
            'এডিট প্রোফাইল',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.red,
                fontSize: 18.sp,
                fontFamily: 'IrabotiMJ'
            )
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/backgroundImage.png",),fit: BoxFit.cover,),
                ),

              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).w,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h,),
                       Center(
                        child: Text(
                            'প্রোফাইল এর তথ্য',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.sp,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Divider(
                        color: Colors.grey,
                        endIndent: 10,
                        indent: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'আপনার নাম',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 50.h,
                          child: TextField(
                            controller: name,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'e.g. John Doe',
                              filled: true,
                              fillColor: Color(0xffCCCCCC).withOpacity(0.15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(color:Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(
                                      color: Colors.grey,
                                      width: 1
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'ট্যাগ লাইন',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 50.h,
                          child: TextField(
                            controller: tagLine,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'e.g. Web Developer',
                              filled: true,
                              fillColor: Color(0xffCCCCCC).withOpacity(0.15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(color:Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                  borderSide:BorderSide(
                                      color: Colors.grey,
                                      width: 1
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'ফোন নাম্বার',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 50.h,
                          child: TextField(
                            controller: phone,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'e.g. +880 123 456 7890',
                              filled: true,
                              fillColor: Color(0xffCCCCCC).withOpacity(0.15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(color:Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(
                                      color: Colors.grey,
                                      width: 1
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'কোম্পানীর নাম',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 50.h,
                          child: TextField(
                            controller: companyName,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'eg. companyxyz',
                              filled: true,
                              fillColor: Color(0xffCCCCCC).withOpacity(0.15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                  borderSide:BorderSide(color:Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                  borderSide:BorderSide(
                                      color: Colors.grey,
                                      width: 1
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Center(
                        child: Text(
                            'পাসওয়ার্ড পরিবর্তন',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.sp,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'পুরাতন পাসওয়ার্ড',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 50.h,
                          child: TextField(
                            controller: oldPass,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Input your old password',
                              filled: true,
                              fillColor: Color(0xffCCCCCC).withOpacity(0.15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(color:Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(
                                      color: Colors.grey,
                                      width: 1
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'নতুন পাসওয়ার্ড',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 50.h,
                          child: TextField(
                            controller: newPass,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Input your new password',
                              filled: true,
                              fillColor: Color(0xffCCCCCC).withOpacity(0.15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(color:Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(
                                      color: Colors.grey,
                                      width: 1
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                            'পুনরায় নতুন পাসওয়ার্ড প্রদান করুন',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 50.h,
                          child: TextField(
                            controller: retypeNewPass,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Retype your new Password',
                              filled: true,
                              fillColor: Color(0xffCCCCCC).withOpacity(0.15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(color:Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(
                                      color: Colors.grey,
                                      width: 1
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),

                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                              child: Container(
                                
                                height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: ElevatedButton(onPressed: ()async{

                                    if(newPass.text != retypeNewPass.text){
                                      Fluttertoast.showToast(
                                          msg: "Pass word are not same",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }

                                    else{

                                      await profile.profileUpdate(
                                        name: name.text,
                                        company: companyName.text,
                                        phone: phone.text,
                                        profiletag:tagLine.text,
                                        oldpass: oldPass.text,
                                        newpass: newPass.text,
                                        confirmpass: retypeNewPass.text,
                                        pic: "",
                                        servicearea: [],

                                      ).then((value){
                                        profile.getProfileInfo();
                                        setState(() {

                                        });
                                      });

                                    }


                                  }, child: Text("পরিবর্তন নিশ্চিত করুন",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: 'IrabotiMJ'
                                      )

                                  ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red
                                    ),


                                  )),
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 15.h,)

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
