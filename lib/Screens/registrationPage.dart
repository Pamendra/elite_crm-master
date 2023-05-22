import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sizer/sizer.dart';
import '../Bloc/RegistrationBloc.dart';
import '../Service/AddReport Service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Utils/ApploadingBar.dart';
import '../Utils/TextWidgets.dart';
import '../Utils/dialogs_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Notification/Model/multislect.dart';


class registration_page extends StatefulWidget {
  const registration_page({Key? key}) : super(key: key);

  @override
  _registration_pageState createState() => _registration_pageState();
}

class _registration_pageState extends State<registration_page> {
  List<dynamic> _profileList = [];
  List<dynamic> _details = [];
  List<dynamic> data = [];
  final _formKey = GlobalKey<FormState>();


  bool _passwordVisible = true;

  TextEditingController shopname = TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController addd = TextEditingController();
  TextEditingController emaill = TextEditingController();
  TextEditingController Owner =TextEditingController();
  TextEditingController contactname= TextEditingController();
  TextEditingController username= TextEditingController();
  TextEditingController Password= TextEditingController();
  TextEditingController Confirm_pass=TextEditingController();
  List<Option> _options = [];
  List<Option> _selectedOptions = [];
  bool _isLoading = false;
  List<String> selectedOptionNames =[];


  @override
  void initState() {

    _getUserDetails();

    super.initState();

  }



