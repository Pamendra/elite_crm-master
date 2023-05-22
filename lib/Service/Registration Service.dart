






import 'package:dio/dio.dart';

import '../../Utils/message_contants.dart';
import '../../Utils/setget.dart';

class Updateregdata{

  sendData(

      String shopnamee,
      String address,
      String email,
      String phone,
      String territories,
      String owner,
      String c_name,
      String u_name,
      String p_name,
      String Confirm_password,



      ) async {
    String user = await Utils().getUsererId();
    String access = await Utils().getAccess();




    var dataBody = {
      "username": u_name,
      "pwd": p_name,
      "address": address,
      "email": email,
      "phone": phone,
      "territory": territories,
      "shopname": shopnamee,
      "ownername": owner,
      "contactname": c_name,
    };


    try{

      print('send data: $dataBody');
      var formData = FormData.fromMap(dataBody);


      var dio = Dio();
      dio.options.connectTimeout = Duration(milliseconds: 10000);
      dio.options.receiveTimeout = Duration(milliseconds: 10000);

      ///  https://elite-dealers.com/api/userReg.php https://elite-dealers.com/api/userRegister.php
      var response = await dio.post('https://elite-dealers.com/api/userReg.php', data: formData);

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