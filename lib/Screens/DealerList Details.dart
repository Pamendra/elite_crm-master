



import 'package:elite_crm/Utils/SizedSpace.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/color_constants.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';


import '../Utils/ApploadingBar.dart';
import '../Utils/TextWidgets.dart';
import 'bottomNavigationPages.dart';

class DealerDetails extends StatefulWidget {
  String dealerid;
  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cover.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  DealerDetails({super.key, required this.dealerid});

  @override
  State<DealerDetails> createState() => _DealerDetailsState();
}


class _DealerDetailsState extends State<DealerDetails> {
  Map<String, dynamic> dealerProfile = {};
  var currentIndex = 0;
  Future<void> _getDealerProfile(String? dealerid) async {
    var body = {"dealerid": dealerid};

    var formData = FormData.fromMap(body);
    var response = await Dio().post(
        'https://elite-dealers.com/api/dealersprofil.php?dealerid=$dealerid',
        data: formData);

    if (response.statusCode == 200) {
      final responseString = response.data is String
          ? response.data
          : jsonEncode(response.data);
      final Map<String, dynamic> responseBody = json.decode(responseString);

      setState(() {
        dealerProfile = responseBody;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getDealerProfile(widget.dealerid);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstants.DarkBlueColor,
      bottomNavigationBar: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: 100.w,
                  height: 40.sp,
                  color: ColorConstants.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [

                      subheadingTextBOLD(title: 'Go Back',)
                    ],
                  ),
                )),
          ]),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dealers Profile'),
        actions: const [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 213, 85, 40),


      ),
      body: dealerProfile.isNotEmpty
          ?
      SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              children:[ Container(
                height: 20.h,
                decoration:  const BoxDecoration(
                    image: DecorationImage(
                        image:AssetImage('assets/images/back.jpg'),
                        fit: BoxFit.cover
                    )
                ),

                child: Container()
              ),
                SizedBox(height: 2.h,),
                Container(
                  padding: EdgeInsets.only(left: 20.sp),
                  height: 20.h,
                  width: 41.w,
                  alignment:  Alignment(-0.8.sp, 1.5.sp),
                  child: Image.network(dealerProfile['logo']),
                ),
        ]
            ),



             SizedBox(
              height: 8.5.h,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingTextDarkblue(title:  dealerProfile['name'] ?? ''),

                   Divider(
                    color: ColorConstants.blueGrey,
                    height: 25,
                    thickness: 2,
                    indent: 0,
                    endIndent: 5,
                  ),
                   SizedBox(
                    height: 2.h,
                  ),
                  headingTextDarkblueWithSmall(
                   title: dealerProfile['address'] ?? '',
                  ),
                   SizedBox(
                    height: 1.h,
                  ),
                  headingTextDarkblueWithSmall(
                  title: dealerProfile['city'] ?? '',
                  ),

                   SizedBox(
                    height: 1.h,
                  ),
                  headingTextDarkblueWithSmall(
                    title:  dealerProfile['state'] ?? '',
                  ),

                   SizedBox(
                    height: 1.h,
                  ),
                  headingTextDarkblueWithSmall(
                title:   dealerProfile['direct'] ?? '',
                  ),
                ],
              ),
            ),




            LargeSpace(),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:<Widget> [
                Container(
                    padding:  EdgeInsets.all(8.sp),

                    child: RawMaterialButton(
                      onPressed: () async {
                        _launchPhoneURL(dealerProfile['direct']);
                      },

                      elevation: 2.0,
                      fillColor: ColorConstants.white,
                      padding:  EdgeInsets.all(13.sp),
                      child:  Icon(
                        Icons.call,
                        color: ColorConstants.DarkBlueColor,
                        size: 28.0,
                      ),
                    )
                ),


                ///  gmail_buttton
                Container(
                    padding:  EdgeInsets.all(8.sp),

                    child: RawMaterialButton(
                      onPressed: () async {
                        String email = Uri.encodeComponent(dealerProfile['emailforapp'] == null ? " " : dealerProfile['emailforapp'] );

                        Uri mail = Uri.parse("mailto:$email");
                        if (await launchUrl(mail)) {
                          //email app opened
                        }else{
                          //email app is not opened
                        }
                      },

                      elevation: 2.0,
                      fillColor: dealerProfile['emailforapp'] == " " || dealerProfile['emailforapp'] == null ? Colors.grey : ColorConstants.white,
                      padding:  EdgeInsets.all(13.sp),
                      child:  Icon(
                        Icons.mail,
                        color: ColorConstants.DarkBlueColor,
                        size: 28.0,
                      ),
                    )
                ),







                Container(
                    padding:  EdgeInsets.all(8.sp),

                    child: RawMaterialButton(
                      onPressed: () async {

                        Uri sms = Uri.parse('sms:${dealerProfile['direct']}');

                        if (await launchUrl(sms)) {
                          //app opened
                        } else {
                          //app is not opened
                        }
                      },

                      elevation: 2.0,
                      fillColor: ColorConstants.white,
                      padding:  EdgeInsets.all(13.sp),
                      child:   Icon(
                        Icons.message,
                        color: ColorConstants.DarkBlueColor,
                        size: 28.0,
                      ),
                    )
                ),


              ],
            ),
          ],
        ),
      )
          : const Center(child: LoadingBar()),
    );
  }

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}




