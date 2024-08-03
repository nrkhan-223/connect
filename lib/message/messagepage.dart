import 'package:connect/controllar/messageProvider/messageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/messageListModel/messageListModel.dart';

class MessagePage extends StatefulWidget {
  final String applyid;
  final String jobid;
  final String senderid;
  final String recvid;
  final String name;

  const MessagePage({super.key, required this.applyid, required this.jobid, required this.senderid, required this.recvid, required this.name});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String timeAgo({bool numericDates = true, required DateTime postTime}) {
    final date2 = DateTime.now();
    final difference = date2.difference(postTime);
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
  List<PopupMenuEntry<dynamic>> list = [];
  int selected=0;
  var messageField="";
  Stream<Messagelist?> ?mesgFunc;
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    list.add(const PopupMenuItem(
        child: Text('খুজুন',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontFamily: 'IrabotiMJ'))));
    list.add(const PopupMenuDivider(
      height: 20,
    ));
    list.add(const PopupMenuItem(
        child: Text('প্রোফাইল দেখুন',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontFamily: 'IrabotiMJ'))));
    list.add(const PopupMenuDivider(
      height: 20,
    ));
    list.add(const PopupMenuItem(
        child: Text('নোটিফিকেশন দেখুন',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontFamily: 'IrabotiMJ'))));
    list.add(const PopupMenuDivider(
      height: 20,
    ));
    list.add(const PopupMenuItem(
        child: Text('ব্লক করুন',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontFamily: 'IrabotiMJ'))));
    list.add(const PopupMenuDivider(
      height: 20,
    ));
    list.add(const PopupMenuItem(
        child: Text('বার্তা মুছে ফেলুন',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontFamily: 'IrabotiMJ'))));
    mesgFunc = Provider.of<MessageProvider>(context, listen: false).streammessage(
        applyid: widget.applyid,
        jobid: widget.jobid,
        refreshTime: const Duration(seconds: 1));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    final mess = Provider.of<MessageProvider>(context);
    var box = Hive.box('login');
    return
      Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height:size.height *0.3,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage(
                      "assets/profileImage.png"
                  ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: AppBar(
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 10).r,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon:  Icon(
                          Icons.arrow_back_ios, size: 25.w, color: Colors.white,),
                      ),
                    ),
                    title:  Text(
                        widget.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                        )
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15).r,
                        child: PopupMenuButton(
                          // onOpened: (){
                          //   if(selected==3){
                          //     newPage(context: context, child: HomePage());
                          //   }
                          // },
                          onSelected: (value) {
                            selected=value;
                            print(selected);
                          },
                          itemBuilder: (context) {
                            return list.toList();
                          },
                        ),
                      ),
                    ],
                  ),
                  // child: Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     IconButton(onPressed: (){
                  //       Navigator.pop(context);
                  //     }, icon: Icon(Icons.arrow_back_ios,size: 25.h,color: Colors.white,),),
                  //     Text('Ralph Edwards',
                  //         textAlign: TextAlign.start,
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18.sp,
                  //         )),
                  //     PopupMenuButton(
                  //       padding: EdgeInsets.all(0),
                  //       // onOpened: (){
                  //       //   if(selected==3){
                  //       //     newPage(context: context, child: HomePage());
                  //       //   }
                  //       // },
                  //
                  //       onSelected: (value) {
                  //         selected=value;
                  //         print(selected);
                  //       },
                  //       child: SvgPicture.asset(
                  //         "assets/menuImage.svg",
                  //         color: Colors.black,
                  //         height: 22,
                  //         width: 16,
                  //       ),
                  //       itemBuilder: (context) {
                  //         return list.toList();
                  //       },
                  //     ),
                  //   ],
                  // ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only( top: size.height*0.15,),
                child: Container(
                  height: size.height*0.83,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight:Radius.circular(30) ,topLeft: Radius.circular(30)),
                    image: DecorationImage(image: AssetImage("assets/backgroundImage.png",),
                      fit: BoxFit.cover,),
                  ),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                    StreamBuilder<Messagelist?>(
                      stream: mesgFunc,
                        // stream: mess.streammessage(
                        //     applyid: widget.applyid,
                        //     jobid: widget.jobid,
                        //     refreshTime: const Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return     const Center(child: CircularProgressIndicator(),);
                          }
                          else if (snapshot.hasData) {
                            var data = snapshot.data;
                            return Flexible(
                              child: listMessage3(data),
                            );
                          } else {
                            return  const Flexible(
                              child: Center(
                                // child: listmessage2(data),
                                child: Text("Lats start"),
                              ),
                            );
                          }
                        }),
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.07,
                      //   decoration: BoxDecoration(
                      //       color: const Color(0xFFF6F6F6),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: Colors.black.withOpacity(0.5),
                      //             blurRadius: 1)
                      //       ]),
                      //   child: Row(
                      //     children: [
                      //       Flexible(
                      //           child: TextFormField(
                      //             controller: messageController,
                      //             maxLines: 150,
                      //             minLines: 4,
                      //             decoration: InputDecoration(
                      //                 isDense: true,
                      //                 contentPadding:
                      //                 const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      //                 border: OutlineInputBorder(
                      //                   borderSide:
                      //                   const BorderSide(color: Color(0xFFCFCFD0)),
                      //                   borderRadius: BorderRadius.circular(50),
                      //                 ),
                      //                 focusedBorder: OutlineInputBorder(
                      //                   borderSide:
                      //                   const BorderSide(color: Color(0xFFCFCFD0)),
                      //                   borderRadius: BorderRadius.circular(50),
                      //                 ),
                      //                 enabledBorder: OutlineInputBorder(
                      //                   borderSide:
                      //                   const BorderSide(color: Color(0xFFCFCFD0)),
                      //                   borderRadius: BorderRadius.circular(50),
                      //                 ),
                      //                 filled: true,
                      //                 fillColor: const Color(0xFFFAFAFA)),
                      //           )),
                      //       // IconButton(
                      //       //     onPressed: () {},
                      //       //     icon: Image.asset(
                      //       //       'images/message_icon/camera.png',
                      //       //       height: 27,
                      //       //     )),
                      //       IconButton(
                      //           onPressed: () {
                      //
                      //           },
                      //           icon:Icon(Icons.send))
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0XFFf0eff4),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Center(
                                      child: TextField(
                                        maxLines: 5,
                                        minLines: 1,
                                        onChanged: (value) {
                                          messageField = value;
                                          setState(() {});
                                        },
                                        style: const TextStyle(color: Colors.black),
                                        controller: messageController,
                                        decoration: const InputDecoration(
                                            // suffixIcon: InkWell(
                                            //   onTap: () async {
                                            //
                                            //   },
                                            //   child: Icon(
                                            //     Icons.camera_alt_outlined,
                                            //     color: Colors.grey,
                                            //   ),
                                            // ),
                                            hintText: 'Type a Message...',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none),
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                           Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .150,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4a9dfb),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    print(widget.applyid+widget.jobid+ widget.recvid+widget.senderid);
                                    mess
                                        .messagesend(
                                        applyid: widget.applyid,
                                        jobid: widget.jobid,
                                        recvid: widget.recvid,
                                        senderid: widget.senderid,
                                        message: messageController.text,
                                        photo: "")
                                        .then((value){
                                      messageController.clear();

                                    });
                                  },
                                  child: const Center(
                                    child: Icon(
                                      Icons.send,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                ]
                  ),

                ),
              ),
            ],
          ),
        ),
      );
  }
  Widget listMessage3(Messagelist? data) {
    // var box = Hive.box('login');
    // final mess = Provider.of<MessageProvider>(context);
    // data!.msg!.sort((a, b) => b.messageId!.compareTo(a.messageId!));
    Size size= MediaQuery.of(context).size;
    return  GroupedListView<Msg, DateTime>(
      primary: false,
      shrinkWrap: true,
      elements: data!.msg!,
      groupBy: (m)=>DateTime(m.createdAt!.year,
      m.createdAt!.month,
      m.createdAt!.day,
    ),
      groupHeaderBuilder: (Msg m)=>  SizedBox(
        height: 40,
        child:
        Row(
          children: [
            const Expanded(child: Divider(height: 5,thickness: 1.0, indent: 10,endIndent: 10,color: Colors.grey,)),
            Text(DateFormat.yMMMEd().format(m.createdAt!), style: const TextStyle(
                color: Colors.grey
            ),),
            const Expanded(child: Divider(height: 5,thickness: 1.0, indent: 10,endIndent: 10,color: Colors.grey,)),
          ],
        ),
      ),
      reverse: true,
      order: GroupedListOrder.DESC,
      itemBuilder: (context,Msg m){
        return
          m.receiverUserId == widget.recvid ?  Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 22),
            child:
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children:  [
            //     Padding(
            //       padding: EdgeInsets.only(bottom: 5),
            //       child: CircleAvatar(
            //         radius: 15,
            //         backgroundColor: Colors.cyan,
            //         backgroundImage: NetworkImage("${m.pic}"),
            //
            //       ),
            //     ),
            //     SizedBox(width: 5,),
            //     Padding(
            //       padding: EdgeInsets.symmetric(vertical: 8),
            //       child:BubbleSpecialThree(
            //         text: '${m.msg}',
            //         color: Color(0xffEFEFEF),
            //         isSender: true,
            //         tail: true,
            //         textStyle: TextStyle(
            //             color: Colors.black,
            //             fontSize: 16
            //         ),
            //       ),
            //
            //       // Text(m.msg!,
            //       //     textAlign: TextAlign.start,
            //       //     style: TextStyle(
            //       //       color: Colors.black,
            //       //       fontSize: 12,
            //       //     )),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(right: 10,bottom: 7),
            //       child: Text(timeAgo(postTime: m.createdAt!),
            //           textAlign: TextAlign.start,
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 12,
            //             fontFamily: 'IrabotiMJ',
            //           )),
            //     )
            //   ],
            // )
            Container(

              alignment: Alignment.centerRight,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),

                    constraints:  BoxConstraints(
                      maxWidth: size.width*0.5, minWidth: size.width*0.3),

                    decoration:const BoxDecoration(
                        color: Color(0xffEFEFEF),
                        // color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight:  Radius.circular(22),
                          bottomLeft: Radius.circular(22),
                        )
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:  [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                child: Text(m.msg!,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    )),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.cyan,
                                backgroundImage: NetworkImage("${m.pic}"),
                              ),
                            ),



                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(right: 10,bottom: 7),
                              child: Text(timeAgo(postTime: m.createdAt!),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'IrabotiMJ',
                                  )),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            )
            

          ) :
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 22),
            child:   Container(
              alignment: Alignment.centerLeft,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints:  BoxConstraints(
                        maxWidth: size.width*0.5, minWidth:  size.width*0.3),
                    decoration:const BoxDecoration(
                        color: Color(0xffEFEFEF),
                        // color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight:  Radius.circular(22),
                          bottomRight: Radius.circular(22),
                        )
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:  [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.cyan,
                                backgroundImage: NetworkImage("${m.pic}"),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                child: Text(m.msg!,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(right: 10,bottom: 7),
                              child: Text(timeAgo(postTime: m.createdAt!),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'IrabotiMJ',
                                  )),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
      },

    );
  }
}


