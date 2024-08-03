import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:provider/provider.dart';
import '../Const/route.dart';
import '../controllar/addlinkPage_controllar/addlinkPage_controllar.dart';
import '../controllar/categoric_controllar/categoric_controllar.dart';
import 'package:path/path.dart' as join;
import 'dart:io';
import '../network/NotificationSend/Notification.dart';
import '../network/fileUpload/upload.dart';
import '../searchpage/searchpage.dart';
import '../user_profile/user_profile.dart';
import 'Audio.dart';

class ApplyLinkPage extends StatefulWidget {
  final String jobId;
  final String time;
  final String category;
  final String ownerId;
  final String title;
  final String ownerName;

  const ApplyLinkPage({
    super.key,
    required this.jobId,
    required this.ownerId,
    required this.title,
    required this.ownerName,
    required this.time,
    required this.category,
  });

  @override
  State<ApplyLinkPage> createState() => _ApplyLinkPageState();
}

class _ApplyLinkPageState extends State<ApplyLinkPage> {
  UploadFile fileUpload = UploadFile();
  File? audioFile;
  String documents = "";
  TextEditingController note = TextEditingController();
  var category = "1";
  var selected = "বড় প্রকল্প সমূহ";
  List<Media> mediaList = [];
  String time = "অনির্ধারিত";
  Color color = Colors.white;
  Color color1 = Colors.white;
  Color color2 = Colors.white;
  Color color3 = Colors.white;

