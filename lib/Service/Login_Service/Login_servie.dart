
// ignore_for_file: file_names

import 'package:dio/dio.dart';

import '../../Utils/message_contants.dart';
import '../../Utils/setget.dart';

class LoginService {
  loginUser(String username, String password) async {
    var body = {"email": username, "password": password};

    try {
      var formData = FormData.fromMap(body);

      var response = await Dio().post('https://elite-dealers.com/api/checklog.php', data: formData);

      if (response.statusCode == 200) {
        if(response.data['status'] == "success"){
          Utils().setUserId(response.data['user']['shopid']);
          Utils().setAccess(response.data['user']['access']);
        } else if(response.data['status'] == "Failed"){
          return ConstantsMessage.incorrectPassword;
        }
      } else {
        return ConstantsMessage.incorrectPassword;
      }
    } catch (e) {
      return ConstantsMessage.serveError;
    }
  }
}
