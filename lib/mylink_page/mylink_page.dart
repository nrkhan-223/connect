import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/model/mylinkModel/my-apply_link_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import '../Const/const.dart';
import '../Const/route.dart';
import '../Skeleton/PostListSkeleton.dart';
import '../controllar/myLink_controller/myLink_controller.dart';
import '../controllar/userprofileController/userProfileController.dart';
import '../link_add/link_add_page.dart';
import '../model/getpic_model.dart';
import '../network/joblit_repo/joblist_repo.dart';
import '../searchpage/searchpage.dart';
import '../widget/applylist_widget.dart';
import '../widget/drawer_widget.dart';
import '../widget/postlist_widget.dart';
import 'package:http/http.dart' as http;

class MyLinkPage extends StatefulWidget {
  const MyLinkPage({super.key});

  @override
  State<MyLinkPage> createState() => _MyLinkPageState();
}

class _MyLinkPageState extends State<MyLinkPage> {

  List<PopupMenuEntry<dynamic>> list = [];

  var load = false;

  Future loadLink() async {
    setState(() {
      load = true;
    });
    final controller = Provider.of<MyLinkContrllar>(context, listen: false);
    await controller.getMyLink();
  }

  var selectColor = 0;
  List tab = ["আমার লিংক", "আমার আবেদন"];
  List<MyApply> applys = [];

  Future<List<MyApply>> getApply() async {
    var box = Hive.box('login');
    var response = await http.get(Uri.parse(
        "https://linkapp.xyz/api/user/userapply/${box.get('userid')}"));
    final body = response.body;
    final json = jsonDecode(body.toString());
    final result = json['msg'] as List<dynamic>;
    if (response.statusCode == 200) {
      applys.clear();
      for (Map i in result) {
        applys.add(MyApply.fromJson(i as Map<String, dynamic>));
      }
      return applys;
    } else {
      return applys;
    }
  }

  refresh() async {
    final controller = Provider.of<MyLinkContrllar>(context, listen: false);
    await controller.getMyLink();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MyLinkContrllar>(context, listen: true);
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    var size = MediaQuery.of(context).size;
    var profileData = profile.profile!.msg!.userData;

    List tabPage = [
      Consumer<MyLinkContrllar>(builder: (context, value, child) {
        value.getMyLink();
        return value.loader
            ? postListSkeleton(size, false)
            : value.mylinkList != null
                ? ListView.builder(
                    itemCount: value.mylinkList!.msg!.length,
                    // padding:  EdgeInsets.only( top: size.height*0.05,),
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      var data = value.mylinkList!.msg![index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: PostListWidget(
                          delete: () {
                            //print("tappp");
                            JobListRepository()
                                .removeJob(jobid: data.jobId)
                                .then((value1) async {
                              // controller.mylinkList!.msg!
                              //     .removeAt(widget.index!);
                              setState(() {});
                              await value.getMyLink();
                            });
                          },
                          hedarText: "${data.jobTitle}",
                          procolpo: "${data.category}",
                          postTime: DateTime.parse("${data.createdAt}"),
                          postName: "${data.createdByName}",
                          connectId: "${data.jobId}",
                          home: false,
                          discription: "${data.description}",
                          audio: data.doc!.audio!.isEmpty
                              ? ""
                              : data.doc!.audio![0],
                          video: data.doc!.video!.isEmpty
                              ? ""
                              : data.doc!.video![0],
                          image: data.doc!.image!,
                          ownerId: data.createdBy!,
                          index: index,
                          shareLink: "",
                          userID: data.createdBy!,
                        ),
                      );
                    })
                : Padding(
                    padding: EdgeInsets.only(top: size.height * 0.5),
                    child: Container(
                      height: size.height * 0.1,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text("There is no link",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                            )),
                      ),
                    ),
                  );
      }),
      FutureBuilder(
          future: getApply(),
          builder: (context, ss) {
            if (!ss.hasData) {
              return postListSkeleton(size, false);
            } else if (ss.data!.isEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: size.height * 0.5),
                child: Container(
                  height: size.height * 0.1,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text("There is no link",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        )),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: applys.length,
                  itemBuilder: (context, index) {
                    var item = applys[index];

                    return ApplyListWidget(
                      hedarText: item.jobTitle,
                      postTime: DateTime.parse(item.createdAt),
                      connectId: item.jobId,
                      home: false,
                      discription: item.note,
                      audio: item.doc.audio.isEmpty ? "" : item.doc.audio[0],
                      video: item.doc.video.isEmpty ? "" : item.doc.video[0],
                      image: item.doc.image,
                      ownerId: item.ownerId,
                      index: index,
                      shareLink: "",
                      userID: item.userId,
                      procolpo: '',
                      postName: '',
                      applyTime: item.time,
                    );
                  });
            }
          })
    ];

    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        width: size.width,
        child: const SingleChildScrollView(child: DrawerWidget()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          newPage(context: context, child: const LinkAddPage());
        },
        child: SvgPicture.asset("assets/addLink.svg"),
      ),
      body: Stack(
        children: [
          SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(
                "assets/backgroundImage.png",
                fit: BoxFit.cover,
              )),
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: size.height * 0.22,
                      width: size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/profileImage.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.07,
                          ),
                          child: Text('আমার লিংক',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontFamily: 'IrabotiMJ')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: AppBar(
                            toolbarHeight: 50,
                            backgroundColor: Colors.transparent,
                            leading: profileData!.pic == null
                                ? Container(
                                    height: 90.h,
                                    width: 90.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/unnamed.png"),
                                        )

                                        // DecorationImage(
                                        //   fit: BoxFit.cover,
                                        //   image:   NetworkImage("$media${data.pic}"),
                                        // )
                                        ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: "$media${profileData.pic}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 90.h,
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        height: 90.h,
                                        width: 90.w,
                                        shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(50)
                                            .w, // Adjust the border radius as needed
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(profileData.fullName!,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(profileData.phone!,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 11,
                                    )),
                              ],
                            ),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                ),
                                child: InkWell(
                                    onTap: () {
                                      newPage(
                                          context: context,
                                          child: const SearchPage());
                                    },
                                    child: SvgPicture.asset(
                                      "assets/search.svg",
                                      height: 20,
                                      width: 20,
                                    )),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                  onTap: () {
                                    scaffoldKey.currentState!.openEndDrawer();
                                  },
                                  child: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 25,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(14))
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < tab.length; i++)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectColor = i;
                                          });
                                        },
                                        child: Container(
                                          height: size.height * 0.07,
                                          width: size.width / 2.1,
                                          decoration: BoxDecoration(
                                              color: selectColor == i
                                                  ? Colors.red
                                                  : Colors.white.withOpacity(0.6),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(14))),
                                          child: Center(
                                            child: Text("${tab[i]}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: selectColor == i
                                                        ? Colors.white
                                                        : Colors.red,
                                                    fontSize: 14,
                                                    fontFamily: 'IrabotiMJ')),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(seconds: 1),
                              child: tabPage[selectColor],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
