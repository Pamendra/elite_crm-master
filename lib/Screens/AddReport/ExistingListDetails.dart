// ignore_for_file: file_names



import 'package:elite_crm/Utils/TextWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sizer/sizer.dart';


import '../../Service/AddReport Service.dart';
import '../../Utils/color_constants.dart';
import '../../Utils/gradient_color.dart';
import '../../Utils/setget.dart';
import '../Notification/Model/detailsModel.dart';



 class ExistingListDetails extends StatefulWidget {
   const ExistingListDetails({Key? key}) : super(key: key);

   @override
   State<ExistingListDetails> createState() => _ExistingListDetailsState();
 }

 class _ExistingListDetailsState extends State<ExistingListDetails> {
   //TextEditingController details = TextEditingController();
   TextEditingController _controller = TextEditingController();
   TextEditingController _searchController = TextEditingController();
   ScrollController scrollist = ScrollController();

   String details='';
   List _leads = [];
   String user_id ='';
   String? _selectedValue;
   String? id;
   String? name;
   String? cname;
   String? gmanager;
   String? pmanager;
   String? services;
   String? category;
   String? status;
   FocusNode inputNode = FocusNode();

   ShoiId() async {
     String shopid = await Utils().getUsererId();
     setState(() {
       user_id = shopid;
     });
   }


@override
  void initState() {
  ShoiId();
    super.initState();
  }


   @override
   Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop: () async{


         return Future.value(false);
       },
       child: Scaffold(
         backgroundColor: ColorConstants.DarkBlueColor,
         appBar: AppBar(
           automaticallyImplyLeading: false,
           backgroundColor: ColorConstants.appcolor,
         ),
         bottomNavigationBar: InkWell(
             onTap: () async{
               Navigator.pop(context);
             },
             child: Container(
               padding: const EdgeInsets.all(15),
               width: 100.w,
               height: 5.8.h,
               color: ColorConstants.blueGrey,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:  [
                  subheadingTextBOLD(title: 'Go Back'),
                 ],
               ),
             )),

         body: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: SafeArea(
             child: Padding(
               padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     headingTextwithsmallwhite(title: 'Search Lead'),
                     // TypeAheadFormField(
                     //   keepSuggestionsOnLoading: false,
                     //   textFieldConfiguration: TextFieldConfiguration(
                     //     autofocus: true,
                     //     enabled: true,
                     //     focusNode: inputNode,
                     //     style: TextStyle(
                     //         fontSize: 10.sp,
                     //         color: Colors.black,
                     //         fontFamily: "railLight"
                     //     ),
                     //     decoration: InputDecoration(
                     //       filled: true,
                     //       fillColor: Colors.white,
                     //       hintText: 'Search...',
                     //       hintStyle: TextStyle(color: Colors.grey[500]),
                     //       border: OutlineInputBorder(
                     //         borderRadius: BorderRadius.circular(5),
                     //       ),
                     //     ),
                     //   ),
                     //   suggestionsCallback: (pattern) async {
                     //     if (pattern.length >= 3) {
                     //       _leads = await AddReportService().getLeads(pattern, user_id);
                     //     } else {
                     //       _leads = [];
                     //     }
                     //     return _leads.map((lead) => lead['name']).toList();
                     //   },
                     //   itemBuilder: (context, suggestion) {
                     //     var lead = _leads.firstWhere(
                     //             (lead) => lead['name'] == suggestion,
                     //         orElse: () => null);
                     //     if (lead != null) {
                     //       return Card(
                     //         color: ColorConstants.DarkBlueColor,
                     //         child: ListTile(
                     //           title: Text('${lead['name']}, ${lead['cname']}',style: TextStyle(fontSize: 10.sp, color: Colors.white, fontFamily: "railLight"),),
                     //           subtitle: Text('${lead['state']}, ${lead['city']}, ${lead['phone']}',style: TextStyle(fontSize: 10.sp, color: Colors.white, fontFamily: "railLight"),),
                     //         ),
                     //       );
                     //     } else {
                     //       return Card(
                     //         color: ColorConstants.DarkBlueColor,
                     //         child: ListTile(
                     //           title: Text('${lead['name']}, ${lead['cname']}',style: TextStyle(fontSize: 10.sp, color: Colors.white, fontFamily: "railLight"),),
                     //           subtitle: Text('${lead['state']}, ${lead['city']}, ${lead['phone']}',style: TextStyle(fontSize: 10.sp, color: Colors.white, fontFamily: "railLight"),),
                     //         ),
                     //       );
                     //     }
                     //   },
                     //   onSuggestionSelected: (suggestion) {
                     //     var lead = _leads.firstWhere(
                     //             (lead) => lead['name'] == suggestion,
                     //         orElse: () => null);
                     //     if (lead != null) {
                     //       var leadDetails = LeadDetails(
                     //         id: lead['id'],
                     //         name: lead['name'],
                     //         cname: lead['cname'],
                     //         gmanager: lead['gmanager'],
                     //         pmanager: lead['pmanager'],
                     //         services: lead['services'],
                     //         status: lead['status'],
                     //         category: lead['category'] ?? 'null',
                     //         details:'${lead['name']}, ${lead['cname']} , ${lead['gmanager']} , ${lead['pmanager']} ,'
                     //                   ' ${lead['services'] } ,  ${lead['state']} ,  ${lead['phone']}'
                     //       );
                     //
                     //         Navigator.pop(context, leadDetails);
                     //     }
                     //   },
                     //   enabled: true,
                     // ),

                     TextField(
                       autofocus: true,
                       controller: _searchController,
                       style: TextStyle(fontSize: 10.sp, color: Colors.black, fontFamily: "railLight"),
                       decoration: InputDecoration(
                         filled: true,
                         fillColor: Colors.white,
                         hintText: 'Search...',
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: ColorConstants.deppp,width: 1.5.sp
                           )
                         ),
                         hintStyle: TextStyle(color: Colors.grey[500]),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                         ),
                       ),
                       onChanged: (pattern) async {
                         if (pattern.length >= 3) {
                           _leads = await AddReportService().getLeads(pattern, user_id);
                         } else {
                           _leads = [];
                         }
                         setState(() {});
                       },
                     ),
                     SizedBox(height: 10),
                     Container(
                       height: 60.h,
                       child: RawScrollbar(
                         trackVisibility: true,
                         thumbColor: ColorConstants.appcolor,
                         trackColor: Colors.white,
                         trackRadius: const Radius.circular(20),
                        // thumbVisibility: true,
                         thickness: 8,
                         radius: const Radius.circular(20),

                         scrollbarOrientation: ScrollbarOrientation.right,
                         child: ListView.builder(
                           itemCount: _leads.length,
                           itemBuilder: (BuildContext context, int index) {
                             var lead = _leads[index];
                             return Card(
                               color: ColorConstants.DarkBlueColor,
                               child: ListTile(
                                 shape: Border(
                                     bottom: BorderSide(
                                       color: ColorConstants.backgroundappColor,
                                     )),
                                 title: Text(
                                   '${lead['name']}, ${lead['cname']}',
                                   style: TextStyle(fontSize: 11.sp, color: Colors.white, fontFamily: "railLight"),
                                 ),
                                 subtitle: Text(
                                   '${lead['state']}, ${lead['city']}, ${lead['phone']}',
                                   style: TextStyle(fontSize: 11.sp, color: Colors.white, fontFamily: "railLight"),
                                 ),
                                 onTap: () {
                                   var leadDetails = LeadDetails(
                                     id: lead['id'],
                                     name: lead['name'],
                                     cname: lead['cname'],
                                     gmanager: lead['gmanager'],
                                     pmanager: lead['pmanager'],
                                     services: lead['services'],
                                     status: lead['status'],
                                     category: lead['category'] ?? 'null',
                                     details:
                                     '${lead['name']}, ${lead['cname']} , ${lead['gmanager']} , ${lead['pmanager']} , ${lead['services'] } ,  ${lead['state']} ,  ${lead['phone']}',
                                   );
                                   Navigator.pop(context, leadDetails);
                                 },
                               ),
                             );
                           },
                         ),
                       ),
                     ),
                   ]
               ),
             ),
           ),
         ),
       ),
     );
   }
 }
