import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:taskmenager_app/screens/controller/authcontroller.dart';
import 'package:taskmenager_app/screens/login_screen.dart';
import 'package:taskmenager_app/screens/runapps.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? errorMessage;

  NetworkResponse(
      {required this.isSuccess,
      required this.statusCode,
      this.data,
      this.errorMessage = "something went wrong"});
}

//-------------------------get Request------------------------
class NetworkClient {
  static final Logger _logger = Logger();
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'token': Authcontroller.token ?? '',
      };
      _preRequestCode(url, headers);
      Response response = await get(uri, headers: headers);

      _postRequestLogs(url, response.statusCode,
          responseBody: response.body, headers: response.headers);

      if (response.statusCode == 200) {
        final decodJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true, statusCode: response.statusCode, data: decodJson);
      } else if (response.statusCode == 401) {
        _movetoLogeOutScreen();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: "");
      } else {
        final decodeJson = jsonDecode(response.body);
        String errorMessage = decodeJson['data'] ?? 'Something went wrong';
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessage);
      }
    } catch (e) {
      _postRequestLogs(url, -1);
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  // ----------------------------Post Request--------------------------------

  // static Future<NetworkResponse> postRequest(
  //     {required String url, Map<String, dynamic>? body}) async {
  //   try {
  //     Uri uri = Uri.parse(url);
  //     (url, body: body);
  //     Response response = await post(
  //       uri,
  //       headers: {'Content-type': 'Application/json'},
  //       body: jsonEncode(body),
  //     );
  //     _postRequestLogs(url, response.statusCode,
  //         headers: response.headers, responseBody: response.body);
  //     if (response.statusCode == 200) {
  //       final decodedJson = jsonDecode(response.body);
  //       return NetworkResponse(
  //           isSuccess: true,
  //           statusCode: response.statusCode,
  //           data: decodedJson);
  //     } else {
  //       final decodedJson = jsonDecode(response.body);
  //       String errorMessage = decodedJson['data'] ?? 'Something went wrong';
  //       return NetworkResponse(
  //           isSuccess: false,
  //           statusCode: response.statusCode,
  //           errorMessage: errorMessage);
  //     }
  //   } catch (e) {
  //     _postRequestLogs(url, -1);
  //     return NetworkResponse(
  //         isSuccess: false, statusCode: -1, errorMessage: e.toString());
  //   }
  // }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'token': Authcontroller.token ?? '',
      };
      _preRequestCode(url, headers, body: body);

      Response response =
          await post(uri, headers: headers, body: jsonEncode(body));

      _postRequestLogs(url, response.statusCode,
          headers: response.headers, responseBody: response.body);

      if (response.statusCode == 200) {
        final jsonDcode = jsonDecode(response.body);

        return NetworkResponse(
            isSuccess: true, statusCode: response.statusCode, data: jsonDcode);
      } else if (response.statusCode == 401) {
        _movetoLogeOutScreen();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: "");
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Something went wrong';
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessage);
      }
    } catch (e) {
      _postRequestLogs(url, -1);

      return NetworkResponse(isSuccess: false, statusCode: -1);
    }
  }

  static void _preRequestCode(String url, Map<String, String> headers,
      {Map<String, dynamic>? body}) {
    _logger.i('URL => $url\n'
        'Body: $body');
  }

  // static void _postRequestLog(String url, int statusCode,
  //     {Map<String, dynamic>? headers, dynamic responsbody}) {
  //   _logger.i("URL=> $url \n"
  //       "ResponsBody=> $responsbody\n"
  //       "Header: $headers\n"
  //       "StatusCode: $statusCode");
  // }

  //   static void _preRequestLog(String url, {Map<String, dynamic>? body}) {
  //   _logger.i('URL => $url\n'
  //       'Body: $body');
  // }

  static void _postRequestLogs(String url, int statusCode,
      {Map<String, dynamic>? headers,
      dynamic responseBody,
      dynamic errorMessage}) {
    if (errorMessage != null) {
      _logger.e(''
          'Url: $url\n'
          'Status code: $statusCode\n'
          'Error Message: $errorMessage');
    } else {
      _logger.i(''
          'Url: $url\n'
          'Status code: $statusCode\n'
          'Headers: $headers\n'
          'Response: $responseBody');
    }
  }

  static Future<void> _movetoLogeOutScreen() async {
    await Authcontroller.clearUserData();
    Navigator.pushAndRemoveUntil(
        Taskmenager.navigatorKye.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (predicate) => false);
  }
}
