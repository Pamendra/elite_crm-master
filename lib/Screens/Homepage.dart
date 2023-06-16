
// ignore_for_file: file_names

import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../Service/dealerList.dart';
import '../Utils/TextWidgets.dart';
import '../Utils/drawer_logout.dart';
import 'DealerList Details.dart';
import 'Notification/notification page.dart';


class DealerList extends StatefulWidget {
  const DealerList({Key? key}) : super(key: key);

  @override
  State<DealerList> createState() => _DealerListState();
}

class _DealerListState extends State<DealerList> {
  final TextEditingController searchdealer = TextEditingController();
  GlobalService globalService = GlobalService();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstants.DarkBlueColor,
      appBar: AppBar(
        title: const Text('Dealer List'),
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

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(top: 7.sp,left: 7.sp,right: 7.sp),
          child: Column(
            children: [
              TextFormField(
                controller: searchdealer,
                onChanged: (value) {
                  setState(() {});
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorConstants.Darkopacity,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.deppp,width: 3
                      )
                    ),
                    suffixIcon:  const Icon(Icons.search,color:Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.sp),
                      borderSide:  BorderSide(color: ColorConstants.deppp, width: 3),
                    ),
                    hintText: 'Search...',
                    hintStyle:  TextStyle(color: Colors.white,fontSize: 11.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.sp))),
              ),
              const SizedBox(height: 5,),
              Expanded(
                  child: FutureBuilder(
                    future: globalService.DealerListapi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context,index){
                              return Shimmer.fromColors(
                                  baseColor:Colors.grey.shade700 ,
                                  highlightColor: Colors.grey.shade100,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Container(height: 10, width: 89, color: Colors.white,),
                                      )
                                    ],
                                  ));

                            });
                      }
                      List<dynamic> sortedData = List.from(snapshot.data!);
                      sortedData.sort((a, b) => a['name'].compareTo(b['name']));
                      return ListView.builder(
                          itemCount: sortedData.length,
                          itemBuilder: (context, index) {
                            String dealer = sortedData[index]['name'];
                            String dealerid = sortedData[index]['dealerid'];

                            if (searchdealer.text.isEmpty) {
                              return Column(
                                children: [
                                  Card(
                                    // color: ,
                                    child: ListTile(
                                      title: headingTextDarkblueWithextrasmall(title: sortedData[index]['name'],),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DealerDetails(dealerid :dealerid)));
                                      },
                                    ),
                                  )
                                ],
                              );
                            } else if (dealer.toLowerCase().contains(searchdealer.text.toLowerCase())) {
                              return Column(
                                children: [
                                  Card(
                                    child: ListTile(
                                      title: headingTextDarkblueWithextrasmall(title: sortedData[index]['name'],),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DealerDetails(dealerid :dealerid )));

                                      },
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
