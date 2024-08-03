import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import '../Const/route.dart';
import '../controllar/NotificationProvider/NotificationProvider.dart';
import 'package:connect/widget/popupMenu.dart' as popUp;

import '../link_add/link_add_page.dart';
import '../network/NotificationSend/Notification.dart';
class NotificatonsPage extends StatefulWidget {
  const NotificatonsPage({Key? key}) : super(key: key);
  @override
  State<NotificatonsPage> createState() => _NotificatonsPageState();
}

class _NotificatonsPageState extends State<NotificatonsPage> {

  CustomPopupMenuController controller = CustomPopupMenuController();

  var controller2 = <CustomPopupMenuController>[];
  var loading = true;
  load() {
    final notification =
        Provider.of<NotificationProvider>(context, listen: false);
    notification.getNotification().then((value) {
      setState(() {
        loading = false;
      });
    });
  }
  String timeAgo({bool numericDates = true, required DateTime dateTime}) {
    final date2 = DateTime.now();
    final difference = date2.difference(dateTime);
    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '১ সপ্তাহ আগে' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} দিন আগে';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '১ দিন আগে' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} ঘণ্টা আগে';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '১ ঘণ্টা আগে' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} মিনিট আগে';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '১ মিনিট আগে' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} সেকেন্ড আগে';
    } else {
      return 'এই মাত্র';
    }
  }
  @override
  void initState() {

  //  load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final notification =
    //     Provider.of<NotificationProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            newPage(context: context, child: const LinkAddPage());
          },
          child: SvgPicture.asset("assets/addLink.svg"),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('নোটিফিকেশন',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.red, fontSize: 18, fontFamily: 'IrabotiMJ')),
          //  leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,size: 32,color: Colors.black,),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: CustomPopupMenu(
                controller: controller,
                menuOnChange: (v){
                  print(v);
                },
                menuBuilder: () {
                return

                  Container(

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: IntrinsicWidth(
                      child:
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap:(){
                                print("tap");
                                controller.hideMenu();
                              },
                              child: Text(
                                  'এডিট',
                                  textAlign:
                                  TextAlign
                                      .start,
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: Colors.black
                                  )
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            SizedBox(height: 15,),
                            InkWell(
                              onTap:(){
                                print("tap");
                                controller.hideMenu();
                                setState(() {

                                });
                              },
                              child: Text(
                                  'ডিলিট',
                                  textAlign:
                                  TextAlign
                                      .start,
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: Colors.black
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );

              },
                pressType: PressType.singleClick,
                child:SvgPicture.asset(
                  "assets/menuImage.svg",
                 width: 8,
                ) ,),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Image.asset(
                    "assets/backgroundImage.png",
                    fit: BoxFit.cover,
                  )),
              Consumer<NotificationProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  value.getNotification();

                  return    value.notificationModel == null
                      ? Center(
                    child: Text("There is no Notifications"),
                  )
                      : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 2.5,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 0),
                            child: ListView.builder(
                                itemCount: value
                                    .notificationModel!.msg!.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                primary: false,
                                itemBuilder: (context, index) {
                                  var data = value
                                      .notificationModel!.msg![index];
                                  controller2.add(CustomPopupMenuController());
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor:
                                                    Colors.red,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${data.content}',
                                                    textAlign:
                                                    TextAlign.start,
                                                    maxLines: 50,
                                                    style:
                                                    GoogleFonts.inter(
                                                      textStyle:
                                                      TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(timeAgo(dateTime: data.createdAt!),
                                                    textAlign:
                                                    TextAlign.start,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                      fontFamily:
                                                      'IrabotiMJ',
                                                    )),
                                                SizedBox(width: 10,),

                                                Container(
                                                  width: 22,
                                                  height: 15,
                                                  child: CustomPopupMenu(
                                                    controller:controller2[index],
                                                    menuBuilder: () {
                                                      return

                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(8)
                                                          ),
                                                          child: IntrinsicWidth(
                                                            child:

                                                            Padding(
                                                              padding: const EdgeInsets.all(20.0),
                                                              child: Column(
                                                                children: [
                                                                  GestureDetector(
                                                                    behavior: HitTestBehavior.translucent,
                                                                    onTap:(){
                                                                      print("tap");
                                                                      controller2[index].hideMenu();
                                                                    },
                                                                    child: Text(
                                                                        'ফেভারিট এ যুক্ত করুন',
                                                                        textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                        style: GoogleFonts.inter(
                                                                            fontSize: 18,
                                                                            color: Colors.black
                                                                        )
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 15,),

                                                                  Container(
                                                                    height: 1,
                                                                    width: double.infinity,
                                                                    color: Colors.black.withOpacity(0.2),
                                                                  ),
                                                                  SizedBox(height: 15,),
                                                                  InkWell(
                                                                    onTap:(){
                                                                      var box = Hive.box('login');
                                                                      controller2[index].hideMenu();
                                                                      NotificationRepo().notificationDelete(id: data.id!, receiverId: "${box.get('userid')}").then((value){
                                                                        value.getNotification();
                                                                        setState(() {

                                                                        });
                                                                      });

                                                                    },
                                                                    child: Text(
                                                                        'ডিলিট করুন',
                                                                        textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                        style: GoogleFonts.inter(
                                                                            fontSize: 18,
                                                                            color: Colors.black
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );

                                                    },
                                                    pressType: PressType.singleClick,
                                                    child:SvgPicture.asset(
                                                      "assets/menuicon.svg",
                                                      height: 6,

                                                    ) ,),
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        Divider(
                                          thickness: 1,
                                          color:
                                          Colors.grey.withOpacity(0.3),
                                          endIndent: 13,
                                          indent: 13,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                      ),
                    ),
                  );

                },


              )
            ],
          ),
        ),
      ),
    );
  }
}
