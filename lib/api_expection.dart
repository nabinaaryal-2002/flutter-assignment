import 'dart:io';

import 'package:dio/dio.dart';

class DioException {
  static String getDioError(DioError dioError) {
    if (dioError.response != null) {
      return _handleStatusCode(dioError.response!);
    } else if (dioError.error is SocketException) {
      return 'No Internet.';
    } else {
      return 'Unexpected error occurred.';
    }
  }

  static String _handleStatusCode(Response response) {
    switch (response.statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops, something went wrong!';
    }
  }
}