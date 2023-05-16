import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'color_constants.dart';


class PrimaryButton extends StatelessWidget {

  PrimaryButton({ required this.title, required this.onAction});


  String title;
  var onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:6.h,
      width:100.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.deppp),
        onPressed:onAction,
        child:Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 11.sp,fontWeight:FontWeight.bold,fontFamily:"railLight"),textAlign: TextAlign.center,
        ),
      ),
    );
  }

}