import 'dart:convert';

import 'package:dio/dio.dart' as dio;


class BaseApiUtils {


  /// -----------------------------------------
  ///  BUILD HEADERS (JSON + MULTIPART)
  /// -----------------------------------------
  static Map<String, String> _jsonHeaders({
    String authorization = "",
  }) {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      if (authorization != "") "Authorization": authorization,
    };
  }

  static Map<String, String> _multipartHeaders({
    String authorization = "",
  }) {
    return {
      "Content-Type": "multipart/form-data",
      if (authorization != "") "Authorization": authorization,
    };
  }

  /// -----------------------------------------
  ///  UNIVERSAL REQUEST HANDLER
  /// -----------------------------------------
  static Future<void> _request({
    required String url,
    required String method,
    required Function onSuccess,
    required Function onFail,
    required Function onExceptionFail,
    Map<String, dynamic>? data,
    dio.FormData? formData,
    Map<String, dynamic>? queryParams,
    required Map<String, String> headers,
  }) async {
    try {
      final response = await dio.Dio().request(
        url,
        data: formData ?? (data != null ? jsonEncode(data) : null),
        queryParameters: queryParams,
        options: dio.Options(
          method: method,
          headers: headers,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess(response.data?["message"], response.data);
      } else {
        onFail(response.data?["message"], response.data);
      }
    } on dio.DioException catch (e) {
      onExceptionFail(
        e.response?.data?["message"] ?? "Something went wrong",
        e.response?.data,
      );
    } catch (e) {
      onExceptionFail("Unexpected error occurred", null);
    }
  }

  /// -----------------------------------------
  ///  POST API
  /// -----------------------------------------


  static Future<void> post({
    required String url,
    Map<String, dynamic>? data,
    dio.FormData? formData,
    String authorization = "",
    required Function onSuccess,
    required Function onFail,
    required Function onExceptionFail,
  }) async {
    return _request(
      url: url,
      method: "POST",
      data: data,
      formData: formData,
      headers: formData != null ?
      _multipartHeaders(authorization: authorization) :
      _jsonHeaders(authorization: authorization),
      onSuccess: onSuccess,
      onFail: onFail,
      onExceptionFail: onExceptionFail,
    );
  }


  /// -----------------------------------------
  ///  PUT API
  /// -----------------------------------------


  static Future<void> put({
    required String url,
    Map<String, dynamic>? data,
    dio.FormData? formData,
    String authorization = "",
    required Function onSuccess,
    required Function onFail,
    required Function onExceptionFail,
  }) async {
    return _request(
      url: url,
      method: "PUT",
      data: data,
      formData: formData,
      headers: formData != null ?
      _multipartHeaders(authorization: authorization) :
      _jsonHeaders(authorization: authorization),
      onSuccess: onSuccess,
      onFail: onFail,
      onExceptionFail: onExceptionFail,
    );
  }

  /// -----------------------------------------
  ///  PATCH API
  /// -----------------------------------------


  static Future<void> patch({
    required String url,
    Map<String, dynamic>? data,
    dio.FormData? formData,
    String authorization = "",
    required Function onSuccess,
    required Function onFail,
    required Function onExceptionFail,
  }) async {
    return _request(
      url: url,
      method: "PATCH",
      data: data,
      formData: formData,
      headers: formData != null ?
      _multipartHeaders(authorization: authorization) :
      _jsonHeaders(authorization: authorization),
      onSuccess: onSuccess,
      onFail: onFail,
      onExceptionFail: onExceptionFail,
    );
  }


  /// -----------------------------------------
  ///  DELETE API
  /// -----------------------------------------


  static Future<void> delete({
    required String url,
    Map<String, dynamic>? data,
    dio.FormData? formData,
    String authorization = "",
    required Function onSuccess,
    required Function onFail,
    required Function onExceptionFail,
  }) async {
    return _request(
      url: url,
      method: "DELETE",
      data: data,
      formData: formData,
      headers: formData != null ?
      _multipartHeaders(authorization: authorization) :
      _jsonHeaders(authorization: authorization),
      onSuccess: onSuccess,
      onFail: onFail,
      onExceptionFail: onExceptionFail,
    );
  }


  /// -----------------------------------------
  ///  GET API
  /// -----------------------------------------


  static Future<void> get({
    required String url,
    Map<String, dynamic>? data,
    dio.FormData? formData,
    String authorization = "",
    required Function onSuccess,
    required Function onFail,
    required Function onExceptionFail,
  }) async {
    return _request(
      url: url,
      method: "GET",
      data: data,
      formData: formData,
      headers: formData != null ?
      _multipartHeaders(authorization: authorization) :
      _jsonHeaders(authorization: authorization),
      onSuccess: onSuccess,
      onFail: onFail,
      onExceptionFail: onExceptionFail,
    );
  }

}