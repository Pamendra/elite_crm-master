






import 'package:dio/dio.dart';

import '../../Utils/message_contants.dart';
import '../../Utils/setget.dart';

class Addreportdata{

  sendData(

      String leadId,
      String name,
      String cname,
      String gmanager,
      String pmanager,
      String services,
      String category,
      String status,
      String vdate,
      String dealerIds,
      String gnote,
      String dealernotes,



      ) async {
    String user = await Utils().getUsererId();
    String sid = await Utils().getUsererId();



    var dataBody = {
      "userid" : user,
      "leadId": leadId,
      "name": name,
      "cname": cname,
      "gmanager": gmanager,
      "pmanager": pmanager,
      "services": services,
      "category": category,
      "status": status,
      "vdate": vdate,
      "dealerIds": dealerIds,
      "gnote": gnote,
      "dealernotes": dealernotes,
      "sid": leadId,
    };


    try{

      print('send data: $dataBody');
      var formData = FormData.fromMap(dataBody);


      var dio = Dio();
      dio.options.connectTimeout = const Duration(milliseconds: 10000);
      dio.options.receiveTimeout = const Duration(milliseconds: 10000);


      var response = await dio.post('https://elite-dealers.com/api/saveExistingLeadReport.php', data: formData);

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
        return response.data;
      } else {
        return ConstantsMessage.statusError;
      }
    }catch(e){
      print('Error occurred: $e');
      return ConstantsMessage.serveError;
    }
  }
}