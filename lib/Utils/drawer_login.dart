// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';

import 'PrimaryButton.dart';
import 'TextWidgets.dart';
import 'color_constants.dart';
import 'drawertextbox.dart';
import 'images_constants.dart';


class DrawerLogin extends StatelessWidget {
    const DrawerLogin({Key? key}) : super(key: key);


    openAppInfoDialog(BuildContext context) async {
     // String user = await Utils().getUsername();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;


      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(

                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  side: BorderSide(
                      color: ColorConstants.deppp, width: 2
                  )),
              backgroundColor: ColorConstants.DarkBlueColor,
              insetPadding: const EdgeInsets.all(20),

              actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      "App Information",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15.sp,
                          color: Colors.white),
                    ),
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DialogTextbox2(
                          title: "User:", subtitle:'Not Logged In'
                      ),
                      DialogTextbox2(title: "App Version:", subtitle: version),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                                title: "Close",
                                onAction: () {
                                  Navigator.pop(context, true);
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                )
              ],
            );
          });
    }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.DarkBlueColor,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:6.h,),

                  GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child:const Icon(Icons.clear,color: Colors.white,)),

                  SizedBox(height: 2.h,),

                  ListTile(
                    title: subheadingTextBOLD(title: "Login"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  Divider(color:ColorConstants.backgroundappColor,),
                  ListTile(
                    title: subheadingTextBOLD(title: "App Information"),
                    onTap: () {
                      openAppInfoDialog(context);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  Divider(color:ColorConstants.backgroundappColor,),
                ],
              ),
              Column(

                children: [


                  SizedBox(height: 2.h,),
                  boxtextSmall(title: "Powered By:"),
                  SizedBox(height: 1.h,),
                  Image.asset(
                    ImageConstants.logoURl,
                    height:5.h,
                    width: 100.h,
                    fit: BoxFit.scaleDown,
                  ),
                  // SizedBox(height: 1.h,),
                  // boxtextSmall(title: "® Tracsis plc"),
                  // SizedBox(height: 2.h,),
                ],
              )


            ],
          )),
    );
  }
}
