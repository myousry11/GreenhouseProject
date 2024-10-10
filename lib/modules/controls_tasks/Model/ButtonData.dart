import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonData {
  final int id;
  final AssetImage image;
  final void Function(int) toggleButtonOnPress;
  final String title;
  final String valuePostFix;
  bool isSelected;
  String valuePerFix;

  final AssetImage? leftIcon;
  final AssetImage? rightIcon;
  final void Function(int)? onLeftPress;
  final void Function(int)? onRightPress;

  ButtonData({
    required this.id,
    required this.image,
    required this.toggleButtonOnPress,
    required this.title,
    required this.valuePostFix,
    required this.isSelected,
    required this.valuePerFix,
    this.leftIcon,
    this.rightIcon,
    this.onLeftPress,
    this.onRightPress,
  });
}

