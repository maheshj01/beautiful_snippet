import 'dart:math';

import 'package:beautiful_snippet/constants/colors.dart';
import 'package:flutter/material.dart';

enum AppTheme { dark, light }
enum CodeTheme { monokai }

class SpecsModel extends ChangeNotifier {
  SpecsModel() {
    init();
  }

  void init() {
    final random = Random();
    final randomIndex = random.nextInt(backgroundColors.length);
    _backgroundColor = backgroundColors[randomIndex];
  }

  late Color _backgroundColor;
  Color _snippetBackgroundColor = black;
  Color _snippetHeaderColor = black;
  Color _borderColor = black;
  AppTheme _theme = AppTheme.dark;
  CodeTheme _codeTheme = CodeTheme.monokai;
  bool _hasBorder = false;
  String? _language;
  String _sourceCode = """///·Lets·write·some·Beautiful·code""";
  String get sourceCode => _sourceCode;
  set sourceCode(String code) {
    _sourceCode = code;
    notifyListeners();
  }

  String get language => _language!;
  set language(String code) {
    _language = code;
    notifyListeners();
  }

  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color bgColor) {
    _backgroundColor = bgColor;
    notifyListeners();
  }

  Color get snippetBackgroundColor => _snippetBackgroundColor;
  set snippetBackgroundColor(Color bgColor) {
    _snippetBackgroundColor = bgColor;
    notifyListeners();
  }

  Color get snippetHeaderColor => _snippetHeaderColor;
  set snippetHeaderColor(Color color) {
    _snippetHeaderColor = color;
    notifyListeners();
  }

  bool get hasBorder => _hasBorder;
  set hasBorder(bool value) {
    _hasBorder = value;
    notifyListeners();
  }

  Color get borderColor => _borderColor;
  set borderColor(Color borderColor) {
    _borderColor = borderColor;
    notifyListeners();
  }

  AppTheme get theme => _theme;
  set theme(AppTheme theme) {
    _theme = theme;
    notifyListeners();
  }

  CodeTheme get codeTheme => _codeTheme;
  set codeTheme(CodeTheme theme) {
    _codeTheme = theme;
    notifyListeners();
  }
}
