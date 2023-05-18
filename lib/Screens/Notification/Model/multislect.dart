// import 'package:flutter/material.dart';
// import 'package:multiselect/multiselect.dart';
//
// class HomePagew extends StatefulWidget {
//   const HomePagew({Key? key}) : super(key: key);
//
//   @override
//   State<HomePagew> createState() => _HomePagewState();
// }
//
// class _HomePagewState extends State<HomePagew> {
//   List<String> fruits = ['Apple', 'Banana', 'Graps', 'Orange', 'Mango'];
//   List<String> selectedFruits = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Multiselect Dropdown'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             DropDownMultiSelect(
//               options: fruits,
//               selectedValues: selectedFruits,
//               onChanged: (value) {
//                 print('selected fruit $value');
//                 setState(() {
//                   selectedFruits = value;
//                 });
//                 print('you have selected $selectedFruits fruits.');
//               },
//               whenEmpty: 'Select your favorite fruits',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }