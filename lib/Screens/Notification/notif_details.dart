


import 'package:elite_crm/Screens/Notification/notification%20page.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Service/AddReport Service.dart';



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
        Title = notification.title;
        Description = notification.desc;
        Link = notification.links;
        Docs = notification.docs;
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
      appBar: AppBar(
        title: const Center(child: Text('Notification Details')),
        backgroundColor: ColorConstants.deppp,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 100.w,
                  height: 5.8.h,
                  color: ColorConstants.deppp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size:20.sp,
                      ),
                      const Text( "Go Back", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),),

                    ],
                  ),
                )),
          ]),
      body: Title.isNotEmpty
          ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50,),
                    Text(
                      'Title: ${Title ?? ''}',style: const TextStyle(
                        fontSize: 20.0,
                        color:Colors.black,
                        letterSpacing: 2.0,

                        fontWeight: FontWeight.w800
                    ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description: ${Description ?? ''}'
                      ,style: const TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        color:Colors.black,

                        fontWeight: FontWeight.w600
                    ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Link: ${Link ?? ''}'
                      ,style: const TextStyle(
                        fontSize: 20.0,
                        color:Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600
                    ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Document: ${Docs ?? ''}'
                      ,style: const TextStyle(
                        fontSize: 20.0,
                        color:Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }

}
