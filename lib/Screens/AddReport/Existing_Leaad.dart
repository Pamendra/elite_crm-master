import 'dart:convert';

import 'package:elite_crm/Screens/AddReport/CustomerReport.dart';
import 'package:elite_crm/Screens/bottomNavigationPages.dart';
import 'package:elite_crm/Service/AddReport%20Service.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/Colors.dart';
import '../../Utils/TextWidgets.dart';
import '../../Utils/drawer_logout.dart';
import '../../Utils/progress_bar.dart';
import '../../Utils/setget.dart';
import '../Notification/notification page.dart';

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
  TextEditingController name = TextEditingController();
  TextEditingController cname = TextEditingController();
  TextEditingController pmanager = TextEditingController();
  TextEditingController gmanager = TextEditingController();
  TextEditingController services = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController phone = TextEditingController();
  List _leads = [];
  String user_id ='';
  final ScrollController _scrollController = ScrollController();
  TextEditingController general = TextEditingController();

  String? currentdatetime;
  DateTime? selectedDuration;
  String inspectionDate = "";
  String displayDate = "";


  @override
  void initState() {
    ShoiId();
    // TODO: implement initState
    super.initState();
  }

  ShoiId() async {
    String shopid = await Utils().getUsererId();
    setState(() {
      user_id = shopid;
    });
    selectedDuration = DateTime.now();
    displayDate = DateFormat("EEEE, MMMM d, yyyy").format(selectedDuration!);
    inspectionDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(selectedDuration!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const Homepage()),
                          (Route route) => false);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 50.w,
                  height: 5.8.h,
                  color: ColorConstants.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [


                       Text( "Cancel", style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        color: ColorConstants.white
                      ),),
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                 if(displayDate.isNotEmpty && general.text.isNotEmpty){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>  CustomerReport(date: displayDate, general: general,)),
                   );
                 }else{
                   Fluttertoast.showToast(msg: 'Please enter General Report');
                 }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 50.w,
                  height: 5.8.h,
                  color: ColorConstants.deppp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                       Text( "Next", style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                         color: Colors.white
                      ),),
                    ],
                  ),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 90.h,
          decoration: gradient_login,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                  const SizedBox(
                    height: 10,
                  ),
                    headingTextwithsmallwhite(title: 'Enter the Existing lead'),
                    const SizedBox(height: 3,),
                    TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _controller,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: "railLight"
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        if (pattern.length >= 3) {
                          _leads = await AddReportService().getLeads(pattern, user_id);
                        } else {
                          _leads = [];
                        }
                        return _leads.map((lead) => lead['name']).toList();
                      },
                      itemBuilder: (context, suggestion) {
                        var lead = _leads.firstWhere(
                            (lead) => lead['name'] == suggestion,
                            orElse: () => null);
                        if (lead != null) {
                          return Card(
                            color: ColorConstants.DarkBlueColor,
                            child: ListTile(
                              title: Text('${lead['name']}, ${lead['cname']}',style: TextStyle(fontSize: 10.sp, color: Colors.white, fontFamily: "railLight"),),
                              subtitle: Text('${lead['state']}, ${lead['city']}, ${lead['phone']}',style: TextStyle(fontSize: 10.sp, color: Colors.white, fontFamily: "railLight"),),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      onSuggestionSelected: (suggestion) {
                        var lead = _leads.firstWhere(
                            (lead) => lead['name'] == suggestion,
                            orElse: () => null);
                        if (lead != null) {
                          _controller.text = lead['name'];
                          name.text = '${lead['name']}, ${lead['cname']} , ${lead['gmanager']} , ${lead['pmanager']} ,'
                              ' ${lead['services'] } ,  ${lead['state']} ,  ${lead['phone']}';
                          setState(() {
                            _selectedValue = suggestion;
                          });

                        }
                      },
                    ),
                  const SizedBox(height: 10,),
                  if (_selectedValue != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                                readOnly: true,
                                controller: name,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                    fontFamily: "railLight"),
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                decoration: InputDecoration(
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
                        // const SizedBox(height: 5,),
                        // TextFormField(
                        //   controller: cname,
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(
                        //
                        //     )
                        //   ),
                        // ),
                        // const SizedBox(height: 5,),
                        // TextFormField(
                        //   controller: gmanager,
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(
                        //
                        //     )
                        //   ),
                        // ),
                        // const SizedBox(height: 5,),
                        // TextFormField(
                        //   controller: pmanager,
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(
                        //
                        //     )
                        //   ),
                        // ),
                        // const SizedBox(height: 5,),
                        // DropdownButtonFormField<String>(
                        //   value: selectedService,
                        //   hint: Text(services.text),
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   items: <String>['Mechanical', 'Collision', 'Both']
                        //       .map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        //   onChanged: (String? value) {
                        //     setState(() {
                        //       selectedService = value;
                        //     });
                        //   },
                        // ),
                        // const SizedBox(height: 5,),
                        // TextFormField(
                        //   controller: state,
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(
                        //
                        //     )
                        //   ),
                        // ),
                        // const SizedBox(height: 5,),
                        // TextFormField(
                        //   controller: phone,
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(
                        //
                        //     )
                        //   ),
                        // ),
                      ],
                    ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children:  [
                      const SizedBox(height: 20,),

                      Column(
                        children: [
                          Container(
                              height: 5.h,
                              color: ColorConstants.DarkBlueColor,
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Center(child: Text('This is the general lead specific information to be included in this report.',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: "railLight"),)),
                              )),
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
                        ],
                      ),
                      SizedBox(height: 10,),
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
                              controller: general,
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
                        children: const [
                          InkWell(child: Text('Previous Report',style: TextStyle(decoration: TextDecoration.underline,color: Colors.white),))
                        ],
                      )
                    ],
                  ),
                    ],
                  ),
              ),
            ),
        ),
        ),
    );
  }
}
