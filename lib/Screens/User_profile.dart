import 'package:elite_crm/Utils/TextWidgets.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:sizer/sizer.dart';
import '../Service/AddReport Service.dart';
import '../../Utils/setget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Utils/ApploadingBar.dart';
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
  // List<dynamic> _selectedProfiles = [];
  dynamic _selectedProfile;
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    _getUserDetails();
    setState(() {
      _isLoading = false;
    });
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


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' User profile'),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const notification()));
          }, icon: const Icon(Icons.notifications))
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 213, 85, 40),
      ),
      drawer: DrawerLogout(),
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: .1,
        progressIndicator:const LoadingBar(),
        inAsyncCall: _isLoading ? true:false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: 80.h,
            decoration: gradient_login,
            child: Form(
              key: _formKey,
              child: Padding(
                padding:  const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

/*
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
*/

                    const SizedBox(
                      height: 15,
                    ),


                    headingTextwithsmallwhite(title: 'Territory'),
                    const SizedBox(height: 5,),
                    Container(
                      width: 95.w,
                      height: 6.8.h,
                      child: DropdownButtonFormField(
                        dropdownColor: ColorConstants.white,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(

                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorConstants.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:  BorderSide(color: ColorConstants.deppp, width: 1),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one profile';
                        //   }
                        //   return null;
                        // },
                        items: _profileList
                            .map((profile) => DropdownMenuItem(
                          value: profile,
                          child: Text(profile['name']),
                        ))
                            .toList(),
                        onChanged: (value) {
                          _selectedProfile = value;
                        },
                        value: _selectedProfile,
                        hint: const Text('Territory'),
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
                        filled: true,
                        fillColor: Colors.white,
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


                    SizedBox(
                      width: double.infinity, // sets width to full screen width
                      height: 50.0, // sets height to 50 logical pixels
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Fluttertoast.showToast(msg: 'Updated Successfully');
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
      ),
    );
  }
}
