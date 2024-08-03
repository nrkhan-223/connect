import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

Widget searchUserSkeleton(Size size) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Container(
      height: size.height * 0.15,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    shape: BoxShape.circle, width: 50, height: 50)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 1,
                      spacing: 2,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 18,
                        borderRadius: BorderRadius.circular(8),
                        minLength: size.width / 2,
                      )),
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 1,
                      spacing: 2,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 18,
                        borderRadius: BorderRadius.circular(8),
                        minLength: size.width / 2,
                      )),
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}
