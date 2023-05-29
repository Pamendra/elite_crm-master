
import 'dart:async';
import 'dart:convert';
import 'package:elite_crm/Bloc/AddReportBloc.dart';
import 'package:elite_crm/Screens/Notification/notification%20page.dart';
import 'package:elite_crm/Screens/bottomNavigationPages.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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



  // void submitForm() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   Timer(const Duration(milliseconds: 4500), () {
  //     // Navigate to the next screen
  //
  //   });
  // }



  Future<dynamic> _openCustomerReportDialog() async {

    String shopid = await Utils().getUsererId();
    setState(() {
      _isLoading = true;
    });
    // Retrieve the reports using the previousReport method
    List<dynamic> reports =  await AddReportService().previousReport(shopid);
    setState(() {
      _isLoading = false;
    });
    reports.sort((a, b) {
      // Sort the reports in descending order based on the 'vdate' field
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
                  String note = reports[index]['note'] == null ? 'Null' :reports[index]['note'];
                  String gnote = reports[index]['gnote'] == null ?   'Null': reports[index]['gnote'];
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
    return BlocProvider(
      create: (context) => AddreportBloc(),
      child: Scaffold(
        bottomNavigationBar: BlocConsumer<AddreportBloc,AddReportState>(
          listener: (context,state){
          if(state is AddreportSuccessState){
            // Fluttertoast.showToast(msg: 'Report Added Successfully');
            Dialogs.showValidationMessage(context, 'Report Added Successfully');
            Timer( Duration(seconds:2), () {
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
                  height: 5.8.h,
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
                  height: 5.8.h,
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
              child: Container(
                height: 95.h,
                // height: MediaQuery.of(context).size.height,
                decoration: gradient_login,
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
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
                            backgroundColor: ColorConstants.deppp,
                            child: const Text(
                              '2',
                              style: TextStyle(color: Colors.white),
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
                            backgroundColor: ColorConstants.deppp,
                            child: const Text(
                              '3',
                              style: TextStyle(color: Colors.white),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        GestureDetector(
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
                                    widget.date,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 15),
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
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              headingTextwithsmallwhite(title: 'General Report'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3,),
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
                                readOnly: !edit,
                                controller: widget.Greport,
                                style: TextStyle(color:ColorConstants.DarkBlueColor,fontSize:10.sp,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  isDense: true,
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                     setState(() {
                                       edit = !edit;
                                     });
                                    },icon: Icon( edit ? Icons.edit : Icons.edit_outlined,
                                    color: ColorConstants.deppp,),
                                  ),
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
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            InkWell(
                                onTap: (){
                                  _openCustomerReportDialog();
                                },
                                child: Text('Previous Report',style: TextStyle(decoration: TextDecoration.underline,color: Colors.white),))
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              headingTextwithsmallwhite(title: 'Customer Report'),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 50.h,
                          width: 95.w,
                          child: ListView.builder(
                            itemCount: customerList.length,
                            itemBuilder: (context, index) {
                              final customer = customerList[index];
                              return Card(

                                child: ListTile(
                                  title:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Customer Name:  ${customer['name']}',
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Customer Report:  ${ customer['report']}',
                                          style: TextStyle(fontSize: 10.sp,color: Colors.black,fontFamily: "railLight",fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
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
