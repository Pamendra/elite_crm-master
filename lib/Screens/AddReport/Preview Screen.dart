
import 'package:elite_crm/Screens/Notification/notification%20page.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/TextWidgets.dart';
import '../../Utils/drawer_logout.dart';
import '../../Utils/progress_bar.dart';

class PreviewReport extends StatefulWidget {
  String date;
  final TextEditingController general;
  final List<Map<String, dynamic>> customerLists;

  PreviewReport({super.key, required this.date, required this.general, required this.customerLists});

  @override
  State<PreviewReport> createState() => _PreviewReportState();
}

class _PreviewReportState extends State<PreviewReport> {
  final ScrollController _scrollController = ScrollController();
  late  List<Map<String, dynamic>> customerList =[];

  @override
  void initState() {
    customerList = widget.customerLists;
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
              padding: const EdgeInsets.all(15),
              width: 50.w,
              height: 5.8.h,
              color: ColorConstants.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                  Text(
                    " Go Back",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            )),
        InkWell(
            onTap: () {
             Fluttertoast.showToast(msg: 'Add Report Successfully',toastLength: Toast.LENGTH_SHORT);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width:50.w,
              height: 5.8.h,
              color: ColorConstants.deppp
              ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                  Text(
                    " Submit",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
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
          height: 100.h,
          decoration: gradient_login,
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ProgressBarThin(
                    deviceWidth:8.w,
                    color:ColorConstants.deppp),
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
                ProgressBarThin(
                    deviceWidth:8.w,
                    color: ColorConstants.deppp),
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
                          controller: widget.general,
                          style: TextStyle(color:ColorConstants.DarkBlueColor,fontSize:10.sp,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),
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
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      itemCount: customerList.length,
                      itemBuilder: (context, index) {
                        final customer = customerList[index];
                        return Card(
                          child: ListTile(
                            title: Text('Customer Name: ${customer['name']}'),
                            subtitle: Text('Customer Report: ${customer['report']}'),
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
    );
  }
}
