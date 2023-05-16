// ignore_for_file: use_build_context_synchronously

import 'package:elite_crm/Screens/AddReport/Existing_Leaad.dart';
import 'package:elite_crm/Screens/Homepage.dart';
import 'package:elite_crm/Screens/LoginScreen/login_screen.dart';
import 'package:elite_crm/Screens/User_profile.dart';
import 'package:elite_crm/Utils/setget.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';


import '../Screens/bottomNavigationPages.dart';
import 'PrimaryButton.dart';
import 'TextWidgets.dart';
import 'color_constants.dart';
import 'drawertextbox.dart';
import 'images_constants.dart';






class DrawerLogout extends StatelessWidget {
  const DrawerLogout({Key? key}) : super(key: key);

  openAppInfoDialog(BuildContext context) async {
    String user = await Utils().getUsername();
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
            backgroundColor: ColorConstants.white,
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
                        title: "User:", subtitle:user
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Drawer(
          backgroundColor: ColorConstants.Darkopacity,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 50,
              ),
              ListTile(
                leading: const Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListTile(
                  shape: Border(
                      bottom: BorderSide(
                        color: ColorConstants.backgroundappColor,
                      )),
                  title:const Text('Home Page', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage()));

                  },
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   child: ListTile(
              //     shape: Border(
              //         bottom: BorderSide(
              //           color: ColorConstants.backgroundappColor,
              //         )),
              //     title:const Text('Profile', style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 17,
              //         color: Colors.white),),
              //     onTap: (){
              //      Navigator.push(context, MaterialPageRoute(builder: (context) => userprofile_pages()));
              //
              //     },
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListTile(
                  shape: Border(
                      bottom: BorderSide(
                        color: ColorConstants.backgroundappColor,
                      )),
                  title:const Text('Add Report', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white),),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddReport()),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                    shape: Border(
                        bottom: BorderSide(
                          color: ColorConstants.backgroundappColor,
                        )),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ),
                    onTap: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                              (Route route) => false);
                    }
                    ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        shape: Border(
                            bottom: BorderSide(
                              color: ColorConstants.backgroundappColor,
                            ),top:BorderSide(
                          color: ColorConstants.backgroundappColor,
                        ) ),
                        title:const Text('App Information', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white),),
                        onTap: (){
                          openAppInfoDialog(context);
                        },
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    boxtextSmall(title: "Powered By:"),
                    SizedBox(height: 1.h,),
                    Image.asset(
                      ImageConstants.logoURl,
                      height:5.h,
                      width: 50.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}