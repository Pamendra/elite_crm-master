






import 'package:dio/dio.dart';

import '../../Utils/message_contants.dart';
import '../../Utils/setget.dart';

class UpdateUserdata{

  sendData(String address, String email, String phone, String territories) async {
    String user = await Utils().getUsererId();
    String access = await Utils().getAccess();




    var dataBody = {
      "user_id" : user,
      "name": "",
      "address": address,
      "email": email,
      "phone": phone,
      "territories": territories,
      "owner": "",
      "cname": "",
      "useraccess": access,
    };


    try{

      print('send data: $dataBody');
      var formData = FormData.fromMap(dataBody);


      var dio = Dio();
      dio.options.connectTimeout = const Duration(milliseconds: 10000);
      dio.options.receiveTimeout = const Duration(milliseconds: 10000);


      var response = await dio.post('https://elite-dealers.com/api/updateusr.php', data: formData);

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