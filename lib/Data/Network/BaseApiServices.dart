import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, String token);
  Future<dynamic> getGetWithoutTokenApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url, String token, dynamic data);
  Future<dynamic> getPostWithoutTokenApiResponse(String url, dynamic data);
    Future<dynamic> getPostFormDataApiResponse(
      String url, Map<String, String> data, String token);


}
