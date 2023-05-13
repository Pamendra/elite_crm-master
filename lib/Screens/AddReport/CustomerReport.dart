import 'package:elite_crm/Screens/AddReport/GeneralReport.dart';
import 'package:elite_crm/Service/AddReport%20Service.dart';
import 'package:elite_crm/Utils/app_baar.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CustomerReport extends StatefulWidget {
  const CustomerReport({Key? key}) : super(key: key);

  @override
  State<CustomerReport> createState() => _CustomerReportState();
}

class _CustomerReportState extends State<CustomerReport> {
  List<dynamic> _customerList = [];
  final ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();

    AddReportService().Customer().then((value) {
      setState(() {
        _customerList = value;
      });
    });
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
              color: ColorConstants.deppp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text("Continue "),
                  Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20.sp,
                  ),
                  const Text(
                    " Go Back",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
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
                  const Text(
                    " Continue",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ],
              ),
            )),
      ]),
      drawer: show(),
      appBar: AppBar(
        backgroundColor: ColorConstants.deppp,
        title: const Center(child: Text('Add Report')),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorConstants.DarkBlueColor,
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                const Text(
                  'Customer Report',
                  style: TextStyle(fontSize: 21),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'This is the specific customer report information.If a textarea is left empty a report will still be created.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.black)
                  ),
                  child: ListView.builder(
                    itemCount: _customerList.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> customer = _customerList[index];
                      // Create a CheckboxListTile for each customer
                      return InkWell(
                        // onTap: () {
                        //   _openCustomerReportDialog(customer['name']);
                        // },
                        child: CheckboxListTile(
                          title: Text(_customerList[index]['name']),
                          value: _customerList.contains(_customerList[index]['name']),
                          onChanged: (newValue) {
                            setState(() {
                             if(newValue!){
                               _customerList.add(_customerList[index]['name']);
                               _openCustomerReportDialog(customer['name']);
                             }else{
                               _customerList.remove(_customerList[index]['name']);
                             }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
