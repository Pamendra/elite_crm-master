


import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/color_constants.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';


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
                  height: 6.h,
                  color: ColorConstants.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [

                      Text( " Go Back", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),)
                    ],
                  ),
                )),
          ]),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dealer Profile'),
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
        child: Container(
          height: 100.h,
          decoration: gradient_login,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1550955295-77d6e18a24da?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"
                          ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingTextDarkblue(title:  dealerProfile['name'] ?? ''),

                      const Divider(
                        color: Colors.white,
                        height: 25,
                        thickness: 2,
                        indent: 0,
                        endIndent: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      headingTextDarkblueWithSmall(
                       title: dealerProfile['address'] ?? '',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      headingTextDarkblueWithSmall(
                      title: dealerProfile['city'] ?? '',
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      headingTextDarkblueWithSmall(
                        title:  dealerProfile['state'] ?? '',
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      headingTextDarkblueWithSmall(
                    title:   dealerProfile['direct'] ?? '',
                      ),
                    ],
                  ),
                ),




                SizedBox(
                  height: 50,
                ),



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
          ),
        ),
      )
          : const Center(child: CircularProgressIndicator()),
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




