import 'dart:convert';

import 'package:elite_crm/Service/AddReport%20Service.dart';
import 'package:elite_crm/Utils/app_baar.dart';
import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../Utils/setget.dart';
import 'GeneralReport.dart';

class AddReport extends StatefulWidget {
  const AddReport({Key? key}) : super(key: key);

  @override
  _AddReportState createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  String? _selectedOption;
  String? _selectedValue;
  String? selectedService;
  TextEditingController _controller = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController cname = TextEditingController();
  TextEditingController pmanager = TextEditingController();
  TextEditingController gmanager = TextEditingController();
  TextEditingController services = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController phone = TextEditingController();
  List _leads = [];
  String user_id ='';



  @override
  void initState() {
    ShoiId();
    // TODO: implement initState
    super.initState();
  }

  ShoiId() async {
    String shopid = await Utils().getUsererId();
    setState(() {
      user_id = shopid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GeneralReport()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 100.w,
                  height: 5.8.h,
                  color: ColorConstants.deppp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text("Continue "),

                      const Text( "Next", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size:20.sp,
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select an option:'),
                    SizedBox(height: 5,),
                    DropdownButtonFormField(
                      value: _selectedOption,
                      // icon: const Icon(Icons.location_on),
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Select Lead',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      items: const [
                        DropdownMenuItem(
                          value: 'existing_lead',
                          child: Text('Existing Lead'),
                        ),
                        DropdownMenuItem(
                          value: 'other_option',
                          child: Text('Other Option'),
                        ),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          _selectedOption = newValue;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (_selectedOption == 'existing_lead')
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Enter the lead',
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      if (pattern.length >= 3) {
                        _leads = await AddReportService().getLeads(pattern, user_id);
                      } else {
                        _leads = [];
                      }
                      return _leads.map((lead) => lead['name']).toList();
                    },
                    itemBuilder: (context, suggestion) {
                      var lead = _leads.firstWhere(
                          (lead) => lead['name'] == suggestion,
                          orElse: () => null);
                      if (lead != null) {
                        return ListTile(
                          title: Text('${lead['name']}, ${lead['cname']}'),
                          subtitle: Text('${lead['state']}, ${lead['city']}, ${lead['phone']}'),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    onSuggestionSelected: (suggestion) {
                      var lead = _leads.firstWhere(
                          (lead) => lead['name'] == suggestion,
                          orElse: () => null);
                      if (lead != null) {
                        _controller.text = lead['name'];
                        name.text = lead['name'];
                        cname.text = lead['cname'];
                        gmanager.text = lead['gmanager'];
                        pmanager.text = lead['pmanager'];
                        services.text = lead['services'];
                        state.text = lead['state'];
                        phone.text = lead['phone'];
                        setState(() {
                          _selectedValue = suggestion;
                        });

                      }
                    },
                  ),
                const SizedBox(height: 10,),
                if (_selectedValue != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                          controller: name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(

                          )
                        ),
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: cname,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(

                          )
                        ),
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: gmanager,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(

                          )
                        ),
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: pmanager,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(

                          )
                        ),
                      ),
                      const SizedBox(height: 5,),
                      DropdownButtonFormField<String>(
                        value: selectedService,
                        hint: Text(services.text),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: <String>['Mechanical', 'Collision', 'Both']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedService = value;
                          });
                        },
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: state,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(

                          )
                        ),
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(

                          )
                        ),
                      ),
                    ],
                  ),
                  ],
                ),
            ),
          ),
        ),
    );
  }
}
