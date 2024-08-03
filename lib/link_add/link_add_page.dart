import 'dart:developer';
import 'package:connect/controllar/userprofileController/userProfileController.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../controllar/addlinkPage_controllar/addlinkPage_controllar.dart';
import '../controllar/categoric_controllar/categoric_controllar.dart';
import 'package:path/path.dart' as join;
import '../controllar/myLink_controller/myLink_controller.dart';
import '../network/fileUpload/upload.dart';
import 'Audio.dart';
import 'dart:io';

class LinkAddPage extends StatefulWidget {
  const LinkAddPage({super.key});

  @override
  State<LinkAddPage> createState() => _LinkAddPageState();
}

class _LinkAddPageState extends State<LinkAddPage> {
  UploadFile fileUpload = UploadFile();
  FocusNode focusNode = FocusNode();

  final ImagePicker imagePicker = ImagePicker();
  List<File> pImageList = [];
  String documents = "";

  imagepik() async {
    final pickedFile = await imagePicker.pickMultiImage(
        imageQuality: 70, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        pImageList.add(File(xfilePick[i].path));
        upload();
      }
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
  }

  upload() async {
    if (pImageList.isNotEmpty) {
      List<String> data = [];
      for (var a in pImageList) {
        //print(a);
        log(a.path);
        await fileUpload.uploaddile(a.path).then((value) {
          if (value != null) {
            color1 = Colors.red;
            l2 = Colors.green;
            setState(() {});
          }
        });
        setState(() {
          data.add(a.path);
          imageName.add('\"${join.basename(a.path)}\"');
        });
      }
      print("Image Data$data");
    }
  }