  Color l1= Colors.red;
  Color l2=Colors.red;
  Color l3=Colors.red;
  Color l4=Colors.red;


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
  final ImagePicker imagePicker = ImagePicker();
  List<File> pImageList = [];

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
            l2=Colors.green;
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

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    setState(() {});
    isAudioUpload;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddLinkControllar>(context, listen: false)
          .changeColor(Colors.grey);
    });
    // TODO: implement initState
    super.initState();
  }

  List<String> imageName = [];

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddLinkControllar>(context, listen: true);
    final categoryController =
        Provider.of<CategoricContrllar>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
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
          title: const Text('প্রস্তাবনা পাঠান',
              style: TextStyle(
                  color: Colors.red, fontSize: 18, fontFamily: 'IrabotiMJ')),
          actions: [
            InkWell(
                onTap: () {
                  newPage(context: context, child: const SearchPage());
                },
                child: SvgPicture.asset(
                  "assets/search.svg",
                  height: 20,
                  color: Colors.red,
                  width: 20,
                )),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Stack(
          children: [
            const SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: size.width - 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14).w,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(.1, 2.5), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white38),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/icon/logo2.png",
                                    scale: 4.4,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.title,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: const Color(0xffF2F3F4)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        widget.category,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: "Post: ",
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.3),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                        text: widget.time,
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ))
                                  ])),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      newPage(
                                          context: context,
                                          child: UserProfilePage(
                                              id: widget.ownerId));
                                    },
                                    child: Text(
                                      widget.ownerName,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.3),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "কানেক্ট আইডি ",
                                        style: TextStyle(
                                          color: Colors.red.withOpacity(0.6),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'IrabotiMJ',
                                        )),
                                    TextSpan(
                                      text: widget.jobId,
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          color: Colors.red.withOpacity(0.6),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                    )
                                  ])),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('নিচের তথ্যগুলো পূরণ করুন',
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('১.কাজটি করতে কেমন সময় লাগবে?',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.5.sp,
                                    fontFamily: 'IrabotiMJ')),
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
                                dropdownBuilder: (context, selectedItem) {
                                  return Text(
                                    selectedItem!,
                                    style: const TextStyle(
                                        fontFamily: 'Kalpurush'),
                                  );
                                },
                                popupProps: const PopupProps.menu(),
                                items: const [
                                  "অনির্ধারিত",
                                  "২ দিনের মত",
                                  "৪ দিনের মত",
                                  "১ সপ্তাহ",
                                  '২ সপ্তাহ',
                                  '৩ সপ্তাহ',
                                  '১ মাস',
                                  '2 মাস'
                                ],
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    textAlign: TextAlign.left,
                                    dropdownSearchDecoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(12).w,
                                        border: InputBorder.none)),
                                selectedItem: "সিলেক্ট করুন !",
                                onChanged: (value) {
                                  setState(() {
                                    time = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('  ২. ছবি/ভিডিও/অডিও যুক্ত করুন',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.5.sp,
                                    fontFamily: 'IrabotiMJ')),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          // const Divider(
                          //   height: 3,
                          //   thickness: 1.5,
                          //   endIndent: 10,
                          //   indent: 10,
                          // ),
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
                                      var file =
                                          await controller.picVideoFIle();
                                      if (file != null) {
                                        var joinpath = join.basename(file.path);
                                        var check = await fileUpload
                                            .uploaddile(file.path);
                                        if (check != null || check == true) {
                                          setState(() {
                                            color = Colors.red;
                                            l1=Colors.green;
                                          });
                                        }
                                        print("DDDD>>$joinpath");
                                      }
                                    },
                                    child: Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: color,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: const Center(
                                        child: Icon(
                                          Icons.video_camera_back_outlined,
                                          size: 30,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: -12,
                                      top: -5,
                                      child: CircleAvatar(
                                          radius: 13.w,
                                          backgroundColor: l1,
                                          child:l1==Colors.red? const Icon(
                                            Icons.add,
                                            size: 22,
                                            color: Colors.white,
                                          ):const Icon(
                                            Icons.done,
                                            size: 22,
                                            color: Colors.white,
                                          )
                                      ))
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                            child: l2==Colors.red? const Icon(
                                              Icons.add,
                                              size: 22,
                                              color: Colors.white,
                                            ):const Icon(
                                              Icons.done,
                                              size: 22,
                                              color: Colors.white,
                                            )
                                        ))
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
                                          isAudioUpload = false;
                                          color2 = Colors.red;
                                          l3=Colors.green;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: color2,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: const Center(
                                          child: Icon(
                                        Icons.mic_sharp,
                                        color: Colors.greenAccent,
                                        size: 30,
                                      )),
                                    ),
                                  ),
                                  Positioned(
                                      right: -12,
                                      top: -5,
                                      child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: l3,
                                          child: l3==Colors.red? const Icon(
                                            Icons.add,
                                            size: 22,
                                            color: Colors.white,
                                          ):const Icon(
                                            Icons.done,
                                            size: 22,
                                            color: Colors.white,
                                          )
                                      ))
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
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('৩. বর্ণনা যোগ করুন',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'IrabotiMJ',
                                  color: Colors.red,
                                  fontSize: 14.5.sp,
                                )),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: note,
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                              style: const TextStyle(
                                  fontSize: 14, color: Color(0xff3E4040)),
                              decoration: InputDecoration(
                                hintText:
                                    'সংযুক্তি সম্পর্কে আপনার নোট লিখুন....',
                                hintStyle: const TextStyle(
                                    fontSize: 13, color: Color(0xff3E4040)),
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
                          SizedBox(
                            height: 20.h,
                          ),
                          InkWell(
                            onTap: () async {
                              var box = Hive.box("login");
                              controller
                                  .applyLink(
                                      category: category,
                                      time: time,
                                      jobid: widget.jobId,
                                      ownerId: widget.ownerId,
                                      imageName: imageName,
                                      note: note.text)
                                  .then((value) {
                                NotificationRepo().notificationSend(
                                    type: 'new_apply',
                                    content:
                                        "${box.get("name")} apply your job",
                                    receiverId: widget.ownerId);
                                Navigator.pop(context);

                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                height: 41.h,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(51),
                                    color: Colors.red),
                                child: const Center(
                                  child: Text('প্রস্তাবনা পাঠান',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'IrabotiMJ')),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
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
      ),
    );
  }

  void RecoderButtomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const RecordExample();
        });
  }
}
