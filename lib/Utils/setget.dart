



 import 'package:shared_preferences/shared_preferences.dart';

class  Utils{
  void setUsername(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', userID);
  }
  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? "";
  }

   void setUserId(String userID) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('user_id', userID);
   }

   getUsererId() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString('user_id') ?? "";
   }

   void setAccess(String access) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('access', access);
   }

   getAccess() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString('access') ?? "";
   }
}