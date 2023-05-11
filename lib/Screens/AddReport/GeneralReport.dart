


import 'package:elite_crm/Screens/AddReport/CustomerReport.dart';
import 'package:elite_crm/Service/Existing%20List%20Service.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'Existing_Leaad.dart';

class GeneralReport extends StatefulWidget {
  const GeneralReport({Key? key}) : super(key: key);

  @override
  State<GeneralReport> createState() => _GeneralReportState();
}

class _GeneralReportState extends State<GeneralReport> {
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
                    MaterialPageRoute(builder: (context) => const AddReport()),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomerReport()),
                  );
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
              const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children:  [
                        CircleAvatar(
                          backgroundColor: ColorConstants.DarkBlueColor,
                          child: const Text('2',style: TextStyle(color: Colors.white),),
                        ),
                        const SizedBox(width: 70,),
                        const Text('General Report',style: TextStyle(fontSize: 21),),
                      ],
                    ),
                  ),
              const SizedBox(height: 20,),

              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('This is the general lead specific information to be included in this report.',style: TextStyle(fontSize: 14),),
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                                height: MediaQuery.of(context)
                                    .copyWith()
                                    .size
                                    .height *
                                    0.40,
                                color: ColorConstants.lightWhite,
                                child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    minimumYear:
                                    DateTime.now().year - 5,
                                    maximumYear: DateTime.now().year,
                                    maximumDate: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    initialDateTime: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    onDateTimeChanged: (newDateTime) {
                                      setState(() {
                                        displayDate = DateFormat(
                                            "EEEE, MMMM d, yyyy")
                                            .format(newDateTime);
                                        inspectionDate = DateFormat(
                                            "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                            .format(newDateTime);
                                      });
                                    }));
                          });
                    },
                    child: Container(
                      width: 95.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              displayDate == ""
                                  ? inspectionDate.toString()
                                  : displayDate.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(
                              CupertinoIcons.calendar,
                              color: ColorConstants.deppp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(5),
                        border:
                        Border.all(color: Colors.black)),
                    child: Scrollbar(
                      controller: _scrollController,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: "railLight"),
                        //controller: report,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'General Report',
                          hintStyle: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey,
                              fontFamily: "railLight",),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding:
                          const EdgeInsets.all(10),
                          fillColor: Colors.white,
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
