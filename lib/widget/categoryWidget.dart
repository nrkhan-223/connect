import 'package:connect/Const/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../CategoryJobView/CategoryJobView.dart';
import '../Const/const.dart';
import '../controllar/categoric_controllar/categoric_controllar.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}
class _CategoryWidgetState extends State<CategoryWidget> {
  var show =3;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoricContrllar>(context, listen: false);

    return Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GridView.builder(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 0),
              // physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 1),
               itemCount:  controller.catagoriclist.msg!.length ,
              itemBuilder: (context, index) {
                var data = controller.catagoriclist.msg![index];

                return InkWell(
                  onTap: () {
                    newPage(
                        context: context,
                        child: CategoryJobView(
                          catId: data.catId!, catName: data.catName!,
                        ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23.w,
                        backgroundColor: Colors.red,
                        child: Center(
                            child: SvgPicture.network(
                          "$categoryMedia/${data.image}",
                          fit: BoxFit.cover,
                          height: 23.h,
                          width:23.w,
                          color: Colors.white,
                        )),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text("${data.catName}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontFamily: 'IrabotiMJ',
                          )),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                );
              }),
          // Positioned(
          //   bottom: -14,
          //   child: Row(
          //     children: [
          //     show!=controller.catagoriclist.msg!.length ?InkWell(
          //       onTap: (){
          //         print('fff');
          //         if( show == controller.catagoriclist.msg!.length || show > controller.catagoriclist.msg!.length) {
          //           setState(() {
          //             show = 3;
          //           });
          //         }
          //         else{
          //           setState(() {
          //             show = show +9;
          //           });
          //         }
          //
          //       },
          //         child: CircleAvatar(
          //           radius: 16,
          //             backgroundColor: Colors.grey.withOpacity(0.2),
          //             child: Center(child: SvgPicture.asset("assets/more.svg",height: 22,width: 22,))))
          //     // IconButton(
          //     //   icon: Icon(
          //     //     Icons.arrow_circle_down,
          //     //     //   show == controller.catagoriclist.msg!.length || show > controller.catagoriclist.msg!.length ? Icons.arrow_circle_up : Icons.arrow_circle_down,
          //     //     color: Colors.red.withOpacity(0.5),
          //     //   ),
          //     //   onPressed: () {
          //     //     if( show == controller.catagoriclist.msg!.length || show > controller.catagoriclist.msg!.length) {
          //     //       setState(() {
          //     //         show = 3;
          //     //       });
          //     //     }
          //     //     else{
          //     //       setState(() {
          //     //         show = show +3;
          //     //       });
          //     //     }
          //     //   },
          //     // )
          //         :const SizedBox(),
          //      const SizedBox(width: 15,),
          //
          //      show !=3? InkWell(
          //          onTap: (){
          //            setState(() {
          //              show = show -3;
          //            });
          //
          //          },
          //          child: CircleAvatar(
          //              radius: 15,
          //              backgroundColor: Colors.grey.withOpacity(0.3),
          //              child: Center(child: SvgPicture.asset("assets/more2.svg",height: 22,width: 22,))))
          //
          //      // IconButton(
          //      //    icon: Icon(
          //      //      Icons.arrow_circle_up,
          //      //      //   show == controller.catagoriclist.msg!.length || show > controller.catagoriclist.msg!.length ? Icons.arrow_circle_up : Icons.arrow_circle_down,
          //      //      color: Colors.red.withOpacity(0.5),
          //      //    ),
          //      //    onPressed: () {
          //      //      setState(() {
          //      //        show = show -3;
          //      //      });
          //      //      // if( show == controller.catagoriclist.msg!.length || show > controller.catagoriclist.msg!.length) {
          //      //      //   setState(() {
          //      //      //     show = 3;
          //      //      //   });
          //      //      // }
          //      //      // else{
          //      //      //   setState(() {
          //      //      //     show = show -3;
          //      //      //   });
          //      //      // }
          //      //    },
          //      //  )
          //
          //          :const SizedBox(),
          //     ],
          //   ),
          //
          // ),

          // Positioned(
          //   bottom: -20,
          //   left:10,
          //   child: IconButton(
          //     icon: Icon(
          //       show == controller.catagoriclist.msg!.length || show > controller.catagoriclist.msg!.length ? Icons.arrow_circle_up : Icons.arrow_circle_down,
          //       color: Colors.red,
          //     ),
          //     onPressed: () {
          //       if( show == controller.catagoriclist.msg!.length || show > controller.catagoriclist.msg!.length) {
          //         setState(() {
          //           show = 3;
          //         });
          //       }
          //       else{
          //         setState(() {
          //           show = show -3;
          //         });
          //       }
          //     },
          //   ),
          // ),
        ]);
  }
}
