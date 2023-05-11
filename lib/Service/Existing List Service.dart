
import 'dart:convert';
import 'package:http/http.dart' as http;



class ExistingList{

  Future<Map<String, dynamic>> fetchSearchExistingData() async {
    var apiUrl = Uri.parse('https://elite-dealers.com/api/checkExistingLeads.php?keyword=tes&userid=46');
    var response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}