

import 'package:flutter/material.dart';

import '../Skeleton/PostListSkeleton.dart';
import '../model/CategoryJobMode/categoryJobModel.dart';
import '../network/categoryJobRepo/categoryJobRepo.dart';
import '../widget/postlist_widget.dart';
class CategoryJobView extends StatefulWidget {
  final String catId;
  final String catName;
  const CategoryJobView({super.key, required this.catId, required this.catName});
  @override
  State<CategoryJobView> createState() => _CategoryJobViewState();
}
class _CategoryJobViewState extends State<CategoryJobView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
            widget.catName,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'IrabotiMJ',
                color: Colors.black
            )
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },

            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          ),
        ),
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
                // AppBar(
                //   elevation: 0,
                //   backgroundColor: Colors.transparent,
                //   title: Text(
                //       widget.catName,
                //       textAlign: TextAlign.start,
                //       style: TextStyle(
                //           fontSize: 18,
                //           fontFamily: 'IrabotiMJ',
                //         color: Colors.black
                //       )
                //   ),
                //   centerTitle: true,
                //   leading: Padding(
                //     padding: const EdgeInsets.only(left: 20),
                //     child: IconButton(
                //       onPressed: (){
                //         Navigator.pop(context);
                //       },
                //
                //       icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20,),
                FutureBuilder<CategoryJobModel?>(
                  future:
                  CategoryJobRepo().getCategoryJob(widget.catId),
                  builder: (context, ss) {
                    if (ss.connectionState == ConnectionState.waiting) {
                      return postListSkeleton(size, true);
                    } else if (ss.hasData) {
                      var dataList = ss.data!.msg!;
                      return Padding(
                         padding:EdgeInsets.only(left: 5, right: 5,),
                         child: ListView.builder(
                             itemCount: dataList.length,
                             primary: false,
                             shrinkWrap: true,
                             padding: EdgeInsets.zero,
                             itemBuilder: (context, index){

                               var data = dataList[index];
                               return  PostListWidget(
                                 hedarText: "${data.jobTitle}",
                                 procolpo: "${data.category}",
                                 postTime: DateTime.parse("${data.createdAt}"),
                                 postName: "${data.createdByName}",
                                 home: true,
                                 connectId: "${data.jobId}",
                                 discription: "${data.description}", audio: data.doc!.audio!.isEmpty?"":data.doc!.audio![0], video: data.doc!.video!.isEmpty?"":data.doc!.video![0], image: data.doc!.image!, ownerId: data.createdBy!, shareLink:data.sharelink!, userID: data.createdBy!,

                               );

                         }),
                       );
                    } else {
                      return Center(
                        child: Text("No Job found"),
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
