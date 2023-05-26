import 'package:dio/dio.dart';
import 'package:elite_crm/Utils/TextWidgets.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
  List<dynamic> terr =[];
  TextEditingController add = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  dynamic _selectedProfile;
  bool _isLoading = false;
  List<Option> _options = [];
  List<Option> _selectedOptions = [];
  List<String> selectedOptionNames =[];



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
    _profileList = await AddReportService().UserProfieService(shopid, access);
    // final responses = await AddReportService().UserProfieService(shopid, access);

    // final terry = responses;
    final emailed = response[0]['email'];
    final phonee = response[0]['phone'];
    final addressed = response[0]['address'];
    final territory = response[0]['territory'];
   // for(var i=0 ; i< terry.length;i++)
   //   {
   //      for(var j=0 ; j< territory.length; j++)
   //        {
   //          if(territory[j]['id'] == terry[i]['id'])
   //            {
   //              var match = terry[i]['name'];
   //             terr.add(match);
   //
   //            }
   //        }
   //   }
   //  print(terr);
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
        // for(var i=0 ; i<_options.length ; i++)
        // {
        //   for(var j=0 ; j< terr.length; j++)
        //   {
        //     if(terr[j]['id'] == _options[i].id){
        //       _selectedOptions.add(_options[i]);
        //       break;
        //     }
        //   }
        // }
        // print(_selectedOptions);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserUpdateBloc(),
      child: Scaffold(
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
          Fluttertoast.showToast(msg: 'Updated Successfully');
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
              child: Container(
                height: 100.h,
                decoration: gradient_login,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 15,
                        ),
                        headingTextwithsmallwhite(title: 'Territory'),
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
                        ),

                        const SizedBox(
                          height: 40,
                        ),
                        headingTextwithsmallwhite(title: 'Address'),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: add,
                          maxLines: 4,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: TextStyle(color: ColorConstants.deppp),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0,),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: ColorConstants.deppp, width: 1.2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
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

                        const SizedBox(
                          height: 30,
                        ),
                        headingTextwithsmallwhite(title: 'Phone Number'),
                        const SizedBox(height: 5,),
                        TextFormField(
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
                              borderRadius: BorderRadius.circular(8.0),
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


                        const SizedBox(
                          height: 30,
                        ),
                        headingTextwithsmallwhite(title: 'Email'),
                        const SizedBox(height: 5,),
                        TextFormField(
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
                              borderRadius: BorderRadius.circular(8.0),
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

                        const SizedBox(
                          height: 30,
                        ),

                        SizedBox(
                          width: double.infinity,
                          // sets width to full screen width
                          height: 50.0,
                          // sets height to 50 logical pixels
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<UserUpdateBloc>(context).add(
                                  onPressedEvent(address: add.text, email: email.text, phone: phone.text, territories: selectedOptionNames.toString().replaceAll("[","").replaceAll("]","").replaceAll(", ", ",")));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.deppp,
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
