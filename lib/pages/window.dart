import 'package:flutter/material.dart';
import 'package:flutter_template/constants/colors.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:highlight/languages/all.dart';

class WindowBuilder extends StatefulWidget {
  final double borderRadius;

  const WindowBuilder({Key? key, this.borderRadius = 10}) : super(key: key);

  @override
  _WindowBuilderState createState() => _WindowBuilderState();
}

class _WindowBuilderState extends State<WindowBuilder> {
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 5,
                color: Colors.grey.withOpacity(0.4),
                offset: Offset(3, 6)),
            BoxShadow(
                blurRadius: 20,
                spreadRadius: 10,
                color: Color.fromRGBO(206, 213, 222, 0.8))
          ],
        ),
        child: Column(
          children: [
            HeaderBuilder(),
            CodeEditor(
              backgroundColor: Colors.white,
              // theme: 'gradient-dark', //black
              // theme: 'an-old-hope', //black
              theme: 'xcode', //white
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderBuilder extends StatelessWidget {
  final Color headerColor;
  final double borderRadius;
  const HeaderBuilder(
      {Key? key, this.headerColor = Colors.black, this.borderRadius = 10})
      : super(key: key);

  Widget circle(Color color, {double size = 15}) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          color: headerColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius))),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            circle(red),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: circle(orange),
            ),
            circle(green),
          ],
        ),
      ),
    );
  }
}

class CodeEditor extends StatefulWidget {
  final String language;
  final String theme;
  final Color backgroundColor;

  const CodeEditor(
      {Key? key,
      this.language = 'dart',
      this.theme = 'dark',
      this.backgroundColor = Colors.black})
      : super(key: key);
  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;
  final source = """
  class CodeEditor extends StatefulWidget {
  final String language;
  final String theme;
  final Color backgroundColor;

  const CodeEditor(
      {Key? key,
      this.language = 'dart',
      this.theme = 'dark',
      this.backgroundColor = Colors.black})
      : super(key: key);
  @override
  _CodeEditorState createState() => _CodeEditorState();
}
  """;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _codeController = CodeController(
        text: source,
        language: allLanguages[widget.language],
        patternMap: {
          r"\B#[a-zA-Z0-9]+\b": TextStyle(color: Colors.red),
          r"\B@[a-zA-Z0-9]+\b": TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.purple,
          ),
          r"\B![a-zA-Z0-9]+\b":
              TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic),
        },
        theme: themeMap[widget.theme]);
  }

  @override
  Widget build(BuildContext context) {
    return CodeField(
      controller: _codeController!,
      cursorColor: Colors.white,
      minLines: 10,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
      showLines: false,
      textStyle: TextStyle(
        fontFamily: 'SourceCode',
      ),
    );
  }
}
