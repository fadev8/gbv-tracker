import 'dart:convert' as convert;
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io';




    const String BASE_URL = "http://192.168.1.9:8080/actionaid/";
//   const String BASE_URL = "http://172.20.10.2:8080/actionaid/";


//Login  Data Collections
Map<String, dynamic> responseJson ;
Map<String, dynamic> responseData ;



// Dashboard Data Collection
Map<String, dynamic> responseOverviewJson ;
Map<String, dynamic> responseOverviewData ;

Map<String, dynamic> responseFigureDataJson ;
Map<String, dynamic> responseFigureData ;

Map<String, dynamic> responseAllCasesDataJson ;
Map<String, dynamic> responseAllCasesData ;


Map<String, dynamic> receivedCasesListJson ;
List<dynamic> receivedCasesList;



getHeaders() async{

  Map <String,String> headers={
    "Content-type" : "application/x-www-form-urlencoded"
  };



  return headers;
}


      getDefaultAdminCaseOverview() async {
        var resp = await http.post(BASE_URL+"caseoverview",
            body: {

                  'action': "get-Cases-Overview-Admin",
            });

        var jsonResponse = convert.jsonDecode(resp.body);
        return jsonResponse;

      }

getDefaultAdminCaseFigure() async {
  var resp = await http.post(BASE_URL+"caseoverview",
      body: {

        'action': "get-Cases-Figures-Admin",
      });

  var jsonResponse = convert.jsonDecode(resp.body);
  return jsonResponse;

}


    getAllCases() async {
      var resp = await http.post(BASE_URL+"caseoverview",
          body: {

                 'action': "get-All-Cases-Admin",
          });

      var jsonResponse = convert.jsonDecode(resp.body);
      return jsonResponse;

    }



    getReceivedCaseList()  async {
      var resp = await http.post(BASE_URL+"claims",
          body: {

            'action': "getReceivedCaseAdmin",
          });

      var jsonResponse = convert.jsonDecode(resp.body);
      return jsonResponse;

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