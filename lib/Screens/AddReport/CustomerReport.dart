import 'package:elite_crm/Screens/Notification/notification%20page.dart';
import 'package:elite_crm/Service/AddReport%20Service.dart';
import 'package:elite_crm/Utils/SizedSpace.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/ApploadingBar.dart';
import '../../Utils/TextWidgets.dart';
import '../../Utils/drawer_logout.dart';
import '../../Utils/progress_bar.dart';
import '../../Utils/setget.dart';
import 'Preview Screen.dart';

class CustomerReport extends StatefulWidget {
  String date;
  final TextEditingController Greport;
  String? id;
  String? name;
  String? cname;
  String? gmanager;
  String? pmanager;
  String? services;
  String? category;
  String? status;


  CustomerReport(
      {super.key, required this.date,
        required this.Greport,
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
  State<CustomerReport> createState() => _CustomerReportState();
}

class _CustomerReportState extends State<CustomerReport> {
  List<dynamic> _customerList = [];
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> customerReport = [];
  List<String> dataList = [];
  String _searchQuery = '';
  List<dynamic> _filteredCustomerList = [];
  List<Map<String, dynamic>> _customerLists = [];
  TextEditingController reportController = TextEditingController();
  bool _isLoading = false;




  void initState() {
    super.initState();
    _filterCustomerList();
    AddReportService().Customer().then((value) {
      setState(() {
        _customerList = value;
      });
    });
  }


  Future<dynamic> _openCustomerReportDialogprevious(String customerId) async {
    String shopid = await Utils().getUsererId();
    setState(() {
      _isLoading = true;
    });

    List<dynamic> reports = await AddReportService().previousReport(shopid);

    setState(() {
      _isLoading = false;
    });

    // Filter reports based on customer ID
    List<dynamic> filteredReports =
    reports.where((report) => report['cid'] == customerId).toList();

    filteredReports.sort((a, b) {
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredReports.length,
                itemBuilder: (BuildContext context, int index) {
                  String date = filteredReports[index]['vdate'];
                  String note =
                  filteredReports[index]['note'] == null ? 'Null' : filteredReports[index]['note'];
                  String cid =
                  filteredReports[index]['cid'] == null ? 'Null' : filteredReports[index]['cid'];
                  int vdateInMillis = int.parse(date);
                  DateTime dateTim = DateTime.fromMillisecondsSinceEpoch(vdateInMillis * 1000);
                  String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTim);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingTextwithsmallwhite(title: 'Customer ID: $cid'),
                      headingTextwithsmallwhite(title: 'Date: $formattedDateTime'),
                      headingTextwithsmallwhite(title: 'Customer Note: $note'),
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
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.blueGrey),
                  child: Text(
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


  Future<dynamic> _openCustomerReportDialog(String customerID,String customerName, TextEditingController reportController,
      {bool isEditMode = false, String initialReport = ''}) {
    
    reportController.text = initialReport;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            side: BorderSide(color: ColorConstants.deppp, width: 2),
          ),
          backgroundColor: ColorConstants.DarkBlueColor,
          title: headingTextwhite(title: customerName),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingTextwithsmallwhite(title: 'Add Customer Report Here'),
                const SizedBox(height: 10),
                Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Scrollbar(
                    controller: _scrollController,
                    child: TextField(
                      controller: reportController,
                      onChanged: (value) {
                        setState(() {
                          dataList.add(value);
                        });
                      },
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black,
                        fontFamily: "railLight",
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 9,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _openCustomerReportDialogprevious(customerID);
                      },
                      child: const Text(
                        'Previous Report',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Container(
              height: 5.h,
              decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.blueGrey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog without saving
                },style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.blueGrey
              ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 5.h,
              decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.deppp),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ElevatedButton(
                onPressed: () {
                  String report = reportController.text;
                  Navigator.of(context).pop(report);
                },style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.deppp
              ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                children:  [
                  subheadingTextBOLD(title: 'Go Back',)
                ],
              ),
            )),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviewReport(
                    customerLists: List.from(_customerLists),
                    date: widget.date,Greport: widget.Greport, id: widget.id, name: widget.name, cname: widget.cname,
                    gmanager: widget.gmanager, pmanager: widget.pmanager, services: widget.services, category: widget.category,
                    status: widget.status,
                  ),
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
                children: [
                  subheadingTextBOLD(title: 'Continue',)
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
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: .1,
        progressIndicator: const LoadingBar(),
        inAsyncCall: _isLoading ? true : false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
          SmallSpace(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.sp),
              child: Column(
                children: [
                  // GestureDetector(
                  //   child: Container(
                  //     width: 95.w,
                  //     height: 6.h,
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(5),
                  //         border: Border.all(color: Colors.black)
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: Row(
                  //         mainAxisAlignment:
                  //         MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             widget.date,
                  //             overflow: TextOverflow.ellipsis,
                  //             style: const TextStyle(fontSize: 15),
                  //           ),
                  //           Icon(
                  //             CupertinoIcons.calendar,
                  //             color: ColorConstants.deppp,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       headingTextwithsmallwhite(title: 'General Report'),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //     width: 95.w,
                  //     decoration: BoxDecoration(
                  //         borderRadius:
                  //         BorderRadius.circular(5),
                  //         border:
                  //         Border.all(color: Colors.black)),
                  //     child: Scrollbar(
                  //       controller: _scrollController,
                  //       child: TextField(
                  //         readOnly: true,
                  //         controller: widget.Greport,
                  //         style: TextStyle(color:ColorConstants.DarkBlueColor,fontSize:10.sp,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),
                  //         keyboardType: TextInputType.multiline,
                  //         maxLines: 5,
                  //         decoration: InputDecoration(
                  //           suffixIcon: InkWell(
                  //               onTap: (){
                  //                Navigator.pop(context);
                  //               },
                  //               child:  Icon(Icons.edit,color: ColorConstants.deppp,)),
                  //           // hintText: ,
                  //           // hintStyle: TextStyle(
                  //           //   fontSize: 10.sp,
                  //           //   color: Colors.black,
                  //           //   fontFamily: "railLight",),
                  //           isDense: true,
                  //           border: OutlineInputBorder(
                  //             borderRadius:
                  //             BorderRadius.circular(5),
                  //             borderSide: const BorderSide(
                  //               width: 0,
                  //               style: BorderStyle.none,
                  //             ),
                  //           ),
                  //           filled: true,
                  //           contentPadding:
                  //           const EdgeInsets.all(10),
                  //           fillColor: Colors.white,
                  //         ),
                  //       ),
                  //     )
                  // ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: const [
                  //     InkWell(child: Text('Previous Report',style: TextStyle(decoration: TextDecoration.underline,color: Colors.white),))
                  //   ],
                  // ),
                  SmallSpace(),
                 Container(
                   height: 5.h,
                   color: ColorConstants.DarkBlueColor,
                   child:  Center(
                     child: Padding(
                       padding:  EdgeInsets.all(5.sp),
                       child: Text(
                          'This is the specific customer report information. If a text area is left empty a report will still be created.',
                          style: TextStyle(fontSize: 10.sp,color: Colors.white,fontFamily: "railLight"),
                        ),
                     ),
                   ),
                 ),
                  SmallSpace(),
                  Container(
                    width: 95.w,
                    height: 6.h,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                          _filterCustomerList();
                        });
                      },
                      style: const TextStyle(color: Colors.white,fontFamily: "railLight"),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.Darkopacity,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.deppp,width: 3
                              )
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:  BorderSide(color: ColorConstants.deppp, width: 3),
                          ),
                          suffixIcon: const Icon(Icons.search,color: Colors.white,),
                          hintText: 'Search...',
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.sp))),
                    ),
                  ),


                  SizedBox(
                    height: 60.h,
                    child: _searchQuery.isEmpty
                        ? ListView.builder(
                      itemCount: _customerList.length,
                      itemBuilder: (context, index) {
                        final customer = _customerList[index];
                        final isCustomerSelected =
                        _customerLists.any((item) => item['name'] == customer['name']);
                        return InkWell(
                          child: Card(
                            color: isCustomerSelected ? Colors.green : null,
                            child: ListTile(
                              title: subheadingText2(title: customer['name']),
                              trailing: isCustomerSelected
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                          ),
                          onTap: () {
                            String getReportForCustomer(String customerName) {
                              String report = '';
                              for (final customer in _customerLists) {
                                if (customer['name'] == customerName) {
                                  report = customer['report'];
                                  break; // Exit the loop once the customer is found
                                }
                              }
                              return report;
                            }


                            void updateReportForCustomer(String customerName, String report) {
                              for (final customer in _customerLists) {
                                if (customer['name'] == customerName) {
                                  customer['report'] = report;
                                  break; // Exit the loop once the customer is found
                                }
                              }
                            }


                            setState(() {
                              _openCustomerReportDialog(customer['id'],
                                customer['name'],
                                reportController,
                                isEditMode: isCustomerSelected,
                                initialReport: isCustomerSelected ? getReportForCustomer(customer['name']) : '',
                              ).then((report) {
                                if (report != null) {
                                  setState(() {
                                    if (isCustomerSelected) {
                                      updateReportForCustomer(customer['name'], report);
                                    } else {
                                      _customerLists.add({
                                        'id': customer['id'],
                                        'name': customer['name'],
                                        'report': report,
                                      });
                                    }
                                  });
                                }
                              });
                            });
                          },
                        );
                      },
                    )

                        : ListView.builder(
                      itemCount: _customerList.length,
                      itemBuilder: (context, index) {
                        final customer = _customerList[index];
                        final isCustomerSelected =
                        _customerLists.any((item) => item['name'] == customer['name']);
                        return InkWell(
                          child: Card(
                            color: isCustomerSelected ? Colors.green : null,
                            child: ListTile(
                              title: subheadingText2(title: customer['name']),
                              trailing: isCustomerSelected
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                          ),
                          onTap: () {
                            String getReportForCustomer(String customerName) {
                              String report = '';
                              for (final customer in _customerLists) {
                                if (customer['name'] == customerName) {
                                  report = customer['report'];
                                  break; // Exit the loop once the customer is found
                                }
                              }
                              return report;
                            }


                            void updateReportForCustomer(String customerName, String report) {
                              for (final customer in _customerLists) {
                                if (customer['name'] == customerName) {
                                  customer['report'] = report;
                                  break; // Exit the loop once the customer is found
                                }
                              }
                            }

                            setState(() {
                              _openCustomerReportDialog(customer['id'],
                                customer['name'],
                                reportController,
                                isEditMode: isCustomerSelected,
                                initialReport: isCustomerSelected ? getReportForCustomer(customer['name']) : '',
                              ).then((report) {
                                if (report != null) {
                                  setState(() {
                                    if (isCustomerSelected) {
                                      updateReportForCustomer(customer['name'], report);
                                    } else {
                                      _customerLists.add({
                                        'id': customer['id'],
                                        'name': customer['name'],
                                        'report': report,
                                      });
                                    }
                                  });
                                }
                              });
                            });
                          },
                        );
                      },
                    )

                  )

                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
