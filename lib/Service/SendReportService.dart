//
//
//
//
// import 'package:dio/dio.dart';
//
// import '../Utils/message_contants.dart';
//
// class SendReportService {
//
//   sendData() async {
//
//
//
//
//     var dataBody = {
//
//
//     };
//
//
//     try{
//
//       print('send data: $dataBody');
//       var formData = FormData.fromMap(dataBody);
//
//
//       var dio = Dio();
//       dio.options.connectTimeout = Duration(milliseconds: 10000);
//       dio.options.receiveTimeout = Duration(milliseconds: 10000);
//
//
//       var response = await dio.post('http://51.140.217.38:8000/pcds/api/auto-count-app-services', data: formData);
//
//       if (response.statusCode == 200) {
//         print('Response data: ${response.data}');
//         return response.data;
//       } else {
//         return ConstantsMessage.statusError;
//       }
//     }catch(e){
//       print('Error occurred: $e');
//       return ConstantsMessage.serveError;
//     }
//   }
//
//
// }