// class MessagePage extends StatelessWidget {
//   final String applyid;
//   final String jobid;
//   final String senderid;
//   final String recvid;
//   const MessagePage({Key? key, required this.applyid, required this.jobid, required this.senderid, required this.recvid}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController messageController = TextEditingController();
//         Size size= MediaQuery.of(context).size;
//     final mess = Provider.of<MessageProvider>(context);
//     var box = Hive.box('login');
//     return  StreamBuilder<Messagelist?>(  stream: mess.streammessage(
//         applyid: applyid,
//         jobid: jobid,
//         refreshTime: const Duration(seconds: 1)),
//
//       builder: (context, ss){
//         if(ss.connectionState ==  ConnectionState.waiting){
//
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//
//         else if(ss.hasData) {
//           return
//             Scaffold(
//
//               body:
//               SingleChildScrollView(
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Container(
//                       height:size.height *0.3,
//                       width: size.width,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         image: DecorationImage(image: AssetImage(
//                             "assets/profileImage.png"
//                         ),
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
//
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 40),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             IconButton(onPressed: (){
//                               Navigator.pop(context);
//                             }, icon: Icon(Icons.arrow_back_ios,size: 28,color: Colors.white,),),
//                             Text('Ralph Edwards',
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 )),
//                             PopupMenuButton(
//                               padding: EdgeInsets.all(0),
//                               // onOpened: (){
//                               //   if(selected==3){
//                               //     newPage(context: context, child: HomePage());
//                               //   }
//                               // },
//
//                               onSelected: (value) {
//                                 // selected=value;
//                                 // print(selected);
//                               },
//                               child: SvgPicture.asset(
//                                 "assets/menuImage.svg",
//                                 color: Colors.black,
//                                 height: 22,
//                                 width: 16,
//                               ),
//                               itemBuilder: (context) {
//                                 return [];
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only( top: size.height*0.15,),
//
//                       child: Container(
//                         height: size.height*0.83,
//                         width: size.width,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(topRight:Radius.circular(30) ,topLeft: Radius.circular(30)),
//                           image: DecorationImage(image: AssetImage("assets/backgroundImage.png",),
//                             fit: BoxFit.cover,),
//                         ),
//                         child:
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                                 height: size.height*0.75,
//                                 width: size.width,
//                                 child: listMessage3(ss.data)
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: const Color(0xFFF6F6F6),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.black.withOpacity(0.5),
//                                         blurRadius: 1)
//                                   ]),
//                               child: Row(
//                                 children: [
//
//                                   Flexible(
//                                       child: TextFormField(
//                                         controller: messageController,
//                                         decoration: InputDecoration(
//                                             isDense: true,
//                                             contentPadding:
//                                             const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                                             border: OutlineInputBorder(
//                                               borderSide:
//                                               const BorderSide(color: Color(0xFFCFCFD0)),
//                                               borderRadius: BorderRadius.circular(50),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide:
//                                               const BorderSide(color: Color(0xFFCFCFD0)),
//                                               borderRadius: BorderRadius.circular(50),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide:
//                                               const BorderSide(color: Color(0xFFCFCFD0)),
//                                               borderRadius: BorderRadius.circular(50),
//                                             ),
//                                             filled: true,
//                                             fillColor: const Color(0xFFFAFAFA)),
//                                       )),
//                                   // IconButton(
//                                   //     onPressed: () {},
//                                   //     icon: Image.asset(
//                                   //       'images/message_icon/camera.png',
//                                   //       height: 27,
//                                   //     )),
//                                   IconButton(
//                                       onPressed: () {
//                                    //     print(widget.applyid+widget.jobid+ widget.recvid+widget.senderid);
//                                         mess
//                                             .messagesend(
//                                             applyid: applyid,
//                                             jobid: jobid,
//                                             recvid: recvid,
//                                             senderid: senderid,
//                                             message: messageController.text,
//                                             photo: "")
//                                             .then((value){
//                                           messageController.clear();
//
//                                         });
//                                       },
//                                       icon: Icon(Icons.send))
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//
//
//
//
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             );
//
//
//         }
//         else{
//           return
//             Scaffold(
//
//               body:
//               SingleChildScrollView(
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Container(
//                       height:size.height *0.3,
//                       width: size.width,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         image: DecorationImage(image: AssetImage(
//                             "assets/profileImage.png"
//                         ),
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
//
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 40),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             IconButton(onPressed: (){
//                               Navigator.pop(context);
//                             }, icon: Icon(Icons.arrow_back_ios,size: 28,color: Colors.white,),),
//                             Text('Ralph Edwards',
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 )),
//                             PopupMenuButton(
//                               padding: EdgeInsets.all(0),
//                               // onOpened: (){
//                               //   if(selected==3){
//                               //     newPage(context: context, child: HomePage());
//                               //   }
//                               // },
//
//                               onSelected: (value) {
//                                 // selected=value;
//                                 // print(selected);
//                               },
//                               child: SvgPicture.asset(
//                                 "assets/menuImage.svg",
//                                 color: Colors.black,
//                                 height: 22,
//                                 width: 16,
//                               ),
//                               itemBuilder: (context) {
//                                 return [];
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only( top: size.height*0.15,),
//
//                       child: Container(
//                         height: size.height*0.83,
//                         width: size.width,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(topRight:Radius.circular(30) ,topLeft: Radius.circular(30)),
//                           image: DecorationImage(image: AssetImage("assets/backgroundImage.png",),
//                             fit: BoxFit.cover,),
//                         ),
//                         child:
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                                 height: size.height*0.75,
//                                 width: size.width,
//                                 child: Center(
//                                   child: Text("There is no message"),
//                                 )
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: const Color(0xFFF6F6F6),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.black.withOpacity(0.5),
//                                         blurRadius: 1)
//                                   ]),
//                               child: Row(
//                                 children: [
//
//                                   Flexible(
//                                       child: TextFormField(
//                                         controller: messageController,
//                                         decoration: InputDecoration(
//                                             isDense: true,
//                                             contentPadding:
//                                             const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                                             border: OutlineInputBorder(
//                                               borderSide:
//                                               const BorderSide(color: Color(0xFFCFCFD0)),
//                                               borderRadius: BorderRadius.circular(50),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide:
//                                               const BorderSide(color: Color(0xFFCFCFD0)),
//                                               borderRadius: BorderRadius.circular(50),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide:
//                                               const BorderSide(color: Color(0xFFCFCFD0)),
//                                               borderRadius: BorderRadius.circular(50),
//                                             ),
//                                             filled: true,
//                                             fillColor: const Color(0xFFFAFAFA)),
//                                       )),
//                                   // IconButton(
//                                   //     onPressed: () {},
//                                   //     icon: Image.asset(
//                                   //       'images/message_icon/camera.png',
//                                   //       height: 27,
//                                   //     )),
//                                   IconButton(
//                                       onPressed: () {
//                                       //  print(widget.applyid+widget.jobid+ widget.recvid+widget.senderid);
//                                         mess
//                                             .messagesend(
//                                             applyid:applyid,
//                                             jobid: jobid,
//                                             recvid: recvid,
//                                             senderid: senderid,
//                                             message: messageController.text,
//                                             photo: "")
//                                             .then((value){
//                                           messageController.clear();
//
//                                         });
//                                       },
//                                       icon: Icon(Icons.send))
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//
//
//
//
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             );
//
//
//
//         }
//
//
//       },
//     );
//   }
//   Widget listMessage3(Messagelist? data) {
//     // var box = Hive.box('login');
//     // final mess = Provider.of<MessageProvider>(context);
//     // data!.msg!.sort((a, b) => b.messageId!.compareTo(a.messageId!));
//     return  GroupedListView<Msg, DateTime>(elements: data!.msg!, groupBy: (m)=>DateTime(m.createdAt!.year,
//       m.createdAt!.month,
//       m.createdAt!.day,
//     ),
//       groupHeaderBuilder: (Msg m)=>  SizedBox(
//         height: 40,
//         child:
//         Row(
//           children: [
//             Expanded(child: const Divider(height: 5,thickness: 1.0, indent: 10,endIndent: 10,color: Colors.grey,)),
//             Text(DateFormat.yMMMEd().format(m.createdAt!), style: TextStyle(
//                 color: Colors.grey
//             ),),
//             Expanded(child: const Divider(height: 5,thickness: 1.0, indent: 10,endIndent: 10,color: Colors.grey,)),
//           ],
//         ),
//       ),
//       reverse: true,
//       order: GroupedListOrder.DESC,
//       itemBuilder: (context,Msg m){
//         return
//           m.receiverUserId == recvid ?  Padding(
//             padding: const EdgeInsets.only(left: 15,right: 15,top: 22),
//             child: Container(
//               //  height: size.height*0.25,
//               constraints: const BoxConstraints(
//                   minHeight: 40, minWidth: 55),
//               decoration:BoxDecoration(
//                   color: Color(0xffEFEFEF),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(22),
//                     topRight:  Radius.circular(22),
//                     bottomRight:  Radius.circular(22),)
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 5),
//                     child: CircleAvatar(
//                       radius: 15,
//                       backgroundColor: Colors.cyan,
//                     ),
//                   ),
//                   SizedBox(width: 5,),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 8),
//                       child: Text('For athletes, high altitude produces two contradictory effects on performance. For explosive events (sprints up to 400 metres, long jump, triple jump) the reduction in atmospheric pressure means there is less resistance.',
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 12,
//                           )),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 10,bottom: 7),
//                     child: Text("২ মিনিট",
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontFamily: 'IrabotiMJ',
//                         )),
//                   )
//
//
//                 ],
//               ),
//             ),
//           ) :  Padding(
//             padding: const EdgeInsets.only(left: 15,right: 15,top: 22),
//             child: Container(
//               //  height: size.height*0.25,
//               constraints: const BoxConstraints(
//                   minHeight: 40, minWidth: 55),
//               decoration:BoxDecoration(
//                   color: Color(0xffEFEFEF),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(22),
//                     topRight:  Radius.circular(22),
//                     bottomRight:  Radius.circular(22),)
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 5),
//                     child: CircleAvatar(
//                       radius: 15,
//                       backgroundColor: Colors.cyan,
//                     ),
//                   ),
//                   SizedBox(width: 5,),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 8),
//                       child: Text('For athletes, high altitude produces two contradictory effects on performance. For explosive events (sprints up to 400 metres, long jump, triple jump) the reduction in atmospheric pressure means there is less resistance.',
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 12,
//                           )),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 10,bottom: 7),
//                     child: Text("২ মিনিট",
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontFamily: 'IrabotiMJ',
//                         )),
//                   )
//
//
//                 ],
//               ),
//             ),
//           );
//
//
//
//       },
//
//     );
//   }
// }
