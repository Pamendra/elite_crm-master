import 'package:elite_crm/Utils/TextWidgets.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:sizer/sizer.dart';
import '../Service/AddReport Service.dart';
import '../../Utils/setget.dart';

import '../Utils/drawer_logout.dart';
import 'Notification/notification page.dart';

class userprofile_pages extends StatefulWidget {
  const userprofile_pages({Key? key}) : super(key: key);

  @override
  _userprofile_pagesState createState() => _userprofile_pagesState();
}

class _userprofile_pagesState extends State<userprofile_pages> {
  List<dynamic> _profileList = [];
  List<dynamic> _details = [];
  List<dynamic> data = [];
  final _formKey = GlobalKey<FormState>();
  late String _address;
  late String _phoneNumber;
  late String _email;
  TextEditingController add = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  List<dynamic> _selectedProfiles = [];

  @override
  void initState() {
    _getUserDetails();
    super.initState();

  }


  Future<void> _getUserDetails() async {
    String shopid = await Utils().getUsererId();
    String access = await Utils().getAccess();
    final response = await AddReportService().userDetails(shopid, access);
     _profileList = await AddReportService().UserProfieService(shopid, access);
    final emailed = response[0]['email'];
    final phonee = response[0]['phone'];
    final addressed = response[0]['address'];

    email.text = emailed;
    phone.text = phonee;
    add.text = addressed;
  }


  void _openCustomerReportDialog(String profileName) {
    // TODO: Implement dialog to add report for the selected customer
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' User profile'),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
       IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const notification()));
          }, icon: Icon(Icons.notifications))
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 213, 85, 40),
      ),
      drawer: DrawerLogout(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 100.h,
          decoration: gradient_login,
          child: Form(
            key: _formKey,
            child: Padding(
              padding:  EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50.w,

                    child: MultiSelectFormField(
                      border:  OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstants.deppp
                        )
                      ),
                      autovalidate: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select at least one profile';
                        }
                        return null;
                      },
                      dataSource: _profileList
                          .map((profile) => {'display': profile['name'], 'value': profile})
                          .toList(),
                      textField: 'display',
                      title: const Text('Territory'),
                      valueField: 'value',
                      okButtonLabel: 'OK',
                      cancelButtonLabel: 'CANCEL',
                      initialValue: const [],
                      onSaved: (value) {
                        _selectedProfiles = value;
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  headingTextwithsmallwhite(title: 'Address'),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: add,
                    maxLines: 4,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(color: ColorConstants.deppp),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0,),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:  BorderSide(color: ColorConstants.deppp, width: 1.2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(color: ColorConstants.deppp, width: 1.2),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _address = value!;
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  headingTextwithsmallwhite(title: 'Phone Number'),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(color: ColorConstants.deppp),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0,),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(color: ColorConstants.deppp, width: 1.2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(color: ColorConstants.deppp, width: 1.2),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phoneNumber = value!;
                    },
                  ),




                  const SizedBox(
                    height: 30,
                  ),
                  headingTextwithsmallwhite(title: 'Email'),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(color: ColorConstants.deppp),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0,),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(color: ColorConstants.deppp, width: 1.2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(color: ColorConstants.deppp, width: 1.2),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),


                  const SizedBox(
                    height: 30,
                  ),
            const SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    width: double.infinity, // sets width to full screen width
                    height: 50.0, // sets height to 50 logical pixels
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Do something with the form data
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.deppp, // Background color
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),

                    ),
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
