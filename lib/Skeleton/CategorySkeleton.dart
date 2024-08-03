
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

Widget categorySkeleton(){

  return  GridView.builder(
      primary: false,
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 0.65
      ),
      itemCount:3,
      itemBuilder: (context, index){
        return  Column(
          children:  [
            const SkeletonAvatar(
                style: SkeletonAvatarStyle(width: 45, height: 45)),
            SizedBox(height: 3,),
            SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 1,
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 20,
                    borderRadius: BorderRadius.circular(8),
                    minLength: MediaQuery.of(context).size.width / 2,
                  )),
            ),
            SizedBox(height: 8,),
          ],
        );
      });
}