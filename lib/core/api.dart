import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';




  const String BASE_URL = "http://192.168.1.4:8080/actionaid/";
//const String BASE_URL = "http://172.20.10.2:8080/actionaid/";


//response Data Collections
Map<String, dynamic> responseJson ;
Map<String, dynamic> responseData ;


getHeaders() async{

  Map <String,String> headers={
    "Content-type" : "application/x-www-form-urlencoded"
  };



  return headers;
}











device_isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } on SocketException catch (_) {
    return false;
  }
}