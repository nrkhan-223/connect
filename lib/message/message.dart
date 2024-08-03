import 'package:connect/Const/route.dart';
import 'package:connect/message/messagepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../controllar/messageProvider/messageProvider.dart';
import '../link_add/link_add_page.dart';
import '../model/messageListModel/messageList.dart';
import '../widget/drawer_widget.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //  final  drawerController = Provider.of<DrawerControllerdata>(context,listen: false);
    final mess = Provider.of<MessageProvider>(context);

    var box = Hive.box('login');
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50), // Set this height
          child: Stack(
            children: [
              Container(
                height: size.height * 0.14,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/profileImage.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AppBar(
                automaticallyImplyLeading: false,
                title: const Text('বার্তাসমূহ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'IrabotiMJ',
                        color: Colors.white)),
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                actions: [
                  InkWell(
                      onTap: () {
                        scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 25,
                        ),
                      ))
                ],
              ),
            ],
          )),
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          newPage(context: context, child: const LinkAddPage());
        },
        child: SvgPicture.asset("assets/addLink.svg"),
      ),
      endDrawer: Drawer(
        width: size.width,
        child: const SingleChildScrollView(child: DrawerWidget()),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage(
                  "assets/backgroundImage.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: size.height * 0.31,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/profileImage.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 25, top:20, right: 25),
                    //   child: AppBar(
                    //     automaticallyImplyLeading: false,
                    //     title: Text(
                    //         'বার্তাসমূহ',
                    //         textAlign: TextAlign.start,
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontFamily: 'IrabotiMJ'
                    //         )
                    //     ),
                    //     elevation: 0,
                    //     centerTitle: true,
                    //     backgroundColor: Colors.transparent,
                    //     actions: [
                    //       InkWell(
                    //           onTap: (){
                    //             scaffoldKey.currentState!.openEndDrawer();
                    //           },
                    //           child: Icon(Icons.menu,color: Colors.white,size: 25,))
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<MessageBoxlist?>(
                      future: mess.messageboxlist(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          return snapshot.data == null
                              ? const Center(
                                  child: Text("No Message"),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data!.msg!.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data!.msg![index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: InkWell(
                                        onTap: () {
                                          print(data.applyId);
                                          print(data.jobId);
                                          newPage(
                                              context: context,
                                              child: MessagePage(
                                                // name: data.name,
                                                applyid: data.applyId!,
                                                jobid: data.jobId!,
                                                recvid: data.senderId!,
                                                senderid: box.get('userid'),
                                                name: data.name!,
                                                // applyid: '', jobid: '', senderid: '', recvid: '',
                                              ));
                                        },
                                        child: Container(
                                          // height: size.height*0.25,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 3,
                                                blurRadius: 3,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              radius: 13,
                                              backgroundImage:
                                                  NetworkImage(data.photo!),
                                            ),
                                            title: Text(data.name!,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle: Text(data.msg!,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                            trailing: Text(
                                                timeAgo(
                                                    postTime: data.createdAt!),
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'IrabotiMJ',
                                                )),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(top: size.height * 0.45),
                            child: const Center(
                              child: Text("No Massage to show"),
                            ),
                          );
                        }
                      }),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
