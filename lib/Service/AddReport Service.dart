
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:elite_crm/Utils/dialogs_utils.dart';
import 'package:http/http.dart' as http;

import '../Screens/Notification/Model/Notification_model.dart';



class AddReportService{

  /// Notification Page Api's

  Future<NotificationService> fetchData(String id) async {
    final dio = Dio();
    final response = await dio.post(
      'https://elite-dealers.com/api/notify_details.php',
      data: FormData.fromMap({'notify_id': id}),
    );
    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      final notification = NotificationService.fromJson(jsonResponse);
      return notification;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List> notification(String user_id) async {
    var body = {"user_id": user_id};
    var formData = FormData.fromMap(body);
    var response = await Dio().post('https://elite-dealers.com/api/notifi_list.php', data: formData);
    if (response.statusCode == 200) {
      var decodedJson = response.data;
      List messages  = decodedJson['messages'];
      return messages ;
    } else {
      throw Exception("API returned an error");
    }
  }

/// Register Page dropdown data
  Future<List> regProfieService() async {

    var response = await Dio().post('https://elite-dealers.com/api/getTerritory.php');
    if (response.statusCode == 200) {
      var decodedJson = response.data;
      List territory  = decodedJson['territory'];
      return territory ;
    } else {
      throw Exception("API returned an error");
    }
  }

  /// User Profile Api's

  Future<List> UserProfieService(String user_id, String access) async {
    var body = {"user_id": user_id, "usraccess": access};
    var formData = FormData.fromMap(body);
    var response = await Dio().post('https://elite-dealers.com/api/userprof.php', data: formData);
    if (response.statusCode == 200) {
      var decodedJson = response.data;
      List territory  = decodedJson['territory'];
      return territory ;
    } else {
      throw Exception("API returned an error");
    }
  }


  Future<List> userDetails(String user_id, String access) async {
    var body = {"user_id": user_id, "usraccess": access};
    var formData = FormData.fromMap(body);
    var response = await Dio().post('https://elite-dealers.com/api/userprof.php', data: formData);
    if (response.statusCode == 200) {
      var decodedJson = response.data;
      List details  = decodedJson['messages'];
      return details ;
    } else {
      throw Exception("API returned an error");
    }
  }


/// Existing Lead Api's


  Future<List> getLeads(String keyword,String user_id) async {
    String url =
        "https://elite-dealers.com/api/checkExistingLeads.php?keyword=$keyword&userid=$user_id";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      List leads = decodedJson['user']['result'];
      return leads;
    } else {
      throw Exception("API returned an error");
    }
  }

  /// Customer List Api's

  Future<List> Customer() async {
    String url =
        "https://elite-dealers.com/api/getCustomerList.php?status=active&territory=Austin%23Chicago";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      List cust = decodedJson['rescustomer']['result'];
      return cust;
    } else {
      throw Exception("API returned an error");
    }
  }

  /// Previous Report Service

  Future<List?> previousReport(String id, String sid) async {
    var response = await Dio().get('https://elite-dealers.com/api/getPreviousReports.php?userid=$id&dealerId=$sid');
    if (response.statusCode == 200) {
     if(response.data["status"]== "success")
       {
         var decodedJson = response.data;
         List report  = decodedJson['result'];
         return report ;
       } else if(response.data["status"] == "failed"){
       return [];
     }
    } else {
      throw Exception("API returned an error");
    }
  }


}