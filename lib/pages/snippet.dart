import 'package:flutter/material.dart';
import 'package:flutter_template/constants/colors.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:highlight/languages/all.dart';

class SnippetBuilder extends StatefulWidget {
  final double borderRadius;

  const SnippetBuilder({Key? key, this.borderRadius = 10}) : super(key: key);

  @override
  _SnippetBuilderState createState() => _SnippetBuilderState();
}

// TODO: Themes and Color Schemes supported
/// theme: 'gradient-dark', //black
/// theme: 'an-old-hope', //black
/// theme: 'xcode', //white
//

class _SnippetBuilderState extends State<SnippetBuilder> {
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: white, //TODO: ADD BACKGROUND CODE COLOR
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: red),
        boxShadow: [
          BoxShadow(
              blurRadius: 15,
              spreadRadius: 8,
              color: Colors.black.withOpacity(0.3),
              offset: Offset(3, 4)),
        ],
      ),
      child: Column(
        children: [
          HeaderBuilder(),
          CodeEditor(
            backgroundColor: white, //TODO: ADD BACKGROUND CODE COLOR
            theme: 'xcode', //white
          ),
        ],
      ),
    );
  }
}

class HeaderBuilder extends StatelessWidget {
  final Color headerColor;
  final double borderRadius;
  const HeaderBuilder(
      {Key? key, this.headerColor = black, this.borderRadius = 10})
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
      decoration: BoxDecoration(
          color: headerColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius))),
      child: Padding(
        padding: const EdgeInsets.all(12),
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
      this.language = 'Dart',
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
      cursorColor: white,
      minLines: 10,
      padding: EdgeInsets.symmetric(
            horizontal: 8,
          ) +
          EdgeInsets.only(bottom: 8),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
      showLines: false,
      textStyle: TextStyle(
        fontFamily: 'SourceCode',
      ),
    );
  }
}