  Future<void> _getUserDetails() async {
    setState(() {
      _isLoading = true;
    });

    _profileList = await AddReportService().regProfieService();

    fetchDatareg().then((options) {
      setState(() {
        _options = options;

      });
    });

    //email.text = emailed;

    setState(() {
      _isLoading = false;
    });
  }


  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => regUpdateBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(' Registration'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),

          ],
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 213, 85, 40),
        ),



        body: BlocConsumer<regUpdateBloc,regUpdateState>(
            listener: (context,state){
              if(state is  RegUpdateSuccessState){
                Fluttertoast.showToast(msg: 'Added New User Successfully');
              }else if(state is RegUpdateErrorState){
                Dialogs.showValidationMessage(context, state.error);
              }
            },builder: (context,state) {
          return ModalProgressHUD(
            color: Colors.white,
            opacity: .1,
            progressIndicator: const LoadingBar(),
            inAsyncCall: _isLoading ? true : false,
            child:

            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:  Container(
                height: 120.h,
                decoration: gradient_login,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[



                        const SizedBox(
                          height: 15,
                        ),


                        headingTextwithsmallwhite2(title: 'Territory'),
                        const SizedBox(height: 5,),
                        SizedBox(
                            width: 95.w,

                            child:MultiSelectDialogField(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: ColorConstants.deppp,width: 2),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              items: _options
                                  .map((option) => MultiSelectItem<Option>(option, option.name))
                                  .toList(),
                              initialValue: _selectedOptions,
                              title: const Text('Select Options'),
                              onConfirm: (selectedItems) {
                                setState(() {
                                  _selectedOptions = selectedItems;
                                  selectedOptionNames = _selectedOptions.map((option) => option.name).toList();
                                });
                              },

                            )
                          // DropdownButtonFormField(
                          //   dropdownColor: ColorConstants.white,
                          //   style: const TextStyle(color: Colors.black),
                          //   decoration: InputDecoration(
                          //
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     border: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: ColorConstants.white,
                          //       ),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(8.0),
                          //       borderSide: BorderSide(
                          //           color: ColorConstants.deppp, width: 1),
                          //     ),
                          //   ),
                          //   autovalidateMode: AutovalidateMode.onUserInteraction,
                          //   items: _profileList
                          //       .map((profile) =>
                          //       DropdownMenuItem(
                          //         value: profile,
                          //         child: Text(profile['name']),
                          //       ))
                          //       .toList(),
                          //   onChanged: (value) {
                          //     _selectedProfile = value;
                          //   },
                          //   value: _selectedProfile,
                          //   hint:  Text('Territory'),
                          // ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        headingTextwithsmallwhite2(title: 'Shop Name'),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: shopname,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Shop Name',
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
                              return 'Please enter your shop name ';
                            }
                            return null;
                          },

                        ),
                        const SizedBox(
                          height: 20,
                        ),


                        headingTextwithsmallwhite2(title: 'Address (1234 Main St. Anywhere, TX 00000'),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: addd,
                          maxLines: 3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Address',
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

                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        headingTextwithsmallwhite2(title: 'Email'),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: emaill,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Email',
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
                          // onSaved: (value) {
                          //   _email = value!;
                          // },
                        ),


                        const SizedBox(
                          height: 30,
                        ),

                        headingTextwithsmallwhite2(title: 'Phone (i.e 123-456-7890 / 1234567890)'),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: phone,

                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Phone',
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
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Enter a Phone Number";
                            }
                            else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)){
                              return "Please Enter a Valid Phone Number";
                            }
                            return null;
                          },

                        ),




                        const SizedBox(
                          height: 15,
                        ),

                        headingTextwithsmallwhite2(title: 'Owner Name'),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: Owner,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Owner Name',
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
                              return 'Please enter your Owner name ';
                            }
                            return null;
                          },

                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        headingTextwithsmallwhite2(title: ' Contact Name '),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: contactname,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Contact Name ',
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
                              return 'Please enter your contactname  ';
                            }
                            return null;
                          },

                        ),


                        const SizedBox(
                          height: 15,
                        ),
                        headingTextwithsmallwhite2(title: ' Username '),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: username,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Username',
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
                              return 'Please enter your username  ';
                            }
                            return null;
                          },

                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        headingTextwithsmallwhite2(title: 'Password'),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: Password,
                          obscureText: true,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password',
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
                              return 'Please enter your Password  ';
                            }
                            return null;
                          },

                        ),


                        const SizedBox(
                          height: 15,
                        ),
                        headingTextwithsmallwhite2(title: ' Confirm Password '),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: Confirm_pass,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
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
                          validator: (value){
                            if (value!.isEmpty)
                            {
                              return 'Please re-enter password';
                            }
                            print(Password.text);

                            print(Confirm_pass.text);

                            if(Password.text!=Confirm_pass.text){
                              return "Password does not match";
                            }

                            return null;
                          },


                        ),

                        const SizedBox(
                          height: 30,
                        ),


                        SizedBox(
                          width: double.infinity, // sets width to full screen width
                          height: 50.0,


                          child: ElevatedButton(
                            onPressed: () {
                              if(shopname.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please Enter Shopname");

                              }
                              else  if(addd.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please Enter Address");

                              }

                              else  if(emaill.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please Enter Email");

                              }
                              else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emaill.text)) {
                                Fluttertoast.showToast(msg: "Please Enter  a valid Email");
                              }

                              else  if(phone.text.isEmpty){
                                Fluttertoast.showToast(msg:  "Please Enter a Phone Number");

                              }
                              else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(phone.text)){
                                Fluttertoast.showToast(msg: "Please Enter a Valid Phone Number"
                                );

                              }
                              else if(Owner.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please enter your Owner name");

                              }
                              else if(contactname.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please enter your Contact  name");

                              }
                              else if(username.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please enter your Username ");

                              }

                              else if(Password.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please enter your Password");

                              }

                              else if(Confirm_pass.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please re-enter password");

                              }
                              else  if (Password.text != Confirm_pass.text) {
                               Fluttertoast.showToast(msg: "Please re-enter password");
                              }






                              else{
                                BlocProvider.of<regUpdateBloc>(context).add(
                                    onPressedButtonEvent( shopnamee:shopname.text,
                                      address: addd.text,
                                      email: emaill.text,
                                      phone: phone.text,
                                      owner: Owner.text,
                                      c_name:contactname.text,
                                      u_name:username.text,
                                      p_name:Password.text,
                                      Confirm_password:Confirm_pass.text,
                                      territories: selectedOptionNames.toString().replaceAll("[", "").replaceAll("]", ""),

                                    ));}
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
        ),
      ),
    );
  }
}
