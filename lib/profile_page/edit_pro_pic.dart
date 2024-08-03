import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/Const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../controllar/userprofileController/userProfileController.dart';
import 'package:path/path.dart' as join1;

import '../network/fileUpload/upload.dart';

class ChangeProfilePic extends StatefulWidget {
  const ChangeProfilePic({Key? key}) : super(key: key);

  @override
  State<ChangeProfilePic> createState() => _ChangeProfilePicState();
}
class _ChangeProfilePicState extends State<ChangeProfilePic> {
  XFile? imageFile;
  String? proPic;
  UploadFile fileUpload = UploadFile();
  Future<XFile?> pickImage(ImageSource source) async {
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    final XFile? galleryImage = await ImagePicker().pickImage(source: source);

    if (galleryImage != null) {
      imageFile = galleryImage;
      fileUpload.uploaddile(galleryImage.path);

      proPic = join1.basename(imageFile!.path);

      profile
          .profileUpdate(
        company: "",
        confirmpass: "",
        name: "",
        newpass: "",
        oldpass: "",
        phone: "",
        pic: "$proPic",
        servicearea: [],
        profiletag: "",
      )
          .then((value) {
        profile.getProfileInfo();
      });

      print(proPic);
      setState(() {});
      return imageFile!;
    } else {
      return XFile("");
    }
    // return videoFIle!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    var data = profile.profile!.msg!.userData!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE51D20),
        elevation: 0,
        title: const Text("এডিট প্রোফাইল",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'IrabotiMJ',
            )),
        centerTitle: true,
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
          Container(
            height: size.height * 0.12,
            width: size.width,
            decoration: const BoxDecoration(color: Color(0xffE51D20)),
          ),
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.38,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: data.pic == null
                      ? Container(
                          height: 90.h,
                          width: 90.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/unnamed.png"),
                              )

                              // DecorationImage(
                              //   fit: BoxFit.cover,
                              //   image:   NetworkImage("$media${data.pic}"),
                              // )
                              ),
                        )
                      : CachedNetworkImage(
                          imageUrl: "$media${data.pic}",
                          imageBuilder: (context, imageProvider) => Container(
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
                          placeholder: (context, url) => SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              height: 90.h,
                              width: 90.w,
                              shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(50)
                                  .w, // Adjust the border radius as needed
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                ),
                SizedBox(
                  height: 15,
                ),
                const Center(
                  child: Text("ছবি পরিবর্তন করুন",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'IrabotiMJ',
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.25,
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          pickImage(ImageSource.gallery);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xffE51D20),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          width: size.width * 0.35,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                    backgroundColor: Color(0xffB50003),
                                    radius: 22,
                                    child: SvgPicture.asset(
                                        "assets/gallarypic.svg")),
                                const Text("গ্যালারী",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'IrabotiMJ',
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pickImage(ImageSource.camera);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xffE51D20),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          width: size.width * 0.35,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                    backgroundColor: const Color(0xffB50003),
                                    radius: 22,
                                    child: SvgPicture.asset(
                                        "assets/propiccamera.svg")),
                                const Text("ক্যামেরা",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'IrabotiMJ',
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
