// ignore_for_file: file_names



import 'package:elite_crm/Utils/SizedSpace.dart';
import 'package:elite_crm/Utils/TextWidgets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import '../Service/AddReport Service.dart';
import '../Utils/ApploadingBar.dart';
import '../Utils/color_constants.dart';
import '../Utils/setget.dart';
import 'Notification/Model/multislect.dart';




class TerritoryListData extends StatefulWidget {
  const TerritoryListData({Key? key}) : super(key: key);

  @override
  State<TerritoryListData> createState() => _TerritoryListDataState();
}

class _TerritoryListDataState extends State<TerritoryListData> {
  final TextEditingController searchtrain = TextEditingController();
  List<dynamic> terr =[];
  List<Option> _options = [];
  List<Option> _selectedOptions = [];
  List<Option?> trainIDList = [];
  List<Option?> searchList = [];
  bool _isLoading = false;
  List<String> selectedOptionNames =[];
 

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isLoading = true;
    });
    getTrainListFromLOCAL();
    setState(() {
      _isLoading = false;
    });

    super.initState();
  }

  getTrainListFromLOCAL() async {
    String shopid = await Utils().getUsererId();
    String access = await Utils().getAccess();
    setState(() {
      _isLoading = true;
    });

    final response = await AddReportService().userDetails(shopid, access);
    final territory = response[0]['territory'];
    terr = territory;



    fetchData(shopid, access).then((options) {
      setState(() {
        _options = options;
        _selectedOptions = _options
            .where((option) => terr.any((item) => item['id'] == option.id))
            .toList();
      });
    });

    setState(() {
      _isLoading = false;
    });
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
          backgroundColor: ColorConstants.deppp,
        ),
        bottomNavigationBar: InkWell(
            onTap: () async{
          Navigator.pop(context, selectedOptionNames.toString().replaceAll("[","").replaceAll("]","").replaceAll(", ", ","));
              
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 100.w,
              height: 40.sp,
              color: ColorConstants.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

                  headingTextwithsmallwhite(title: 'Continue')
                ],
              ),
            )),

        body: ModalProgressHUD(
          color: Colors.white,
          opacity: .1,
          progressIndicator: const LoadingBar(),
          inAsyncCall: _isLoading ? true: false,
          child: Stack(
              children:[
                SafeArea(
                  child: Padding(
                    padding:  EdgeInsets.only(top: 15.sp,left: 24.sp,right: 24.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingText(title: 'Select Territory'),
                          LargeSpace(),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: _options.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Colors.white
                                  ),
                                  child: CheckboxListTile(
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity: ListTileControlAffinity.trailing,
                                    title: Text(
                                      _options[index].name.toString(),
                                      style: TextStyle(
                                        color: ColorConstants.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        fontFamily: "Aleo",
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    value: _selectedOptions.contains(_options[index]),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value!) {
                                          _selectedOptions.add(_options[index]);
                                          selectedOptionNames = _selectedOptions.map((option) => option.name).toList();
                                        } else {
                                          _selectedOptions.remove(_options[index]);
                                          selectedOptionNames = _selectedOptions.map((option) => option.name).toList();
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: ColorConstants.white,

                                );
                              },
                            ))

                        ]
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