  filePick() async {
    FilePickerResult? document = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'xlsx'],
    );
    if (document != null) {
      File file = File(document.files.single.path!);
      var path = join.basename(file.path);
      documents = path;
      await fileUpload.uploaddile(file.path).then((v) {
        color3 = Colors.red;
        l4 = Colors.green;
        documents = path;
        setState(() {});
      });
      log("file:$path");
      log("path:${file.path}");
      // await fileUpload.uploaddile(file.path).then(onValue)
    }
  }

  List icone = [
    Icons.video_call,
  ];
  var category = "1";
  var selected = "সিলেক্ট করুন";

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Color color = Colors.white;
  Color color1 = Colors.white;
  Color color2 = Colors.white;
  Color color3 = Colors.white;

  Color l1 = Colors.red;
  Color l2 = Colors.red;
  Color l3 = Colors.red;
  Color l4 = Colors.red;
  var enable = false;

  @override
  void initState() {
    isAudioUpload;
    // focusNode.addListener(onFocusChange);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final profile = Provider.of<ProfileProvider>(context, listen: false);
      Provider.of<AddLinkControllar>(context, listen: false)
          .changeColor(Colors.grey);
      Provider.of<AddLinkControllar>(context, listen: false)
          .changContact(profile.profile!.msg!.userData!.phone);
    });
    // loding();
    requestPermission(Permission.manageExternalStorage);

    // TODO: implement initState
    super.initState();
  }

  List<String> imageName = [];

  @override
  void dispose() {
    pImageList.clear();
    // print("dispos data");
    // final controllerdis =
    //     Provider.of<AddLinkControllar>(context, listen: false);
    // controllerdis.linkTitleController.clear();

    print("dispose data2");
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddLinkControllar>(context, listen: true);
    final controller2 = Provider.of<MyLinkContrllar>(context, listen: false);

    final categoryController =
        Provider.of<CategoricContrllar>(context, listen: true);
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10).r,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.w,
              color: Colors.black,
            ),
          ),
        ),
        title: Text('লিংক যুক্ত করুন',
            style: TextStyle(
                color: Colors.red, fontSize: 18.sp, fontFamily: 'IrabotiMJ')),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 20.h,
          ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10).r,
                  child: Container(
                    // height: size.height*0.85,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16).w,
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('প্রয়োজনীয় তথ্যগুলো সংযুক্ত করুন',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18.sp,
                                  fontFamily: 'IrabotiMJ')),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15).r,
                          child: Text('১. ক্যাটাগরিস',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: 50.h,
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5).w,
                                color: const Color(0xffFAFAFA),
                                border: Border.all(color: Colors.grey)),
                            child: DropdownSearch<String>(
                              selectedItem: selected,
                              popupProps: const PopupProps.menu(),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                  textAlign: TextAlign.left,
                                  dropdownSearchDecoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.all(12).r,
                                      border: InputBorder.none)),
                              items: categoryController.catagoriclist.msg!
                                  .map((e) => e.catName!)
                                  .toList(),
                              onChanged: (value) {
                                for (var i = 0;
                                    i <
                                        categoryController
                                            .catagoriclist.msg!.length;
                                    i++) {
                                  if (categoryController
                                          .catagoriclist.msg![i].catName ==
                                      value) {
                                    setState(() {
                                      category = categoryController
                                          .catagoriclist.msg![i].catId!;
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15).r,
                          child: Text('২. শিরোনাম',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15).r,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            //  focusNode: focusNode,
                            autofocus: false,
                            controller: controller.linkTitleController,
                            maxLines: 20,
                            minLines: 3,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff3E4040)),
                            decoration: InputDecoration(
                              hintText: 'এখানে আপনার শিরোনাম লিখুন...',
                              hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xff3E4040)),
                              filled: true,
                              fillColor: const Color(0xffFAFAFA),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.w)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15).r,
                          child: Text('৩. বর্ণনা দিন',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            controller: controller.descriptionController,
                            keyboardType: TextInputType.text,
                            maxLines: 50,
                            minLines: 8,
                            autofocus: false,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff3E4040)),
                            decoration: InputDecoration(
                              hintText:
                                  'এখানে আপনার প্রকল্প সম্পর্কে কিছু বিবরণ লিখুন....',
                              hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xff3E4040)),
                              filled: true,
                              fillColor: const Color(0xffFAFAFA),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.w)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(
                          height: 3.h,
                          thickness: 1.5,
                          endIndent: 10,
                          indent: 10,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('ছবি/ভিডিও/অডিও যুক্ত করুন',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18.sp,
                                  fontFamily: 'IrabotiMJ')),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              clipBehavior: Clip.none,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var file = await controller.picVideoFIle();
                                    if (file != null) {
                                      var joinpath = join.basename(file.path);
                                      var check = await fileUpload
                                          .uploaddile(file.path);
                                      log(":path:${file.path}");
                                      log(":joinpath:$joinpath");
                                      if (check != null) {
                                        color = Colors.red;
                                        l1 = Colors.green;
                                        setState(() {});
                                      }
                                      print("DDDD>>$joinpath");
                                    }
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5).w,
                                        color: color,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: const Center(
                                        child: Icon(
                                      Icons.video_camera_back_outlined,
                                      size: 30,
                                      color: Colors.greenAccent,
                                    )),
                                  ),
                                ),
                                Positioned(
                                    right: -12,
                                    top: -5,
                                    child: CircleAvatar(
                                        radius: 13.w,
                                        backgroundColor: l1,
                                        child: l1 == Colors.red
                                            ? const Icon(
                                                Icons.add,
                                                size: 22,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons.done,
                                                size: 22,
                                                color: Colors.white,
                                              )))
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                imagepik();
                              },
                              child: Stack(
                                alignment: Alignment.topRight,
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: color1,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: const Center(
                                        child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 30,
                                      color: Colors.greenAccent,
                                    )),
                                  ),
                                  Positioned(
                                      right: -12,
                                      top: -5,
                                      child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: l2,
                                          child: l2 == Colors.red
                                              ? const Icon(
                                                  Icons.add,
                                                  size: 22,
                                                  color: Colors.white,
                                                )
                                              : const Icon(
                                                  Icons.done,
                                                  size: 22,
                                                  color: Colors.white,
                                                )))
                                ],
                              ),
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              clipBehavior: Clip.none,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    // RecoderButtomSheet();

                                    var r = await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return const RecordExample();
                                        });
                                    if (r == "r") {
                                      setState(() {});
                                    }
                                    if (isAudioUpload) {
                                      log(isAudioUpload.toString());
                                      setState(() {
                                        color2 = Colors.red;
                                        l3 = Colors.green;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: color2,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: const Center(
                                        child: Icon(
                                      Icons.mic_sharp,
                                      size: 30,
                                      color: Colors.greenAccent,
                                    )),
                                  ),
                                ),
                                Positioned(
                                    right: -12,
                                    top: -5,
                                    child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor: l3,
                                        child: l3 == Colors.red
                                            ? const Icon(
                                                Icons.add,
                                                size: 22,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons.done,
                                                size: 22,
                                                color: Colors.white,
                                              )))
                              ],
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              clipBehavior: Clip.none,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    filePick();
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: color3,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: const Center(
                                        child: Icon(
                                      Icons.file_present,
                                      size: 30,
                                      color: Colors.greenAccent,
                                    )),
                                  ),
                                ),
                                Positioned(
                                    right: -12,
                                    top: -5,
                                    child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor: l4,
                                        child: l4 == Colors.red
                                            ? const Icon(
                                                Icons.add,
                                                size: 22,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons.done,
                                                size: 22,
                                                color: Colors.white,
                                              )))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 3.h,
                          thickness: 1.5,
                          endIndent: 10,
                          indent: 10,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Contact Number',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                enable = !enable;
                                setState(() {});
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text('পরিবর্তন করুন',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            controller: controller.contactNumberController,
                            keyboardType: TextInputType.text,
                            enabled: enable,
                            style: TextStyle(
                                fontSize: 14,
                                color: enable
                                    ? const Color(0xff3E4040)
                                    : Colors.grey),
                            decoration: InputDecoration(
                              hintText: 'Put your number here',
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Color(0xff3E4040)),
                              filled: true,
                              fillColor: const Color(0xffFAFAFA),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            var r;
                            await controller.getFile(documents);
                           r= await controller
                                .createLink(category, imageName)
                                .then((value) async {

                              await controller2.getMyLink();
                              Navigator.pop(context);
                            });
                            log(r.toString());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              height: 41,
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(51),
                                  color: Colors.red),
                              child: const Center(
                                child: Text('সাবমিট',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'IrabotiMJ')),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

// void RecoderButtomSheet() {
//   showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(20), topLeft: Radius.circular(20))),
//       builder: (context) {
//         return const RecordExample();
//       });
// }
}
