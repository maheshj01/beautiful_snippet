import 'package:flutter/material.dart';

enum AppTheme { dark, light }
enum CodeTheme { monokai }

class SpecsModel extends ChangeNotifier {
  Color _backgroundColor = Colors.white;
  Color _borderColor = Colors.black;
  AppTheme _theme = AppTheme.dark;
  CodeTheme _codeTheme = CodeTheme.monokai;

  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color bgColor) {
    _backgroundColor = bgColor;
    notifyListeners();
  }

  Color get borderColor => _borderColor;
  set borderColor(Color borderColor) {
    _backgroundColor = borderColor;
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
