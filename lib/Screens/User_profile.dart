

// ignore_for_file: file_names

import 'dart:async';
import 'package:elite_crm/Utils/SizedSpace.dart';
import 'package:elite_crm/Utils/TextWidgets.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Bloc/UserUpdateBloc/UserUpdateBloc.dart';
import '../Service/AddReport Service.dart';
import '../../Utils/setget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Utils/ApploadingBar.dart';
import '../Utils/dialogs_utils.dart';
import '../Utils/drawer_logout.dart';
import 'Notification/Model/multislect.dart';
import 'Notification/notification page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'TerritoryListData.dart';
import 'bottomNavigationPages.dart';

class userprofile_pages extends StatefulWidget {
  const userprofile_pages({Key? key}) : super(key: key);

  @override
  _userprofile_pagesState createState() => _userprofile_pagesState();
}

class _userprofile_pagesState extends State<userprofile_pages> {
  List<dynamic> data = [];
  final _formKey = GlobalKey<FormState>();
  late String _address;
  late String _phoneNumber;
  late String _email;
  List<dynamic> terr =[];
  TextEditingController add = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  bool _isLoading = false;
  List<Option> _options = [];
  List<Option> _selectedOptions = [];
  List<String> selectedOptionNames =[];
  String trainID = "";
 String trainData = "";

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }



  Future<void> _getUserDetails() async {
    String shopid = await Utils().getUsererId();
    String access = await Utils().getAccess();
    setState(() {
      _isLoading = true;
    });

   final response = await AddReportService().userDetails(shopid, access);
   // _profileList = await AddReportService().UserProfieService(shopid, access);



    final emailed = response[0]['email'];
    final phonee = response[0]['phone'];
    final addressed = response[0]['address'];
    final territory = response[0]['territory'];
    print(_selectedOptions);
    email.text = emailed;
    phone.text = phonee;
    add.text = addressed;
    terr = territory;
    setState(() {
      _isLoading = false;
    });

    fetchData(shopid, access).then((options) {
      setState(() {
        _options = options;
        _selectedOptions = _options
            .where((option) => terr.any((item) => item['id'] == option.id))
            .toList();
      });
    });
  }

  Future<void> getTerritoryData(BuildContext context) async {
    /// Check  Auto route data receving
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>const TerritoryListData()),);
    setState(() {
      if (result.toString() != "null") {
        trainData = result;
        trainID = trainData.toString();
      } else {
        trainID = '';
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserUpdateBloc(),
      child: Scaffold(
        bottomNavigationBar: BlocConsumer<UserUpdateBloc,UserUpdateState>(
            listener: (context,state){
              if(state is UserUpdateSuccessState){
                setState(() {
                  _isLoading = false;
                });
                Dialogs.showValidationMessage(context, 'Updated Successfully');

              }else if(state is UserUpdateErrorState){
                Dialogs.showValidationMessage(context, state.error);
              }
            },builder: (context,state) {
          return Row(children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const Homepage()),
                          (Route route) => false);
                },
                child: Container(
                 // padding:  EdgeInsets.all(5.sp),
                  width: 50.w,
                  height: 40.sp,
                  color: ColorConstants.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      subheadingTextBOLD(title: 'Cancel',)
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  setState(() {
                    _isLoading = true;
                  });
                  BlocProvider.of<UserUpdateBloc>(context).add(
                      onPressedEvent(address: add.text, email: email.text, phone: phone.text, territories: trainID));

                },
                child: Container(
                 // padding: const EdgeInsets.all(15),
                  width: 50.w,
                  height: 40.sp,
                  color: ColorConstants.deppp
                  ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      subheadingTextBOLD(title: 'Update',)
                    ],
                  ),
                )),
          ]);

        }
        ),
        backgroundColor: ColorConstants.DarkBlueColor,
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
        drawer: const DrawerLogout(),
        body: BlocConsumer<UserUpdateBloc,UserUpdateState>(
          listener: (context,state){
          if(state is UserUpdateSuccessState){

          }else if(state is UserUpdateErrorState){
          Dialogs.showValidationMessage(context, state.error);
          }
          },builder: (context,state) {
          return ModalProgressHUD(
              color: Colors.white,
              opacity: .1,
              progressIndicator: const LoadingBar(),
              inAsyncCall: _isLoading ? true : false,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:  EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      headingTextwithsmallwhite(title: 'Territory'),
                      SmallSpace(),
                      // SizedBox(
                      //   width: 95.w,
                      //
                      //   child:  MultiSelectDialogField<Option>(
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         border: Border.all(color: ColorConstants.deppp,width: 2),
                      //         borderRadius: BorderRadius.circular(4)
                      //     ),
                      //     items: _options
                      //         .map((option) => MultiSelectItem<Option>(option, option.name))
                      //         .toList(),
                      //     initialValue: _selectedOptions,
                      //     title: const Text('Select Options'),
                      //     onConfirm: (selectedItems) {
                      //       setState(() {
                      //         _selectedOptions = selectedItems;
                      //         selectedOptionNames = _selectedOptions.map((option) => option.name).toList();
                      //       });
                      //     },
                      //     chipDisplay: MultiSelectChipDisplay<Option>(
                      //       onTap: (item) {
                      //         setState(() {
                      //           _selectedOptions.remove(item);
                      //           selectedOptionNames = _selectedOptions.map((option) => option.name).toList();
                      //         });
                      //       },
                      //       chipColor: ColorConstants.deppp,
                      //       textStyle: const TextStyle(color: Colors.white),
                      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                      //       items: _selectedOptions.map((option) => MultiSelectItem<Option>(option, option.name)).toList(),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 95.w,
                        child: GestureDetector(
                          onTap: () {
                            getTerritoryData(context);
                          },
                          child: Container(
                            width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.sp),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(7.sp),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      trainID == "" ?_selectedOptions.map((option) =>
                                      option.name).toList().toString().replaceAll("[", "").replaceAll("]", "") : trainID,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 10.sp,fontFamily: "railLight"),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.selection_pin_in_out,
                                    color: ColorConstants.appcolor,
                                  ),
                                ],
                              ),

                            ),
                          ),
                        ),
                      ),

                      
                      MediumSpace(),
                      headingTextwithsmallwhite(title: 'Address'),
                      SmallSpace(),
                      TextFormField(
                        style: TextStyle(fontSize: 10.sp,fontFamily: "railLight"),
                        controller: add,
                        maxLines: 4,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: ColorConstants.deppp),
                          contentPadding:  EdgeInsets.symmetric(
                            horizontal: 12.sp, vertical: 12.sp,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.sp),
                            borderSide: BorderSide(
                                color: ColorConstants.deppp, width: 1.2.sp),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.sp),
                            borderSide: BorderSide(
                                color: ColorConstants.deppp, width: 1.2),
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

                      MediumSpace(),
                      headingTextwithsmallwhite(title: 'Phone Number'),
                      SmallSpace(),
                      TextFormField(
                        style: TextStyle(fontSize: 10.sp,fontFamily: "railLight"),
                        controller: phone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelStyle: TextStyle(color: ColorConstants.deppp),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: ColorConstants.deppp, width: 1.2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.sp),
                            borderSide: BorderSide(
                                color: ColorConstants.deppp, width: 1.2),
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


                      MediumSpace(),
                      headingTextwithsmallwhite(title: 'Email'),
                     SmallSpace(),
                      TextFormField(
                        style: TextStyle(fontSize: 10.sp,fontFamily: "railLight"),
                        controller: email,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelStyle: TextStyle(color: ColorConstants.deppp),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: ColorConstants.deppp, width: 1.2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.sp),
                            borderSide: BorderSide(
                                color: ColorConstants.deppp, width: 1.2),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),

                      LargeSpace(),

                      // SizedBox(
                      //
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Container(
                      //         width: 46.w,
                      //         height: 5.h,
                      //         child: ElevatedButton(
                      //           onPressed: () {
                      //             Navigator.of(context).pushAndRemoveUntil(
                      //                 MaterialPageRoute(
                      //                     builder: (context) => const Homepage()),
                      //                     (Route route) => false);
                      //             },
                      //           style: ElevatedButton.styleFrom(
                      //             backgroundColor: ColorConstants.blueGrey,
                      //           ),
                      //           child:  Text(
                      //             'Cancel',
                      //             style: TextStyle(
                      //               fontSize: 11.sp,
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //
                      //         ),
                      //       ),
                      //
                      //
                      //       Container(
                      //         width: 46.w,
                      //         height: 5.h,
                      //         child: ElevatedButton(
                      //           onPressed: () {
                      //             setState(() {
                      //               _isLoading = true;
                      //             });
                      //             BlocProvider.of<UserUpdateBloc>(context).add(
                      //                 onPressedEvent(address: add.text, email: email.text, phone: phone.text, territories: selectedOptionNames.toString().replaceAll("[","").replaceAll("]","").replaceAll(", ", ",")));
                      //
                      //           },
                      //           style: ElevatedButton.styleFrom(
                      //             backgroundColor: ColorConstants.deppp,
                      //           ),
                      //           child:  Text(
                      //             'Update',
                      //             style: TextStyle(
                      //               fontSize: 11.sp,
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //
                      //         ),
                      //       ),
                      //
                      //
                      //     ],
                      //   ),
                      // ),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
        ),
      ),
    );
  }
}
