import 'dart:convert';

import 'package:elite_crm/Screens/AddReport/CustomerReport.dart';
import 'package:elite_crm/Screens/bottomNavigationPages.dart';
import 'package:elite_crm/Service/AddReport%20Service.dart';
import 'package:elite_crm/Service/Existing%20List%20Service.dart';
import 'package:elite_crm/Utils/SizedSpace.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/dialogs_utils.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/ApploadingBar.dart';
import '../../Utils/Colors.dart';
import '../../Utils/TextWidgets.dart';
import '../../Utils/drawer_logout.dart';
import '../../Utils/progress_bar.dart';
import '../../Utils/setget.dart';
import '../Notification/Model/detailsModel.dart';
import '../Notification/notification page.dart';
import 'ExistingListDetails.dart';

class AddReport extends StatefulWidget {
  const AddReport({Key? key}) : super(key: key);

  @override
  _AddReportState createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  String? _selectedOption;
  String? _selectedValue;
  String? selectedService;
  TextEditingController _controller = TextEditingController();
  TextEditingController details = TextEditingController();
  List _leads = [];
  String user_id ='';
  final ScrollController _scrollController = ScrollController();
  TextEditingController Greport = TextEditingController();

  String? currentdatetime;
  DateTime? selectedDuration;
  String inspectionDate = "";
  String displayDate = "";
  var Existid = '';
  LeadDetails? ExistData = LeadDetails(name: '', cname: '', gmanager: '', pmanager: '', services: '', status: '', category: '', id: '', details: '');
  String? Date;
  String? Gnote;
  String? Note;
  bool _isLoading = false;

  @override
  void initState() {
    ShoiId();
    // TODO: implement initState
    super.initState();
      }



