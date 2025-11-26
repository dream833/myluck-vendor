// ignore_for_file: library_prefixes

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as DIO;
import 'package:rewardvendor/app/data/config/app_config.dart';

Future<DIO.Response<dynamic>> dioGet(String endUrl) async {
  var dio = DIO.Dio();
  dio.options.headers = {
    'Cache-Control': 'no-cache, no-store, must-revalidate',
    'Pragma': 'no-cache',
    'Expires': '0',
  };
  dio.options.headers["Authorization"] =
      "Bearer ${getBox.read(USER_TOKEN) ?? ''}";

  var finalUrl = "$BASE_URL$endUrl";

  try {
    var response = await dio.get(
      finalUrl,
      options: DIO.Options(
        validateStatus: (status) => true,
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    isDebugMode.value
        ? log(
            "\n\nGET: $finalUrl\nHEADERS:\n${jsonEncode({"Authorization": getBox.read(USER_TOKEN)})}\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n",
          )
        : null;
    return response;
  } catch (e) {
    // showMessage(message: "Something went wrong", isSuccess: false);
    return DIO.Response(
      requestOptions: DIO.RequestOptions(path: endUrl),
      statusCode: 500,
      statusMessage: "Something went wrong",
      data: {"message": "Something went wrong"},
    );
  }
}

Future<DIO.Response<dynamic>> dioDelete(String endUrl) async {
  var dio = DIO.Dio();
  dio.options.headers = {
    'Cache-Control': 'no-cache, no-store, must-revalidate',
    'Pragma': 'no-cache',
    'Expires': '0',
  };
  dio.options.headers["Authorization"] =
      "Bearer "
          '"' +
      getBox.read(USER_TOKEN) +
      '"';
  var finalUrl = "$BASE_URL$endUrl";

  try {
    var response = await dio.delete(
      finalUrl,
      options: DIO.Options(
        validateStatus: (status) => true,
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    isDebugMode.value
        ? log(
            "\n\nDELETE: $finalUrl\nHEADERS:\n${jsonEncode({"authtoken": getBox.read(USER_TOKEN)})}\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n",
          )
        : null;
    return response;
  } catch (e) {
    // showMessage(message: "Something went wrong", isSuccess: false);
    return DIO.Response(
      requestOptions: DIO.RequestOptions(path: endUrl),
      statusCode: 500,
      statusMessage: "Something went wrong",
      data: {"message": "Something went wrong"},
    );
  }
}

Future<DIO.Response<dynamic>> dioPost({
  Map<String, dynamic>? data,
  String? endUrl,
  bool? isFile,
}) async {
  var finalUrl = "$BASE_URL$endUrl";
  var dio = DIO.Dio();
  dio.options.headers = {
    'Cache-Control': 'no-cache, no-store, must-revalidate',
    'Pragma': 'no-cache',
    'Expires': '0',
  };
  dio.options.headers["Authorization"] =
      "Bearer ${getBox.read(USER_TOKEN) ?? ''}";
  try {
    var response = await dio.post(
      finalUrl,
      data: DIO.FormData.fromMap(data!),
      options: DIO.Options(
        validateStatus: (status) => true,
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    isDebugMode.value
        ? log(
            "\n\nPOST: $finalUrl\nHEADERS:\n${jsonEncode({"authtoken": getBox.read(USER_TOKEN)})}\n${(isFile ?? false) ? '' : 'BODY:${jsonEncode(data)}'}\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n",
          )
        : null;
    return response;
  } catch (e) {
    log(e.toString());
    // showMessage(message: "Something went wrong", isSuccess: false);
    return DIO.Response(
      requestOptions: DIO.RequestOptions(path: endUrl ?? ""),
      statusCode: 500,
      statusMessage: "Something went wrong",
      data: {"message": "Something went wrong"},
    );
  }
}
