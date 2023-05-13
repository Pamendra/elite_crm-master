
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;



class AddReportService{

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

}