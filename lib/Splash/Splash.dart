import 'package:connect/BottomNav/bottomNavPage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../Const/route.dart';
import '../controllar/userprofileController/userProfileController.dart';
import '../onboarding/Onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var box=Hive.box("login");

 Future load()async{
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    await profile.getProfileInfo();
  }
  @override
  void initState() {
   if(box.get("userid")==null){
     Future.delayed(const Duration(seconds: 3),(){
       newPage(context: context, child:const Onboarding());
     });

   }
   else{
     load().then((value) {
       Navigator.pushAndRemoveUntil(
           context, MaterialPageRoute(builder: (context) => const BottomNavPage()), (
           route) => false);
       // newPage(context: context, child:const BottomNavPage()));
     });
   }
   //newPage(context: context, child:BottomNavPage());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Image.asset("assets/Splash.png",fit:BoxFit.cover, ),
      ),
    );
  }
}
