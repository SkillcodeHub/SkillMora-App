import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Response/app_excaptions.dart';
import 'BaseApiServices.dart';
import 'package:http_parser/http_parser.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url, String token) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearear $token',
        'Content-Type': 'application/json',
      }).timeout(Duration(seconds: 600));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getGetWithoutTokenApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 100));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, String token, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
              headers: {
                'Authorization': 'Bearer $token',
                // 'Content-Type': 'application/json',
              },
              body: data)
          .timeout(Duration(seconds: 200));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }



  Future getPostWithoutTokenApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await post(Uri.parse(url), body: data).timeout(Duration(seconds: 40));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  //   Future getPostFormDataApiResponse(
  //     String url, String token,Map<String, String> data) async {
  //   dynamic responseJson;
  //   try {
  //     var request = http.MultipartRequest('POST', Uri.parse(url),);

  //     data.forEach((key, value) {
  //       request.fields[key] = value;
  //     });

  //     var streamedResponse =
  //         await request.send().timeout(Duration(seconds: 200));
  //     var response = await http.Response.fromStream(streamedResponse);

  //     responseJson = returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet Connection');
  //   }
  //   return responseJson;
  // }

Future getPostFormDataApiResponse(
    String url, 
    Map<String, String> data,
    String accessToken  // Make sure this is the ACCESS token
) async {
  dynamic responseJson;
  try {

    print(accessToken);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    
    request.headers.addAll({
      'Authorization': 'Bearear $accessToken',
      'Content-Type': 'multipart/form-data'
    });
    
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    
    var streamedResponse = await request.send().timeout(Duration(seconds: 200));
    var response = await http.Response.fromStream(streamedResponse);
    
    responseJson = returnResponse(response);
  } on SocketException {
    throw FetchDataException('No Internet Connection');
  }
  return responseJson;
}
  
  
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responsejson = jsonDecode(response.body);
        return responsejson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw BadRequestException(response.body.toString());
      case 500:
        throw BadRequestException(response.body.toString());
      case 403:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with server ' +
                'with status code ' +
                response.statusCode.toString());
    }
  }
}
