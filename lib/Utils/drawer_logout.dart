// ignore_for_file: use_build_context_synchronously

import 'package:elite_crm/Screens/AddReport/Existing_Leaad.dart';
import 'package:elite_crm/Screens/Homepage.dart';
import 'package:elite_crm/Screens/LoginScreen/login_screen.dart';
import 'package:elite_crm/Screens/User_profile.dart';
import 'package:elite_crm/Utils/setget.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


import '../Screens/Notification/notification page.dart';
import '../Screens/Splash_Screen/splash_screen.dart';
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


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(

              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(
                  color: ColorConstants.deppp, width: 2
              )),
          backgroundColor: ColorConstants.DarkBlueColor,
          title: headingTextwhite(title: 'Logout'),
          content: headingTextwithsmallwhite(title: 'Are you sure you want to logout?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.blueGrey),
              child:  headingTextwithsmallwhite(title: 'Cancel',),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
                );
              },style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.deppp),
              child: headingTextwithsmallwhite(title: 'Logout',),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Drawer(
          backgroundColor: ColorConstants.DarkBlueColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               SizedBox(
                height: 5.h,
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
                padding:  EdgeInsets.symmetric(horizontal: 6.sp),
                child: ListTile(
                  shape: Border(
                      bottom: BorderSide(
                        color: ColorConstants.backgroundappColor,
                      )),
                  title: Text('Home Page', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
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
                padding:  EdgeInsets.symmetric(horizontal: 6.sp),
                child: ListTile(
                  shape: Border(
                      bottom: BorderSide(
                        color: ColorConstants.backgroundappColor,
                      )),
                  title: Text('Notifications', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: Colors.white),),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const notification()),
                    );
                  },
                ),
              ),
              Container(
                padding:  EdgeInsets.all(6.sp),
                child: ListTile(
                    shape: Border(
                        bottom: BorderSide(
                          color: ColorConstants.backgroundappColor,
                        )),
                    title:  Text(
                      'Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          color: Colors.white),
                    ),
                    onTap: () async {
                      var sharedpref = await SharedPreferences.getInstance();
                      sharedpref.setBool(SplashScreenState.KEYLOGIN, false);
                      _showLogoutDialog(context);
                    }
                    ),
              ),


              Padding(
                padding:  EdgeInsets.only(top: 25.h),
                child: Column(
                  children: [

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 6.sp),
                      child: ListTile(
                        shape: Border(
                            bottom: BorderSide(
                              color: ColorConstants.backgroundappColor,
                            ),top:BorderSide(
                          color: ColorConstants.backgroundappColor,
                        ) ),
                        title: Text('App Information', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
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
