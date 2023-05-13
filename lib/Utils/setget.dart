



 import 'package:shared_preferences/shared_preferences.dart';

class  Utils{
   void setUserId(String userID) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('username', userID);
   }

   getUsererId() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString('username') ?? "";
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