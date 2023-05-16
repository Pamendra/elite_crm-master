import 'package:flutter/material.dart';

class PreviewData extends StatelessWidget {
  final List<String> dataList;

  const PreviewData({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(dataList[index]),
        ),
      ),
    );
  }
}
