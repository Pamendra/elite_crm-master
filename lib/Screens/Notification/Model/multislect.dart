
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;



class Option {
  final String id;
  final String name;

  Option({required this.id, required this.name});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(id: json['id'], name: json['name']);
  }
}


Future<List<Option>> fetchData(String user_id, String access) async {
  var body = {"user_id": user_id, "usraccess": access};
  var formData = FormData.fromMap(body);
  var response = await Dio().post('https://elite-dealers.com/api/userprof.php', data: formData);
  if (response.statusCode == 200) {
    var decodedJson = response.data;
    List territory  = decodedJson['territory'];
    return territory.map((json) => Option.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Option>> fetchDatareg() async {

  var response = await Dio().post('https://elite-dealers.com/api/getTerritory.php');
  if (response.statusCode == 200) {
    var decodedJson = response.data;
    List territory  = decodedJson['territory'];
    return territory.map((json) => Option.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
