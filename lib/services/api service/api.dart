import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:reada/app/flavour/flavor_config.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/services/api%20service/api_response.dart';
import 'package:reada/services/app_logger.dart';
import 'package:reada/services/local_storage_service.dart';
import 'package:reada/shared/constants.dart';

class Api {
  final AppFlavorConfig _config = locator<AppFlavorConfig>();
  static const bool useStaging = false;
  String get _baseUrl => _config.apiBaseUrl;

  Map<String, String> headers = {
    HttpHeaders.acceptHeader: 'application/json',
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final log = applogger(Api);
  final LocalStorageService localStorageService =
      locator<LocalStorageService>();

  ///Sends a POST request to the given URL with the given body.
  Future<ApiResponse> postData(
    String url,
    dynamic body, {
    bool hasHeader = false,
    bool isMultiPart = false,
    File? fileList,
  }) async {
    try {
      dynamic request;
      if (isMultiPart) {
        if (fileList != null) {
          final multiPartequest =
              MultipartRequest('POST', Uri.parse(_baseUrl + url));

          final file = fileList;
          final filename = file.path.split('/').last;
          final fileStream = ByteStream(file.openRead());
          final fileLength = await file.length();
          MultipartFile multipartFile;

          if (body != null) {
            multipartFile = MultipartFile(
              'file',
              fileStream,
              fileLength,
              filename: filename,
            );
            multiPartequest.fields.addAll(body);
          } else {
            multipartFile = MultipartFile(
              'file',
              fileStream,
              fileLength,
              filename: filename,
            );
          }
          multiPartequest.files.add(multipartFile);
          request = multiPartequest;
        }
      } else {
        request = Request('POST', Uri.parse(_baseUrl + url));
      }

      log.d('POST request to ${_baseUrl + url} with body: $body');
      //with body: $body
      return await _sendRequest(
        request,
        hasHeader,
        body: body,
        isMultiPart: isMultiPart,
      );
    } on SocketException catch (e) {
      debugPrint('$e');
      log.e('SocketException: $e');
      return ApiResponse(
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on TimeoutException catch (e) {
      log.e('TimeoutException: $e');
      return ApiResponse.timout();
    } on ClientException catch (e) {
      log.e('Error: $e');

      return ApiResponse(
        isSuccessful: false,
        message: 'There was a problem connecting to the server',
      );
    } on Exception catch (e, s) {
      log.e('Error: $e', stackTrace: s);

      return ApiResponse(
        isSuccessful: false,
        message: Constants.genericError,
      );
    } catch (e, s) {
      debugPrint('$e');
      log.e('Error: $e', stackTrace: s);

      return ApiResponse(
        isSuccessful: false,
        message: Constants.genericError,
      );
    }
  }

  ///Sends a POST request with multiple files and names.
  ///Takes a map of {"fileNames": File}
  Future<ApiResponse> postMultipleFilesData(
    String url,
    dynamic body, {
    bool hasHeader = false,
    required Map<String, File?> files,
  }) async {
    try {
      final multiPartequest =
          MultipartRequest('POST', Uri.parse(_baseUrl + url));

      for (var file in files.entries) {
        if (file.value != null) {
          final filename = file.value!.path.split('/').last;
          final fileStream = ByteStream(file.value!.openRead());
          final fileLength = await file.value!.length();
          final multipartFile = MultipartFile(
            file.key,
            fileStream,
            fileLength,
            filename: filename,
          );

          multiPartequest.files.add(multipartFile);
        }
      }

      // final request = await files.entries
      //     .map((file) async {
      //       if (file.value != null) {
      //         final filename = file.value!.path.split('/').last;
      //         final fileStream = ByteStream(file.value!.openRead());
      //         final fileLength = await file.value!.length();
      //         final multipartFile = MultipartFile(
      //           file.key,
      //           fileStream,
      //           fileLength,
      //           filename: filename,
      //         );

      //         multiPartequest.files.add(multipartFile);
      //         return multiPartequest;
      //       }
      //     })
      //     .toList()
      //     .last;

      if (body != null) {
        multiPartequest.fields.addAll(body);
      }

      log.d('POST request to ${_baseUrl + url} with body: $body');
      //with body: $body
      return await _sendRequest(
        multiPartequest,
        hasHeader,
        body: body,
        isMultiPart: true,
      );
    } on SocketException catch (e) {
      debugPrint('$e');
      log.e('SocketException: $e');
      return ApiResponse(
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on TimeoutException catch (e) {
      log.e('TimeoutException: $e');
      return ApiResponse.timout();
    } on ClientException catch (e) {
      log.e('Error: $e');
      return ApiResponse(
        isSuccessful: false,
        message: 'There was a problem connecting to the server',
      );
    } on Exception catch (e, s) {
      log.e('Error: $e', stackTrace: s);

      return ApiResponse(
        isSuccessful: false,
        message: Constants.genericError,
      );
    } catch (e, s) {
      debugPrint('$e');
      log.e('Error: $e', stackTrace: s);

      return ApiResponse(
        isSuccessful: false,
        message: Constants.genericError,
      );
    }
  }

  Future<ApiResponse> patchData(
    String url,
    dynamic body, {
    bool isMultiPart = false,
    File? fileList,
    bool hasHeader = false,
  }) async {
    try {
      dynamic request;
      if (isMultiPart) {
        if (fileList != null) {
          final multiPartequest =
              MultipartRequest('PATCH', Uri.parse(_baseUrl + url));

          final file = fileList;
          final filename = file.path.split('/').last;
          final fileStream = ByteStream(file.openRead());
          final fileLength = await file.length();
          MultipartFile multipartFile;

          if (body != null) {
            multipartFile = MultipartFile(
              'file',
              fileStream,
              fileLength,
              filename: filename,
            );
            multiPartequest.fields.addAll(body);
          } else {
            multipartFile = MultipartFile(
              'file',
              fileStream,
              fileLength,
              filename: filename,
            );
          }
          multiPartequest.files.add(multipartFile);
          request = multiPartequest;
        }
      } else {
        request = Request('PATCH', Uri.parse(_baseUrl + url));
      }

      log.d('PATCH request to ${_baseUrl + url} with body: $body');
      //with body: $body
      return await _sendRequest(
        request,
        hasHeader,
        body: body,
        isMultiPart: isMultiPart,
      );
    } on SocketException catch (e) {
      debugPrint('$e');
      log.e('SocketException: $e');
      return ApiResponse(
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on TimeoutException catch (e) {
      log.e('TimeoutException: $e');
      return ApiResponse.timout();
    } on Exception catch (e) {
      log.e('Error: $e');

      return ApiResponse(
        isSuccessful: false,
        message: e.toString(),
      );
    } catch (e, s) {
      log.d(s);
      debugPrint('$e');
      return ApiResponse(
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse> getData(
    String url, {
    bool hasHeader = false,
    String? key,
    bool retry = false,
    bool? exludeBaseUrl,
  }) async {
    Request request;
    try {
      request = Request(
        'GET',
        exludeBaseUrl == true ? Uri.parse(url) : Uri.parse(_baseUrl + url),
      );

      log.d('GET request to ${request.url}  ');
      return await _sendRequest(
        request,
        hasHeader,
      );
    } on SocketException catch (e) {
      log.e('SocketException: $e');
      return ApiResponse(
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on TimeoutException catch (e) {
      log.e('TimeoutException: $e');
      return ApiResponse.timout();
    } on Exception catch (e) {
      log.e('Error signing in with: $e');

      return ApiResponse(
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse> deleteData(
    String url, {
    dynamic body,
    bool hasHeader = false,
    String? key,
  }) async {
    Request request;
    try {
      request = Request(
        'DELETE',
        Uri.parse(_baseUrl + url),
      );

      log.d('DELETE request to ${request.url}  ');
      return await _sendRequest(
        request,
        hasHeader,
        body: body,
      );
    } on SocketException catch (e) {
      log.e('SocketException: $e');
      return ApiResponse(
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on TimeoutException catch (e) {
      log.e('TimeoutException: $e');
      return ApiResponse.timout();
    } on Exception catch (e) {
      log.e('Error signing in with: $e');

      return ApiResponse(
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  ///Handles the sending of the request and returns the response.
  Future<ApiResponse> _sendRequest(
    dynamic request,
    bool hasHeader, {
    Map<String, dynamic>? body,
    bool isMultiPart = false,
  }) async {
    if (body != null && !isMultiPart) {
      request.body = json.encode(body);
    }
    Map<String, String> networkHeaders;
    if (isMultiPart) {
      if (body != null) {
        request.fields.addAll(body);
      }
      networkHeaders = {
        HttpHeaders.acceptHeader: '*/*',
        'Content-Type':
            'multipart/form-data; boundary=63c5979328c44e2c869349443a94200e',
      };
    } else {
      networkHeaders = headers;
    }
    if (hasHeader) {
      final userValue = await localStorageService
          .getStorageValue(LocalStorageKeys.accessToken);
      networkHeaders['Authorization'] = 'Bearer $userValue';
    }
    request.headers.addAll(networkHeaders);
    final response = await request.send();
    // .timeout(
    //       const Duration(milliseconds: 8000),
    //     );

    return _response(response);
  }
}

Future<ApiResponse> _response(
  StreamedResponse response,
) async {
  final log = applogger(Api);
  // log.d(response.statusCode.toString());

  if (response.statusCode == 200 || response.statusCode == 201) {
    final responseBody = await response.stream.bytesToString();
    log.d('Response from ${response.request!.url} : $responseBody');

    String? message;
    dynamic decodedJson;
    if (responseBody.isNotEmpty) {
      decodedJson = jsonDecode(responseBody);

      if (decodedJson is Map) {
        message = decodedJson['message'] as String?;
      }
    } else {
      decodedJson = null;
    }

    if (message?.toLowerCase().trim() == 'internal server error' ||
        message?.toLowerCase().trim() == 'server error') {
      return ApiResponse(
        isSuccessful: false,
        data: decodedJson,
        message: message ?? 'Internal server error',
      );
    }
    return ApiResponse(
      isSuccessful: true,
      data: decodedJson,
      message: message ?? 'success',
    );
  } else if (response.statusCode == 204) {
    return ApiResponse(
      isSuccessful: true,
      message: 'success',
    );
  } else if (response.statusCode >= 400 && response.statusCode <= 499) {
    final responseBody = await response.stream.bytesToString();
    log.e(
      'Response of ${response.statusCode}  from ${response.request!.url} : $responseBody',
    );
    final responseBodyDecoded = jsonDecode(responseBody);
    log.e('Json  $responseBodyDecoded');

    // temp.log(responseBodyDecoded.toString());

    final responseModel = ApiResponse.fromJson(responseBodyDecoded);
    // ignore: cascade_invocations
    responseModel.code = response.statusCode;
    return responseModel;
  } else if (response.statusCode >= 500 && response.statusCode <= 599) {
    final responseBody = await response.stream.bytesToString();
    log.e(
      'Response of ${response.statusCode}  from ${response.request!.url} : $responseBody',
    );
    return ApiResponse(
      isSuccessful: false,
      message: kReleaseMode
          ? 'Error occured while Communication with our Server, please try again'
          : 'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
    );
  } else {
    final responseBody = await response.stream.bytesToString();
    log.e(
      'Response of ${response.statusCode}  from ${response.request!.url}  $responseBody',
    );
    return ApiResponse(
      isSuccessful: false,
      message: kReleaseMode
          ? 'Error occured '
          : 'Error occured : ${response.statusCode}',
    );
  }
}