  Future<void> getExistLead(BuildContext context) async {
    /// Check  Auto route data receving
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>const ExistingListDetails()),);
    setState(() {
      if (result.toString() != "null") {
        ExistData = result;
        Existid =ExistData!.name.toString();
        _controller.text = ExistData!.details.toString();
      } else {
        Existid = '';
      }
    });
  }

  ShoiId() async {
    String shopid = await Utils().getUsererId();
    setState(() {
      user_id = shopid;
    });
    selectedDuration = DateTime.now();
    displayDate = DateFormat(" MMMM d, yyyy").format(selectedDuration!);
    inspectionDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(selectedDuration!);
  }

  Future<dynamic> _openCustomerReportDialog() async {

    String shopid = await Utils().getUsererId();
    setState(() {
      _isLoading = true;
    });
    List<dynamic> reports =  await AddReportService().previousReport(shopid);
    setState(() {
      _isLoading = false;
    });
    reports.sort((a, b) {
      int timeA = int.parse(a['vdate']);
      int timeB = int.parse(b['vdate']);
      return timeB.compareTo(timeA);
    });
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            side: BorderSide(color: ColorConstants.deppp, width: 2),
          ),
          backgroundColor: ColorConstants.DarkBlueColor,
          title: headingText(title: 'Previous Report'),
          content: SizedBox(
            width: double.maxFinite,
            child: Container(
              //color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: reports.length,
                itemBuilder: (BuildContext context, int index) {

                  String date = reports[index]['vdate'];
               //   String note = reports[index]['note'] == null ? 'Null' : reports[index]['note'];
                  String gnote = reports[index]['gnote'] == null ?  'Null': reports[index]['gnote'];
                  int vdateInMillis = int.parse(date);
                  DateTime dateTim = DateTime.fromMillisecondsSinceEpoch(vdateInMillis * 1000);
                  String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTim);


                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingTextwithsmallwhite(title: 'Date: $formattedDateTime'),
                    //  headingTextwithsmallwhite(title: 'Customer Note: $note'),
                      headingTextwithsmallwhite(title: 'General Note: $gnote'),
                      Divider(
                        color: ColorConstants.blueGrey,
                        height: 25,
                        thickness: 2,
                        indent: 0,
                        endIndent: 5,
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog without saving
                  },style:ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.blueGrey
                ) ,
                  child:  Text(
                    'Go Back',
                    style: TextStyle(color: ColorConstants.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.DarkBlueColor,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const Homepage()),
                          (Route route) => false);
                },
                child: Container(
                  width: 50.w,
                  height: 5.8.h,
                  color: ColorConstants.blueGrey,
                  child: Center(child: subheadingTextBOLD(title: 'Cancel',)),
                )),
            InkWell(
                onTap: () {
                 if(displayDate.isNotEmpty && Greport.text.isNotEmpty){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>  CustomerReport(date: displayDate, Greport: Greport, id: ExistData!.id.toString(),
                       name:  ExistData!.name.toString(), cname:  ExistData!.cname.toString(), gmanager:  ExistData!.gmanager.toString(),
                       pmanager:  ExistData!.pmanager.toString(), services:  ExistData!.services.toString(),
                       category:  ExistData!.category.toString(), status:  ExistData!.status.toString(),)),
                   );
                 }else{
                 Dialogs.showValidationMessage(context, 'Please enter General Report');
                 }
                },
                child: Container(
                  width: 50.w,
                  height: 5.8.h,
                  color: ColorConstants.deppp,
                  child: Center(child: subheadingTextBOLD(title: 'Next',)),
                )),
          ]),
      drawer: const DrawerLogout(),
      appBar: AppBar(
        backgroundColor: ColorConstants.deppp,
        title: const Center(child: Text('Add Report')),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const notification()));
              }, icon: const Icon(Icons.notifications))
          )
        ],
      ),
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: .1,
        progressIndicator: const LoadingBar(),
        inAsyncCall: _isLoading ? true : false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding:  EdgeInsets.only(top: 10.sp,left: 16.sp,right: 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          // ProgressBarThin(
                          //     deviceWidth:8.w,
                          //     color:ColorConstants.deppp),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorConstants.deppp,
                                child: const Text(
                                  '1',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height:.3.h,),
                              subheadingText(title: "General")
                            ],
                          ),
                          ProgressBarThin(
                              deviceWidth:8.w,
                              color:ColorConstants.deppp),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorConstants.white,
                                child: const Text(
                                  '2',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(height:.3.h,),
                              subheadingText1(title: "Customer")
                            ],
                          ),
                          ProgressBarThin(
                              deviceWidth:8.w,
                              color:blueGrey),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorConstants.white,
                                child: const Text(
                                  '3',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(height:.3.h,),
                              subheadingText1(title: "Preview")
                            ],
                          ),
                          // ProgressBarThin(
                          //     deviceWidth:8.w,
                          //     color: blueGrey),
                        ],
                      ),

                      const SizedBox(height: 20,),

                    ],
                  ),
                  SmallSpace(),
                    headingTextwithsmallwhite(title: 'Enter the Existing lead'),
                    const SizedBox(height: 3,),
                  GestureDetector(
                    onTap: () {
                      getExistLead(context);
                    },
                    child: Container(
                      width: 95.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.sp),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(6.sp),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Existid == ""
                                  ? "Select Lead"
                                  : '${ExistData!.cname.toString()}',
                              overflow: TextOverflow.ellipsis,
                              style:  TextStyle(fontSize: 10.sp,fontFamily: "railLight"),
                              maxLines: 1,

                            ),
                            Icon(
                              CupertinoIcons.search,
                              color: ColorConstants.appcolor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children:  [
                      MediumSpace(),

                      Column(
                        children: [
                          Container(
                              height: 5.h,
                              color: ColorConstants.DarkBlueColor,
                              child:  Padding(
                                padding:  EdgeInsets.all(2.sp),
                                child: Center(child: Text('This is the general lead specific information to be included in this report.',
                                  style: TextStyle(fontSize: 10.sp,color: Colors.white,fontFamily: "railLight"),)),
                              )),
                          SmallSpace(),
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
                                        color: ColorConstants.white,
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
                                                // displayDate = DateFormat(
                                                //     "EEEE, MMMM d, yyyy")
                                                //     .format(newDateTime);
                                               displayDate = DateFormat("MMMM d, yyyy").format(newDateTime);
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
                                  borderRadius: BorderRadius.circular(3.sp),
                                  border: Border.all(color: Colors.black)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(6.sp),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      displayDate == ""
                                          ? inspectionDate.toString()
                                          : displayDate.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style:  TextStyle(fontSize: 10.sp,fontFamily: "railLight"),
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
                      SmallSpace(),
                      Container(
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(5),
                              border:
                              Border.all(color: Colors.black)),
                          child: Scrollbar(
                            controller: _scrollController,
                            child: TextField(
                              controller: Greport,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontFamily: "railLight"),
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'General Report',
                                hintStyle: TextStyle(color:Colors.grey,fontSize:10.sp,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(3.sp),
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
                      SmallSpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  [
                          InkWell(
                              onTap: (){
                                _openCustomerReportDialog();
                                },
                              child: const Text('Previous Report',style: TextStyle(decoration: TextDecoration.underline,color: Colors.white),))
                        ],
                      )
                    ],
                  ),
                  LargeSpace(),
                  // SizedBox(
                  //   width: 100.w,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //         width: 46.w,
                  //         height: 5.h,
                  //         child: ElevatedButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pushAndRemoveUntil(
                  //                 MaterialPageRoute(
                  //                     builder: (context) => const Homepage()),
                  //                     (Route route) => false);
                  //           },
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: ColorConstants.blueGrey,
                  //           ),
                  //           child:  Text(
                  //             'Cancel',
                  //             style: TextStyle(
                  //               fontSize: 11.sp,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //
                  //         ),
                  //       ),
                  //
                  //
                  //       Container(
                  //         width: 46.w,
                  //         height: 5.h,
                  //         child: ElevatedButton(
                  //           onPressed: () {
                  //             if(displayDate.isNotEmpty && Greport.text.isNotEmpty){
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(builder: (context) =>  CustomerReport(date: displayDate, Greport: Greport, id: ExistData!.id.toString(),
                  //                   name:  ExistData!.name.toString(), cname:  ExistData!.cname.toString(), gmanager:  ExistData!.gmanager.toString(),
                  //                   pmanager:  ExistData!.pmanager.toString(), services:  ExistData!.services.toString(),
                  //                   category:  ExistData!.category.toString(), status:  ExistData!.status.toString(),)),
                  //               );
                  //             }else{
                  //               Dialogs.showValidationMessage(context, 'Please enter General Report');
                  //             }
                  //           },
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: ColorConstants.deppp,
                  //           ),
                  //           child:  Text(
                  //             'Continue',
                  //             style: TextStyle(
                  //               fontSize: 11.sp,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //
                  //         ),
                  //       ),
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                    ],
                  ),
              ),
            ),
          ),
      ),
    );
  }
}
