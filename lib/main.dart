import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'Const/const.dart';
import 'Splash/Splash.dart';
import 'controllar/NotificationProvider/NotificationProvider.dart';
import 'controllar/addlinkPage_controllar/addlinkPage_controllar.dart';
import 'controllar/categoric_controllar/categoric_controllar.dart';
import 'controllar/drawer/drawer.dart';
import 'controllar/joblist_controllar/joblist_controllar.dart';
import 'controllar/login_controllar/login_controllar.dart';
import 'controllar/membershipUpdate/membershipUpdate.dart';
import 'controllar/messageProvider/messageProvider.dart';
import 'controllar/myLink_controller/myLink_controller.dart';
import 'controllar/register/register_controllar.dart';
import 'controllar/userprofileController/userProfileController.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await ScreenUtil.ensureScreenSize();

  // Stripe.publishableKey = 'your publish key';
  // await Stripe.instance.applySettings();

  final dir = await getApplicationDocumentsDirectory();
  init();
  await Hive.initFlutter();
  Hive.init(dir.path);
  await Hive.openBox("login");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) => RegisterControllar())),
      ChangeNotifierProvider(create: ((context) => LoginControllar())),
      ChangeNotifierProvider(create: ((context) => CategoricContrllar())),
      ChangeNotifierProvider(create: ((context) => JobListControllar())),
      ChangeNotifierProvider(create: ((context) => AddLinkControllar())),
      ChangeNotifierProvider(create: ((context) => ProfileProvider())),
      ChangeNotifierProvider(create: ((context) => DrawerControllerdata())),
      ChangeNotifierProvider(create: ((context) => MyLinkContrllar())),
      ChangeNotifierProvider(create: ((context) => NotificationProvider())),
      ChangeNotifierProvider(create: ((context) => MessageProvider())),
      ChangeNotifierProvider(create: ((context) => MembershipUpdate())),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (ctx, child) {
//// ttt
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
          );
        });
  }
}
