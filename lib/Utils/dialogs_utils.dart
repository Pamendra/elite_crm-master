
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'PrimaryButton.dart';
import 'TextWidgets.dart';
import 'color_constants.dart';


class Dialogs {
  static successDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                backgroundColor: ColorConstants.deppp,
                titlePadding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 5),
                actionsPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                title: Text('Case Management',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "medium",
                    )),
                actions: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        subheadingTextBOLD(
                            title: "Case successfully cancelled"),
                        const SizedBox(
                          height: 15,
                        ),
                        const Center(
                            child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                        const SizedBox(
                          height: 30,
                        ),
                        PrimaryButton(
                            title: "Continue",
                            onAction: () {
                              Navigator.pop(context);
                              Navigator.pop(context, true);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                      ])
                ],
              )); //call the alert dart
        });
  }

  static showValidationMessage(BuildContext context, String title) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: ColorConstants.deppp, width: 2)),
            backgroundColor: Colors.black87,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        subheadingText(
                          title: 'Message',
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear,
                            color: ColorConstants.primaryColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    subheadingText(title: "$title"),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
