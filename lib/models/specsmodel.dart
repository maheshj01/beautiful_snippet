import 'package:flutter/material.dart';

enum AppTheme { dark, light }
enum CodeTheme { monokai }

class SpecsModel extends ChangeNotifier {
  Color _backgroundColor = Colors.white;
  Color _borderColor = Colors.black;
  AppTheme _theme = AppTheme.dark;
  CodeTheme _codeTheme = CodeTheme.monokai;
  bool _hasBorder = true;

  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color bgColor) {
    _backgroundColor = bgColor;
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
