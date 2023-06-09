
import 'dart:async';
import 'package:elite_crm/Bloc/AddReportBloc.dart';
import 'package:elite_crm/Screens/Notification/notification%20page.dart';
import 'package:elite_crm/Screens/bottomNavigationPages.dart';
import 'package:elite_crm/Utils/SizedSpace.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import '../../Service/AddReport Service.dart';
import '../../Utils/ApploadingBar.dart';
import '../../Utils/TextWidgets.dart';
import '../../Utils/dialogs_utils.dart';
import '../../Utils/drawer_logout.dart';
import '../../Utils/progress_bar.dart';
import '../../Utils/setget.dart';

class PreviewReport extends StatefulWidget {
  String date;
  final TextEditingController Greport;
  final List<Map<String, dynamic>> customerLists;
  String? id;
  String? name;
  String? cname;
  String? gmanager;
  String? pmanager;
  String? services;
  String? category;
  String? status;


  PreviewReport(
      {super.key,
        required this.date,
        required this.Greport,
        required this.customerLists,
        required this.id,
        required this.name,
        required this.cname,
        required this.gmanager,
        required this.pmanager,
        required this.services,
        required this.category,
        required this.status
      });

  @override
  State<PreviewReport> createState() => PreviewReportState();
}

class PreviewReportState extends State<PreviewReport> {
  final ScrollController _scrollController = ScrollController();
  late  List<dynamic> customerList =[];
  // bool isLoading = false;
  var dealernotes = {};
  var modifiedReport;
  var modifiedList;
  bool edit = false;
  List<Map<String, dynamic>> customerData=[];
  bool _isLoading = false;
  final FocusNode _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    customerList = widget.customerLists;
    edit = false;
    dealerNotes();
    super.initState();
  }



  dealerNotes(){

     customerData = customerList.map((customer) {
      return {customer['id'].toString(): customer['report']};
    }).toList();
    // for (var customer in customerList) {
    //   var customerId = customer['id'];
    //   var reportValue = customer['report'];
    //   dealernotes[customerId] = reportValue;
    // }
    // modifiedList = customerList.map((customer) => {
    // modifiedReport = customer['report'].replace('key', 'newKey');
    //     return { customer['id']: modifiedReport };
    // }).toList();
  }




  Future<dynamic> _openCustomerReportDialog() async{

    String shopid = await Utils().getUsererId();
    setState(() {
      _isLoading = true;
    });
    // Retrieve the reports using the previousReport method
    List? reports =  await AddReportService().previousReport(shopid,widget.id.toString());
    setState(() {
      _isLoading = false;
    });
    reports?.sort((a, b) {
      // Sort the reports in descending order based on the 'vdate' field
      int timeA = int.parse(a['vdate']);
      int timeB = int.parse(b['vdate']);
      return timeB.compareTo(timeA);
    });
    if(reports!.isEmpty){
      return Dialogs.showValidationMessage(context, "No previous report found");
    }
    else{
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
                child: RawScrollbar(
                  trackVisibility: true,
                  thumbColor: ColorConstants.appcolor,
                  trackColor: Colors.white,
                  trackRadius: const Radius.circular(20),
                  // thumbVisibility: true,
                  thickness: 8,
                  radius: const Radius.circular(20),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: reports?.length,
                    itemBuilder: (BuildContext context, int index) {

                      String date = reports![index]['vdate'];
                      String note = reports[index]['note'] == null ? 'Null' : reports[index]['note'];
                      String gnote = reports[index]['gnote'] == null ?  'Null': reports[index]['gnote'];
                      int vdateInMillis = int.parse(date);
                      DateTime dateTim = DateTime.fromMillisecondsSinceEpoch(vdateInMillis * 1000);
                      String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTim);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingTextwithsmallwhite(title: 'Date: $formattedDateTime'),
                          headingTextwithsmallwhite(title: 'Customer Note: $note'),
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
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddreportBloc(),
      child: Scaffold(
        backgroundColor: ColorConstants.DarkBlueColor,
        bottomNavigationBar: BlocConsumer<AddreportBloc,AddReportState>(
          listener: (context,state){
          if(state is AddreportSuccessState){
            setState(() {
              _isLoading = false;
            });
            Dialogs.showValidationMessage(context, 'Report Added Successfully');
            Timer( const Duration(seconds:2), () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Homepage()), (route) => false);
            });

          }else if(state is AddreportErrorState){
          Dialogs.showValidationMessage(context, state.error);
          }
          },builder: (context,state) {
          return Row(children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 50.w,
                  height: 40.sp,
                  color: ColorConstants.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      subheadingTextBOLD(title: 'Go Back',)
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  setState(() {
                    _isLoading = true;
                  });
                  BlocProvider.of<AddreportBloc>(context).add(
                      onPressedButtonEvent(leadId: widget.id.toString(),
                          name: widget.name.toString(),
                          cname: widget.cname.toString(),
                          gmanager: widget.gmanager.toString(),
                          pmanager: widget.pmanager.toString(),
                          services: widget.services.toString(),
                          category: widget.category.toString(),
                          status: widget.status.toString(),
                          vdate: widget.date,
                          dealerIds: customerList.map((
                              customer) => customer['id']).toList()
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", ""),
                          gnote: widget.Greport.text.toString(),
                          dealernotes: customerList.map((customer) =>
                          {
                            customer['id']: customer['report']
                          }).toList().toString().replaceAll("[", "").replaceAll(
                              "]", "")));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 50.w,
                  height: 40.sp,
                  color: ColorConstants.deppp
                  ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      subheadingTextBOLD(title: 'Submit',)
                    ],
                  ),
                )),
          ]);

        }
        ),
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
          child: Stack(
            children:[
              SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                  MediumSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // ProgressBarThin(
                    //     deviceWidth:8.w,
                    //     color:ColorConstants.deppp),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: ColorConstants.deppp,
                          child:  Text(
                            '1',
                            style: TextStyle(color: Colors.white,fontSize: 12.sp),
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
                          radius: 15.sp,
                          backgroundColor: ColorConstants.deppp,
                          child:  Text(
                            '2',
                            style: TextStyle(color: Colors.white,fontSize: 12.sp),
                          ),
                        ),
                        SizedBox(height:.3.h,),
                        subheadingText(title: "Customer")
                      ],
                    ),
                    ProgressBarThin(
                        deviceWidth:8.w,
                        color:ColorConstants.deppp),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: ColorConstants.deppp,
                          child:  Text(
                            '3',
                            style: TextStyle(color: Colors.white,fontSize: 12.sp),
                          ),
                        ),
                        SizedBox(height:.3.h,),
                        subheadingText(title: "Preview")
                      ],
                    ),
                    // ProgressBarThin(
                    //     deviceWidth:8.w,
                    //     color: ColorConstants.deppp),
                  ],
                ),
                MediumSpace(),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 95.w,
                          height: 6.5.h,
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
                                  widget.date,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(fontSize: 12.sp),
                                ),
                                Icon(
                                  CupertinoIcons.calendar,
                                  color: ColorConstants.deppp,size: 15.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SmallSpace(),
                      Padding(
                        padding:  EdgeInsets.only(left: 2.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            headingTextwithsmallwhite(title: 'General Report'),
                          ],
                        ),
                      ),
                       SizedBox(height: 0.5.h,),
                      Container(
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(3.sp),
                              border:
                              Border.all(color: Colors.black)),
                          child: Scrollbar(
                            controller: _scrollController,
                            child: TextField(
                              readOnly: !edit,
                              controller: widget.Greport,
                              focusNode: _textFieldFocusNode,
                              style: TextStyle(color:ColorConstants.DarkBlueColor,fontSize:10.sp,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              decoration: InputDecoration(
                                isDense: true,
                                suffixIcon: IconButton(
                                  onPressed: (){
                                   setState(() {
                                     edit = !edit;
                                     if (edit) {
                                       // Set the focus to the TextField when edit button is clicked
                                       FocusScope.of(context).requestFocus(_textFieldFocusNode);
                                     }
                                   });
                                  },icon: Icon( edit ? Icons.edit : Icons.edit_outlined,
                                  color: ColorConstants.deppp,size: 15.sp,),
                                ),
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
                              child:  Text('Previous Report',style: TextStyle(decoration: TextDecoration.underline,color: Colors.white,fontSize: 10.sp),))
                        ],
                      ),
                     SmallSpace(),
                      Padding(
                        padding:  EdgeInsets.only(left: 3.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            headingTextwithsmallwhite(title: 'Customer Report'),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 45.h,
                        width: 95.w,
                        child:ListView.builder(
                          itemCount: customerList.length,
                          itemBuilder: (context, index) {
                            final customer = customerList[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  'Customer Name: ${customer['name']}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                                ),
                                onTap: () {
                                  TextEditingController report = TextEditingController();
                                  report.text = customer['report'].toString().isEmpty ? 'Null': customer['report'];
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                          side: BorderSide(color: ColorConstants.deppp, width: 2),
                                        ),
                                        backgroundColor: ColorConstants.DarkBlueColor,
                                        title: headingTextwhite(title: '${customer['name']}'),
                                        content: SizedBox(
                                          width: double.maxFinite,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // headingTextwithsmallwhite(title: 'Add Customer Report Here'),
                                              // const SizedBox(height: 10),
                                              Container(
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color: Colors.black),
                                                ),
                                                child: Scrollbar(
                                                  controller: _scrollController,
                                                  child: TextField(
                                                    readOnly: true,
                                                    controller: report,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.black,
                                                      fontFamily: "railLight",
                                                    ),
                                                    keyboardType: TextInputType.multiline,
                                                    maxLines: 24,
                                                    decoration: InputDecoration(
                                                      hintText: 'Customer Report',
                                                      hintStyle: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.grey,
                                                        fontFamily: "railLight",
                                                      ),
                                                      isDense: true,
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                        borderSide: const BorderSide(
                                                          width: 0,
                                                          style: BorderStyle.none,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      contentPadding: const EdgeInsets.all(10),
                                                      fillColor: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          Container(
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: ColorConstants.deppp),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(report);
                                              },style: ElevatedButton.styleFrom(
                                              backgroundColor: ColorConstants.deppp
                                            ),
                                              child: const Text(
                                                'Ok',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
              // Center(
              //   child: AnimatedOpacity(
              //     opacity: isLoading ? 1.0 : 0.0,
              //     duration: const Duration(milliseconds: 100),
              //     child: Padding(
              //       padding: const EdgeInsets.all(30),
              //       child: Lottie.asset('assets/animations/submit.json',
              //       frameRate: FrameRate.max),
              //     ),
              //   ),
              // ),
            ]
          ),
        ),
      ),

    );
  }
}


