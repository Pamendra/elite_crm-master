


import 'package:elite_crm/Screens/AddReport/GeneralReport.dart';
import 'package:elite_crm/Service/Existing%20List%20Service.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'Existing_Leaad.dart';

class CustomerReport extends StatefulWidget {
  const CustomerReport({Key? key}) : super(key: key);

  @override
  State<CustomerReport> createState() => _CustomerReportState();
}

class _CustomerReportState extends State<CustomerReport> {
  final ScrollController _scrollController = ScrollController();
  String? currentdatetime;
  DateTime? selectedDuration;
  String inspectionDate = "";
  String displayDate = "";

  @override
  void initState() {

    selectedDuration = DateTime.now();
    displayDate = DateFormat("EEEE, MMMM d, yyyy").format(selectedDuration!);
    inspectionDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(selectedDuration!);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GeneralReport()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 50.w,
                  height: 5.8.h,
                  color: ColorConstants.deppp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text("Continue "),
                      Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size:20.sp,
                      ),
                      const Text( " Go Back", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const AddReport()),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 50.w,
                  height: 5.8.h,
                  color: ColorConstants.DarkBlueColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      const Text( " Continue", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size:20.sp,
                      ),
                    ],
                  ),
                )),
          ]),
      appBar: AppBar(
        backgroundColor: ColorConstants.deppp,
        title: const Center(child: Text('Add Report')),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children:  [
                    CircleAvatar(
                      child: Text('3',style: TextStyle(color: Colors.white),),
                      backgroundColor: ColorConstants.DarkBlueColor,
                    ),
                    SizedBox(width: 70,),
                    Text('Customer Report',style: TextStyle(fontSize: 21),),
                  ],
                ),
              ),
              const SizedBox(height: 20,),

              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('This is the specific customer report information.If a textarea is left empty a report will still be created.',style: TextStyle(fontSize: 14),),
                  ),
                  const SizedBox(height: 10,),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
