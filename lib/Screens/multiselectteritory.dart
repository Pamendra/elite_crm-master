import 'package:elite_crm/Utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:sizer/sizer.dart';

import '../Service/AddReport Service.dart';
import '../Utils/ApploadingBar.dart';
import '../Utils/Colors.dart';
import '../Utils/SizedSpace.dart';
import '../Utils/TextWidgets.dart';
import '../Utils/setget.dart';


class multiselectSR extends StatefulWidget {


  final List<String> tocsSelectedNamesList;
  multiselectSR(this.tocsSelectedNamesList,{Key? key}) : super(key: key);
  @override
  _multiselectSRState createState() => _multiselectSRState();
}


class _multiselectSRState extends State<multiselectSR> {
  String menu = "";
  final searchCOnt = TextEditingController();
  bool isNormalStation = true;
  bool isSelected = false;


  List<String>SelectedNames=[];
  List<String>SelectedNamesids=[];
  List<bool>SelectedNamesboolids=[];
  List<dynamic> _profileList = [];
  String caseTile="";
  String icon="";
  TextEditingController otherReason = TextEditingController();
  bool _isLoading = false;
  List<dynamic> reassonIssueList = [];

  List<bool>ISSUESelectedBool=[];


  @override
  void initState() {
    apicall();


    super.initState();
    print(SelectedNames);
    clearlist();
    List<num> numberList = [];
    final RegExp regex = RegExp(r'\d+');


    for (var item in widget.tocsSelectedNamesList) {
      if (item is String) {
        final Iterable<Match> matches = regex.allMatches(item);
        for (Match match in matches) {
          numberList.add(num.parse(match.group(0)!));
        }
      } else if (item is num) {
        numberList.add(item.length);
      }
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        for (var i = 0; i < numberList.length; i++) {
          for (var j = 0; j < _profileList.length; j++) {
            if (numberList[i] == j) {
              _profileList[j].isSelected=true;
            }
          }
        }
      });});
    dataGet();
  }

  apicall() async {
    String shopid = await Utils().getUsererId();
    String access = await Utils().getAccess();
    _profileList = await AddReportService().UserProfieService(shopid, access);
  }


  clearlist()
  async{
    SelectedNames.clear();
  }

  dataGet()
  async {
    await Future.forEach(_profileList, (element) {
    });

  }

  // checkUser() async {
  //   LoginModel user = await SqliteDB.instance.getLoginModelData();
  //   isNormalStation = user.RAILPAYSTATIONTYPE == "Common";
  // }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: secondryColor,
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: .1,
        progressIndicator:const LoadingBar(),
        inAsyncCall: _isLoading ? true:false,
        child: SafeArea(
          child:Stack(
            children: [
              Container(
                decoration: gradientDecoration,
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:8.h,),

                    Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                        child:headingText(
                          title:"Territory",
                        )),
                    LargeSpace(),


                    Expanded(
                      child:RawScrollbar(
                          trackVisibility: true,
                          thumbColor: primaryColor,
                          trackColor: Colors.black54,
                          trackRadius: const Radius.circular(20),
                          thumbVisibility: true,
                          thickness: 8,
                          radius: const Radius.circular(
                              20),
                          scrollbarOrientation: ScrollbarOrientation.right,
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10.0),
                            itemCount:_profileList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Colors.white,
                                  ),
                                  child: CheckboxListTile(
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    title: Text(
                                      _profileList[index]['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "railLight",
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    value: _profileList[index]['id'].isSelected,
                                    onChanged: (val) {
                                      setState(() {

                                        _profileList[index]['id'].isSelected = val ;

                                      });
                                    },
                                  )
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: secondryColor,
                              );
                            },
                          )
                      ),
                    ),
                    SizedBox(height:3.h,),
                  ],
                ),
              ),

              // Positioned(
              //     top: 0,
              //     child: TopHeaderCase(
              //         title:caseTile, icon: icon)),
              Positioned(
                bottom:0,
                child: InkWell(
                  onTap:  () {

                    print(SelectedNames);

                    for (var j = 0; j < _profileList.length; j++) {
                      if (_profileList[j].isSelected == true) {
                        _profileList[j].isSelected=true;
                        SelectedNames.add(_profileList[j].toString());

                        SelectedNamesids.add(_profileList[j].toString());
                      }
                    }


                    // Map<String, dynamic> subMap =
                    //     BlocProvider.of<AddressUfnBloc>(context).submitAddressMap;
                    //
                    // Map<String, dynamic> dumpMap = {
                    //   'reason_title':  SelectedNames.toString().replaceAll("[", "").replaceAll("]", ""),
                    //   'reason': SelectedNamesids.toString().replaceAll("[", "").replaceAll("]", ""),
                    // };
                    // subMap.addAll(dumpMap);
                    Navigator.pop(context,SelectedNames);

                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 100.w,
                    height: 6.8.h,
                    color: ColorConstants.blueGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        subheadingTextBOLD(title: "Confirm "),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
