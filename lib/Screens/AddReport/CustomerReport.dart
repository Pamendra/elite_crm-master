import 'package:elite_crm/Screens/Notification/notification%20page.dart';
import 'package:elite_crm/Service/AddReport%20Service.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/Colors.dart';
import '../../Utils/TextWidgets.dart';
import '../../Utils/drawer_logout.dart';
import '../../Utils/progress_bar.dart';
import 'Preview Screen.dart';

class CustomerReport extends StatefulWidget {
  String date;
  final TextEditingController general;


  CustomerReport({super.key, required this.date, required this.general});

  @override
  State<CustomerReport> createState() => _CustomerReportState();
}

class _CustomerReportState extends State<CustomerReport> {
  List<dynamic> _customerList = [];
  final ScrollController _scrollController = ScrollController();

  List<String> dataList = [];
  String _searchQuery = '';
  List<dynamic> _filteredCustomerList = [];


  void initState() {
    super.initState();
    _filterCustomerList();
    AddReportService().Customer().then((value) {
      setState(() {
        _customerList = value;
      });
    });
  }

  void _filterCustomerList() {

    if (_searchQuery.isEmpty) {
      setState(() {
        _filteredCustomerList = _customerList;
      });
    } else {
      setState(() {
        _filteredCustomerList = _customerList
            .where((customer) => customer['name']
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
            .toList();
      });
    }
  }


  void _openCustomerReportDialog(String customerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(customerName),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add Customer Report Here'),
                const SizedBox(height: 10),
                Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(5),
                        border:
                        Border.all(color: Colors.black)),
                    child: Scrollbar(
                      controller: _scrollController,
                      child: TextField(
                        controller: TextEditingController(),
                        onChanged: (value) {
                          setState(() {
                            dataList.add(value);
                          });
                        },
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: "railLight"),
                        //controller: report,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Customer Report',
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add report logic goes here
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
                children: const [
                   Text(
                    " Go Back",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                  )
                ],
              ),
            )),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviewData(dataList: dataList),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 50.w,
              height: 5.8.h,
              color: ColorConstants.deppp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                   Text(
                    " Continue",
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
                ProgressBarThin(
                    deviceWidth:8.w,
                    color: blueGrey),
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
                            suffixIcon: InkWell(
                                onTap: (){
                                 Navigator.pop(context);
                                },
                                child:  Icon(Icons.edit,color: ColorConstants.deppp,)),
                            // hintText: ,
                            // hintStyle: TextStyle(
                            //   fontSize: 10.sp,
                            //   color: Colors.black,
                            //   fontFamily: "railLight",),
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
                 Container(
                   height: 5.h,
                   color: ColorConstants.DarkBlueColor,
                   child: const Center(
                     child: Padding(
                       padding: EdgeInsets.all(5.0),
                       child: Text(
                          'This is the specific customer report information.If a textarea is left empty a report will still be created.',
                          style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: "railLight"),
                        ),
                     ),
                   ),
                 ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                        _filterCustomerList();
                      });
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),

                  SizedBox(
                    height: 40.h,
                    child:  _searchQuery.isEmpty
                        ? ListView.builder(
                      itemCount: _customerList.length,
                      itemBuilder: (context, index) {
                        final customer = _customerList[index];
                        return InkWell(
                          child: Card(
                            child: ListTile(
                              title: subheadingText2(title: customer['name'],),
                              leading: Checkbox(
                                value: _customerList.contains(customer['name']),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (newValue != null) {
                                      if (newValue) {
                                        _customerList.add(customer['name']);
                                        _openCustomerReportDialog(customer['name']);
                                      } else {
                                        _customerList.remove(customer['name']);
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    )
                        : ListView.builder(
                      itemCount: _filteredCustomerList.length,
                      itemBuilder: (context, index) {
                        final customer = _filteredCustomerList[index];
                        return Card(
                          child: ListTile(
                            title: Text(customer['name']),
                            leading: Checkbox(
                              value: _customerList.contains(customer['name']),
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    if (newValue) {
                                      _customerList.add(customer['name']);
                                      _openCustomerReportDialog(customer['name']);
                                    } else {
                                      _customerList.remove(customer['name']);
                                    }
                                  }
                                });
                              },
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
    );
  }
}
