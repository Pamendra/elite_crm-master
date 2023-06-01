


import 'package:elite_crm/Utils/SizedSpace.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: 100.w,
                  height: 5.8.h,
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
            Container(
              decoration:  const BoxDecoration(
                  image: DecorationImage(
                      image:AssetImage('assets/images/back.jpg'),
                      fit: BoxFit.cover
                  )
              ),

              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: const Alignment(-0.9, 4.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(dealerProfile['logo']),
                    radius: 80.0,
                  ),
                ),
              ),
            ),



            const SizedBox(
              height: 80,
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
                    height: 3.h,
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
                    padding: const EdgeInsets.all(10),

                    child: RawMaterialButton(
                      onPressed: () async {
                        _launchPhoneURL(dealerProfile['direct']);
                      },

                      elevation: 2.0,
                      fillColor: ColorConstants.white,
                      padding: const EdgeInsets.all(18.0),
                      child:  Icon(
                        Icons.call,
                        color: ColorConstants.DarkBlueColor,
                        size: 28.0,
                      ),
                    )
                ),

                ///  call end buttton

                ///  gmail_buttton
                Container(
                    padding: const EdgeInsets.all(10),

                    child: RawMaterialButton(
                      onPressed: () async {
                        String email = Uri.encodeComponent(dealerProfile['emailforapp'] );

                        //output: Hello%20Flutter
                        Uri mail = Uri.parse("mailto:$email");
                        if (await launchUrl(mail)) {
                          //email app opened
                        }else{
                          //email app is not opened
                        }
                      },

                      elevation: 2.0,
                      fillColor: ColorConstants.white,
                      padding: const EdgeInsets.all(18.0),
                      child:  Icon(
                        Icons.mail,
                        color: ColorConstants.DarkBlueColor,
                        size: 28.0,
                      ),
                    )
                ),


                ///  gmail_buttton





                Container(
                    padding: const EdgeInsets.all(10),

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
                      padding: const EdgeInsets.all(18.0),
                      child:   Icon(
                        Icons.message,
                        color: ColorConstants.DarkBlueColor,
                        size: 28.0,
                      ),
                    )
                ),


              ],
            ),
            const SizedBox(
              height: 30,
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




