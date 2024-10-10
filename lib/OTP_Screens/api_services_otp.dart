import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled6/shared/components/constants.dart';

import 'login_response_model.dart';


class APIService {
  static var client = http.Client();

  static Future<LoginResponseModel> otpLogin(String mobileNo) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Constants.baseURL, Constants.otpLoginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"phone": mobileNo}),
    );

    return loginResponseJson(response.body);
  }

  static Future<LoginResponseModel> verifyOtp(
      String mobileNo,
      String otpHash,
      String otpCode,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Constants.baseURL, Constants.verifyOTPAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"phone": mobileNo, "otp": otpCode, "hash": otpHash}),
    );

    return loginResponseJson(response.body);
  }

  static Future<LoginResponseModel> resetPassword(
      String mobileNo,
      String newPassword,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Constants.baseURL, Constants.resetPasswordAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"phone": mobileNo, "newPassword": newPassword}),
    );

    return loginResponseJson(response.body);
  }

  static Future<LoginResponseModel> login(String email, String password) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Constants.baseURL, Constants.login);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"email": email, "password": password}),
    );

    return loginResponseJson(response.body);
  }
}
