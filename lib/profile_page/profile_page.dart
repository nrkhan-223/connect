import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/Const/route.dart';
import 'package:connect/mylink_page/my_apply_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import '../Const/const.dart';
import '../controllar/categoric_controllar/categoric_controllar.dart';
import '../controllar/userprofileController/userProfileController.dart';
import '../link_add/link_add_page.dart';
import '../membership/membershipPage.dart';
import '../widget/drawer_widget.dart';
import 'edit_pro_pic.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var chack = 0;
  var show = 6;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    final categoryController =
        Provider.of<CategoricContrllar>(context, listen: false);
    var data = profile.profile!.msg!.userData!;
    var startAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(profile.profile!.msg!.membership!.startDate ?? "00000") *
            1000);
    var endDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(profile.profile!.msg!.membership!.endDate ?? "00000") * 1000);
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), // Set this height
          child: Stack(
            children: [
              Container(
                height: size.height * 0.10,
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
                title: const Text('প্রোফাইল',
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: size.height,
                width: size.width,
                child: Image.asset(
                  "assets/backgroundImage.png",
                  fit: BoxFit.cover,
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.33,
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
                      padding: EdgeInsets.only(
                        top: size.height * 0.19,
                        left: 15,
                        right: 15,
                      ).r,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: size.height * 0.35,
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20).w,
                                color: Colors.white),
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Text('${data.fullName}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text('${data.profileTagline}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/phone.svg",
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10.h,
                                      ),
                                      Text('${data.phone}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.h,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/email.svg",
                                        height: 12.h,
                                        width: 15.w,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text('${data.email}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    newPage(
                                        context: context,
                                        child: const EditProfilePage());
                                  },
                                  child: Container(
                                    height: 41,
                                    width: 171,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.red,
                                        border: Border.all(
                                            color: Colors.red, width: 1.w)),
                                    child: Center(
                                      child: Text('এডিট প্রোফাইল',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'IrabotiMJ',
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              top: -size.height * 0.125,
                              child: Image.asset(
                                "assets/icon/logo2.png",
                                scale: 4,
                              )),
                          Positioned(
                            top: -size.height * 0.068,
                            child: data.pic == null
                                ? Container(
                                    height: 90.h,
                                    width: 90.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/unnamed.png"),
                                        )),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: "$media${data.pic}",
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
                          ),
                          Positioned(
                              top: -size.height * 0.01,
                              right: size.width * 0.3,
                              child: InkWell(
                                onTap: () {
                                  // newPage(context: context, child: ChangeProfilePic());
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) => const ChangeProfilePic());
                                },
                                child: CircleAvatar(
                                  radius: 19.w,
                                  backgroundColor: const Color(0xffD9D9D9),
                                  child: const Center(
                                      child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 25,
                                    color: Colors.black,
                                  )),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 20),
                                      child: Text('ক্যাটাগরী',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontFamily: 'IrabotiMJ',
                                          )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const CategoryDialog());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15, top: 20),
                                        child: SvgPicture.asset(
                                          "assets/write.svg",
                                          height: 19,
                                          width: 21,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                GridView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0.2,
                                            mainAxisSpacing: 0.2,
                                            childAspectRatio: 2),
                                    itemCount:
                                        show > profile.servicesByName.length
                                            ? profile.servicesByName.length
                                            : show,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Container(
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.red,
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                        profile.servicesByName[
                                                            index],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'IrabotiMJ',
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -15,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                if (show ==
                                        categoryController
                                            .catagoriclist.msg!.length ||
                                    show >
                                        categoryController
                                            .catagoriclist.msg!.length) {
                                  setState(() {
                                    show = 6;
                                  });
                                } else {
                                  setState(() {
                                    show = show + 6;
                                  });
                                }
                              },
                              child: show ==
                                          categoryController
                                              .catagoriclist.msg!.length ||
                                      show >
                                          categoryController
                                              .catagoriclist.msg!.length
                                  ? CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.3),
                                      child: Center(
                                          child: SvgPicture.asset(
                                        "assets/more2.svg",
                                        height: 30,
                                        width: 30,
                                      )))
                                  : CircleAvatar(
                                      radius: 16,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.2),
                                      child: Center(
                                          child: SvgPicture.asset(
                                        "assets/more.svg",
                                        height: 30,
                                        width: 30,
                                      ))),
                            ),
                          ),

                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    width: 428,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, color: Color(0x21F44336)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'মেম্বারশীপ এরিয়া',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (profile.profile!.msg!.membership!.packageName !=
                            null)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'প্যাকেজ: ${profile.profile!.msg!.membership!.packageName ?? "কোন প্যাকেজ সক্রিয় নেই"}',
                                      style: const TextStyle(
                                        color: Color(0xFFF44336),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: size.height * 0.163,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Color(0xFFD2D2D2)),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFD2D2D2)),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'মেয়াদ শুরু ',
                                                  style: TextStyle(
                                                    color: Color(0xFF040404),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 104),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  DateFormat('MMM dd, yyyy')
                                                      .format(startAt),
                                                  style: const TextStyle(
                                                    color: Color(0xFF242424),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFD2D2D2)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'মেয়াদ শেষ',
                                                  style: TextStyle(
                                                    color: Color(0xFF040404),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 104),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  DateFormat('MMM dd, yyyy')
                                                      .format(endDate),
                                                  style: const TextStyle(
                                                    color: Color(0xFF242424),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFD2D2D2)),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(4),
                                            bottomRight: Radius.circular(4),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'অটো রিনিউ',
                                                  style: TextStyle(
                                                    color: Color(0xFF040404),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 131),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  profile
                                                              .profile!
                                                              .msg!
                                                              .membership!
                                                              .status! ==
                                                          "1"
                                                      ? "বন্ধ"
                                                      : "চালু",
                                                  style: const TextStyle(
                                                    color: Color(0xFF242424),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            newPage(
                                context: context,
                                child: MemberShipPage(
                                  mambershipName: profile.profile?.msg!
                                          .membership!.packageName ??
                                      "",
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF44336),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'মেম্বারশিপ উন্নত করুন',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({super.key});

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  List<String> animaleint2 = [];

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    final categoryController =
        Provider.of<CategoricContrllar>(context, listen: false);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Wrap(
                  children: List.generate(
                      categoryController.catagoriclist.msg!.length, (index) {
                    return InkWell(
                      onTap: () {
                        // if (userprevilies.userPrevilies != null &&
                        //     userprevilies.userPrevilies!.msg!.category !=
                        //         animaleint2.length) {
                        if (animaleint2.contains(categoryController
                            .catagoriclist.msg![index].catId)) {
                          setState(() {
                            animaleint2.remove(categoryController
                                .catagoriclist.msg![index].catId);
                          });
                        } else {
                          setState(() {
                            animaleint2.add(categoryController
                                .catagoriclist.msg![index].catId!);
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: animaleint2.contains(categoryController
                                    .catagoriclist.msg![index].catId)
                                ? Colors.red
                                : Colors.grey[200]),
                        child: Text(
                          categoryController.catagoriclist.msg![index].catName!,
                          style: TextStyle(
                              color: animaleint2.contains(categoryController
                                      .catagoriclist.msg![index].catId)
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: 'Kalpurush'),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  profile
                      .profileUpdate(
                    company: "",
                    confirmpass: "",
                    name: "",
                    newpass: "",
                    oldpass: "",
                    phone: "",
                    pic: "",
                    servicearea: animaleint2,
                    profiletag: "",
                  )
                      .then((value) {
                    profile.getProfileInfo();
                        Navigator.pop(context);

                  });
                },
                child: const Text(
                  "সাবমিট",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
