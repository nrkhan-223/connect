



import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../controllar/myLink_controller/myLink_controller.dart';

Widget postListSkeleton( Size size, bool search) {
  return Padding(
    padding:
    search?EdgeInsets.zero:
    EdgeInsets.only(left: 20,top: size.height*0.05, right: 20, bottom: 5),
    child: ListView.builder(
        itemCount:2,
        shrinkWrap: true,
        primary: false,
        itemBuilder:(context,index)
        {
          return  Padding(
              padding: const EdgeInsets.only(top: 10),
child: Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child:
      SkeletonParagraph(
        style: SkeletonParagraphStyle(
            lines: 1,
            spacing: 2,
            lineStyle: SkeletonLineStyle(
              randomLength: true,
              height: 20,
              borderRadius: BorderRadius.circular(8),
              minLength: MediaQuery.of(context).size.width / 2,
            )),
      ),

    ),
    SizedBox(height: 12),
    Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 1,
                spacing: 2,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 20,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 2,
                )),
          ),
        ),
        Expanded(
          child: SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 1,
                spacing: 2,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 20,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 25,
                )),
          ),
        ),
      ],
    ),
    Row(
      children: [
        Expanded(
          child: SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 1,
                spacing: 2,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 20,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 25,
                )),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 1,
                spacing: 2,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 20,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 25,
                )),
          ),
        ),


      ],
    ),
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child:

        SkeletonLine(
          style: SkeletonLineStyle(
              height:150,
              width: size.width,
              borderRadius: BorderRadius.circular(8)),
        )
    ),

    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: size.height * 0.22,
        width: size.width,
        // color: Color(0xffD9D9D9),
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: size.height * 0.22,
                  width: 180,
                  borderRadius: BorderRadius.circular(8)),
            ),
            SizedBox(width: 10,),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: size.height * 0.22,
                  width: 180,
                  borderRadius: BorderRadius.circular(8)),
            ),
            SizedBox(width: 10,),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: size.height * 0.22,
                  width: 180,
                  borderRadius: BorderRadius.circular(8)),
            ),
          ],
        ),
      ),
    ),

  ],
),

          );
        }),
  );
}