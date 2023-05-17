
// ignore_for_file: file_names

import 'package:elite_crm/Utils/color_constants.dart';
import 'package:elite_crm/Utils/gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../Service/AddReport Service.dart';
import '../Service/dealerList.dart';
import '../Utils/TextWidgets.dart';
import '../Utils/drawer_logout.dart';
import '../Utils/setget.dart';
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

      appBar: AppBar(
        title: const Text('Dealer List'),
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
      drawer: const DrawerLogout(),

      body: Container(
        height: 100.h,
        decoration: gradient_login,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
            child: Column(
              children: [
                TextFormField(
                  controller: searchdealer,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorConstants.Darkopacity,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstants.deppp,width: 3
                        )
                      ),
                      suffixIcon:  Icon(Icons.search,color:Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(color: ColorConstants.deppp, width: 3),
                      ),
                      hintText: 'Search ...',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
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
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String dealer = snapshot.data![index]['name'];
                              String dealerid = snapshot.data![index]['dealerid'];

                              if (searchdealer.text.isEmpty) {
                                return Column(
                                  children: [
                                    Card(
                                      // color: ,
                                      child: ListTile(
                                        title: headingTextDarkblueWithextrasmall(title: snapshot.data![index]['name'],),
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
                                        title: headingTextDarkblueWithextrasmall(title: snapshot.data![index]['name'],),
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
      ),
    );
  }
}
