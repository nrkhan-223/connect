import 'package:connect/Const/const.dart';
import 'package:connect/Const/route.dart';
import 'package:connect/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import '../model/SearchCategoricModel/searchCategoric.dart';
import '../Skeleton/PostListSkeleton.dart';
import '../Skeleton/SearchUserSkeleton.dart';
import '../model/SearchJobModel/SearchJobModel.dart';
import '../model/SearchUserModel/SearchModelUser.dart';
import '../network/SearchNetwork/SearchNetWork.dart';
import '../widget/postlist_widget.dart';
import 'linkSearchPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List tab = ["লিংক", "পিপল", "ক্যাটাগরি"];

  String userKeyWord = "";

  var selectColor = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List tabPage = [
      FutureBuilder<SearchJobModel?>(
          future: SearchNetWork().getSearchLink(keyword: userKeyWord, type: 1),
          builder: (context, ss) {
            if (ss.connectionState == ConnectionState.waiting) {
              return postListSkeleton(size, true);
            } else if (ss.hasData) {
              var dataList = ss.data!.msg;
              return ListView.builder(
                  itemCount: dataList!.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = dataList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        child: PostListWidget(
                          hedarText: data.jobTitle!,
                          procolpo: data.category!,
                          postTime: data.createdAt!,
                          postName: data.createdByName!,
                          connectId: data.jobId!,
                          discription: data.description!,
                          audio: "",
                          video: '',
                          image: const [],
                          home: true,
                          ownerId: data.createdBy!,
                          shareLink: data.sharelink!,
                          userID: data.createdBy!,
                        ),
                      ),
                    );
                  });
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text("No data")),
              );
            }
          }),
      FutureBuilder<SearchUserModel?>(
          future: SearchNetWork().getSearchUser(keyword: userKeyWord, type: 2),
          builder: (context, ss) {
            if (ss.connectionState == ConnectionState.waiting) {
              return searchUserSkeleton(size);
            } else if (ss.hasData) {
              var dataList = ss.data!.msg;
              return ListView.builder(
                  itemCount: dataList!.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = dataList[index];
                    return InkWell(
                        onTap: () {
                          newPage(
                              context: context,
                              child: UserProfilePage(
                                id: data['user_id']!,
                              ));
                        },
                        child: LinkSearchPageWidget(
                          name: data["full_name"]!,
                          tagline: data["profile_tagline"]!,
                          proPic: data["pic"] ?? "",
                          userId: data['user_id']!,
                        ));
                  });
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text("No data")),
              );
            }
          }),
      FutureBuilder<ScarchCategoricModel?>(
          future:
              SearchNetWork().getSearchCateGory(keyword: userKeyWord, type: 3),
          builder: (context, ss) {
            if (ss.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (ss.hasData) {
              var dataList = ss.data!.msg;
              return ListView.builder(
                  itemCount: dataList!.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = dataList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("$media${data.image}"),
                      ),
                      title: Text(data.catName!,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: 'IrabotiMJ')),
                    );
                  });
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text("No data")),
              );
            }
          }),
    ];
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            )),
        title: const Text('খুজুন',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontFamily: 'IrabotiMJ')),
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
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey.withOpacity(0.2))),
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            userKeyWord = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //new commet this code
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius:
                            const BorderRadius.all(
                                Radius.circular(14))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  width: size.width /3.27,
                                  decoration: BoxDecoration(
                                      color: selectColor == i
                                          ? Colors.red
                                          : Colors.white.withOpacity(0.8),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(14))),
                                  child: Center(
                                    child: Text("${tab[i]}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: selectColor == i
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'IrabotiMJ')),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: tabPage[selectColor],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
