import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/drawer_logout.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';


import '../../Service/AddReport Service.dart';
import '../../Utils/setget.dart';
import 'notif_details.dart';
class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  List<dynamic> messages = [];


  @override
  void initState() {
    ShoiId();
    super.initState();

  }

  ShoiId() async {
    String shopid = await Utils().getUsererId();
    AddReportService().notification(shopid).then((value) {
      setState(() {
        messages = value;
      });
    });
  }

  void _openCustomerReportDialog(String profileName) {
    // TODO: Implement dialog to add report for the selected customer
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(children: [
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 100.w,
              height: 6.h,
              color: ColorConstants.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:const [
                   Text(
                    " Go Back",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                  )
                ],
              ),
            )),
      ]),
      appBar: AppBar(
        title: const Text('Notification'),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 213, 85, 40),
      ),
      drawer: const DrawerLogout(),


      body: Container(
        height: 100.h,
        decoration: gradient_login,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var message = messages[index];
              return Card(
                child: ListTile(

                  title: Text(message['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        NotificationPage(id: message['id'],)));
                  },

                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
