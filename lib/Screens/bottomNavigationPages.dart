// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../Utils/color_constants.dart';
import 'AddReport/Existing_Leaad.dart';
import 'Homepage.dart';
import 'User_profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var currentIndex = 1;
  List<Widget> pages = [
    const userprofile_pages(),
    const DealerList(),
    const AddReport()
  ];
  List<IconData> listOfIcons = [
    Icons.person,
    Icons.list,
    Icons.add_circle,
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.DarkBlueColor ,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 10),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            // splashColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: index == 1
                        ? 0
                        : size.width * .0600, // adjust margin for 2 icons
                    left: index == 1 ? 0 : size.width * .0500,
                  ),
                  width: size.width * .250,
                  height: index == currentIndex ? size.width * .014 : 0,
                  decoration: BoxDecoration(
                    color: ColorConstants.deppp,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                  listOfIcons[index],
                  size: size.width * .096,
                  color: index == currentIndex
                      ? ColorConstants.deppp
                      : ColorConstants.DarkBlueColor,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
