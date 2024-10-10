import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

class Constants {
  // primary color
  static var primaryColor = const Color(0xff296e48);

  // onboarding texts
  static var titleOne1 = 'SMART PLANT';
  static var titleOne2 = 'SENSORS';
  static var descriptionOne = 'User can keep track of the temperature, humidity, soil moisture, and other important parameters of their plants and take appropriate actions to ensure the optimal growth and health of their plants.';
  static var titleTwo1 = 'SMART IRRIGATION';
  static var titleTwo2 = 'STATION';
  static var descriptionTwo = 'Smart irrigation systems utilizing water pumps in greenhouses leverage advanced technology to optimize water usage and automate the irrigation process, ensuring efficient and precise watering for plants.';
  static var titleThree1 = 'SMART';
  static var titleThree2 = 'SOLAR PANEL';
  static var descriptionThree = 'Solar Panel integrate solar technology with greenhouse infrastructure to harness renewable energy while creating an environment conducive to optimal plant growth.';
  static var titleFour1 = 'SMART';
  static var titleFour2 = 'LIGHTING';
  static var descriptionFour = 'Lighting integrate advanced technologies, including LED lighting, sensors, and automated controls, to create an ideal lighting environment that mimics natural sunlight and fulfills the specific light requirements of different plant species.';
  static var titleFive1 = 'PLANT DISEASE';
  static var titleFive2 = 'DETECTION';
  static var descriptionFive = 'They prevent crop diseases from occurring frequently and the losses that follow from them. The automated disease detection system that uses AI follows predetermined steps.';

  static const String baseURL = 'http://192.168.60.46:3000';
  static const String editProfile = '$baseURL/editprofile';
  static const String register = '$baseURL/register';
  static const String refreshToken = '$baseURL/refreshToken';
  static const String login = '$baseURL/login';
  static const String classification = '$baseURL/classificationimage';
  static const String appName = "Green House App";
  static const String otpLoginAPI = "$baseURL/users/otpLogin";
  static const String verifyOTPAPI = "$baseURL/users/verifyOTP";
  static const String resetPasswordAPI = "/users/resetPassword";
  static const String changePasswordAPI = '$baseURL/changePassword';



}

const Color kTopColor = Color(0xFFFFA27D);
const Color kBottomColor = Color(0xFFC83831);
const Color kContourColor = Color(0xFFFF8670);
const int kWaveLength = 280;
const Size kSize = Size(200, 200);




