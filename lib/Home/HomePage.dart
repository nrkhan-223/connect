import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/Const/route.dart';
import 'package:connect/link_add/link_add_page.dart';
import 'package:connect/widget/drawer_widget.dart';
import 'package:connect/widget/postlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import '../Const/const.dart';
import '../Skeleton/CategorySkeleton.dart';
import '../controllar/categoric_controllar/categoric_controllar.dart';
import '../controllar/joblist_controllar/joblist_controllar.dart';
import '../controllar/userprofileController/userProfileController.dart';
import '../searchpage/searchpage.dart';
import '../widget/categoryWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool show = false;
  var load = false;
  var lastPage = false;
  var tigarPage = 3;
  var error = false;
  ScrollController scrollController = ScrollController();
  Future loding() async {
    setState(() {
      load = true;
    });
    final controller = Provider.of<CategoricContrllar>(context, listen: false);
    await controller.getCategoric();

    final joblistcontroller =
        Provider.of<JobListControllar>(context, listen: false);
    await joblistcontroller.fetchData();
  }
  Future refresh() async {
    final joblistcontroller =
        Provider.of<JobListControllar>(context, listen: false);
    await joblistcontroller.reset();
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  void _scrollListener() {
    final provider = Provider.of<JobListControllar>(context, listen: false);
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !provider.isLoading) {
      provider.fetchData();
    }
  }
  @override
  void initState() {
    final controller = Provider.of<CategoricContrllar>(context, listen: false);
    scrollController.addListener
      (_scrollListener);
    if (controller.catagoriclist.msg == null) {
      loding().then((value) {
        setState(() {
          load = false;
        });
      });
    }

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    var profileData = profile.profile!.msg!.userData;
    print('ProfileData:$profileData');

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78), // Set this height
          child: Stack(
            children: [
              Container(
                height: size.height *0.22,
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
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 15),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading:profileData!.pic == null?Container(
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
                  ) ,
                  // leading: Container(
                  //     height: 60.h,
                  //     width: 60.w,
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         image: profileData!.pic == null
                  //             ? const DecorationImage(
                  //                 image: AssetImage("assets/unnamed.png"),
                  //               )
                  //             : DecorationImage(
                  //                 fit: BoxFit.cover,
                  //                 image: NetworkImage(
                  //                     "$media${profileData.pic}"),
                  //
                  //               ))),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profileData.fullName!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          )),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(profileData.phone!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 11.sp,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                      ),
                      child: InkWell(
                          onTap: () {
                            scaffoldKey.currentState!.openEndDrawer();
                            print('hello drawer');
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 25,
                          )),
                    )
                  ],
                ),
              ),

            ],
          )
      ),
      endDrawer: Drawer(
        width: size.width.w,
        child: const SingleChildScrollView(child: DrawerWidget()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          newPage(context: context, child: const LinkAddPage());
        },
        child: SvgPicture.asset("assets/addLink.svg"),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          controller: scrollController,
          //controller: joblistcontroller.scrollController,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: size.height.h,
                width: size.width.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/backgroundImage.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: (size.height * 0.11).h,
                width: size.width.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/profileImage.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(20).w,
                      bottomRight: const Radius.circular(20).w),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: size.height * 0.04,
                    ).r,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15).w),
                      child: load ? categorySkeleton() : const CategoryWidget(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<JobListControllar>(builder: (context, provider, _) {
                    return provider.data.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: (size.height * 0.1).h,
                              width: size.width.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).w,
                              ),
                              child: const Center(
                                child: Text("There is no link",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                          )
                        : ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: provider.data.length + 1,
                            itemBuilder: (context, index) {
                              if (index < provider.data.length) {
                                final item = provider.data[index];
                                return PostListWidget(
                                  hedarText: "${item.jobTitle}",
                                  procolpo: "${item.category}",
                                  postTime: item.createdAt!,
                                  postName: "${item.createdByName}",
                                  home: true,
                                  connectId: "${item.jobId}",
                                  discription: "${item.description}",
                                  audio: item.doc!.audio!.isEmpty
                                      ? ""
                                      : item.doc!.audio![0],
                                  video: item.doc!.video!.isEmpty
                                      ? ""
                                      : item.doc!.video![0],
                                  image: item.doc!.image!,
                                  ownerId: item.createdBy!,
                                  shareLink: item.sharelink!,
                                  userID: "${item.createdBy}",
                                );
                              } else {
                                if (provider.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                else if(provider.isError){
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      onPressed: provider.fetchData,
                                      child: const Text('No more data'),
                                    ),
                                  );
                                }
                                else {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      onPressed: provider.fetchData,
                                      child: const Text('Load More'),
                                    ),
                                  );
                                }
                              }
                            },
                          );
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
