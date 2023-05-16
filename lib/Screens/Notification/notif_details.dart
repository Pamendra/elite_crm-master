

import 'package:sizer/sizer.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Service/AddReport Service.dart';
import '../../Utils/gradient_color.dart';


class NotificationPage extends StatefulWidget {
  String id;
  NotificationPage({required this.id});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  String Title = '';
  String Description = '';
  String Link = '';
  String Docs = '';

  Future<void> _getUserDetails() async {
    String id = widget.id;
    AddReportService().fetchData(id).then((notification) {
      setState(() {
        Title = '${notification.title}';
        Description = '${notification.desc}';
        Link = '${notification.links}';
        Docs = '${notification.docs}';
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


        bottomNavigationBar: Row(children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: 100.w,
                height: 6.8.h,
                color: ColorConstants.blueGrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(" Go Back", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      color: ColorConstants.white
                    ),)
                  ],
                ),
              )),

        ]),


        appBar: AppBar(
          title: Text('Notification'),
          actions: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 213, 85, 40),
        ),


        body: SingleChildScrollView(


          child: Container(
            height: 100.h,
            decoration: gradient_login,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),

              child: Column(

                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  const SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(


                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Container(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title:  Text(
                                  'Title :   $Title',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // subtitle: Text(
                                //
                                //   style: const TextStyle(
                                //     fontSize: 18,
                                //
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.white,
                                //   ),
                                // ),
                              ),
                              const Divider(
                                color: Colors.white,
                                height: 25,
                                thickness: 2,
                                indent: 5,
                                endIndent: 5,
                              ),
                              ListTile(
                                title:  const Text(
                                  'Description : ',
                                  style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  Description,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                                height: 25,
                                thickness: 2,
                                indent: 5,
                                endIndent: 5,
                              ),

                              ListTile(
                                title: const Text(
                                  'Link :',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                subtitle: Text(
                                  Link,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                ),
                                onTap: () async {

                                  if (await canLaunch(Link)) {
                                    await launch(Link, forceSafariVC: false,
                                        forceWebView: false);
                                  } else {
                                    throw 'Could not launch $Link';
                                  }
                                },
                              ),


                              const Divider(
                                color: Colors.white,
                                height: 25,
                                thickness: 2,
                                indent: 5,
                                endIndent: 5,
                              ),


                            ],
                          ),
                        ),


                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorConstants.white),

                              image: DecorationImage(
                                image: NetworkImage(Docs),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        )
    );
  }
}