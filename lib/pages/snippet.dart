import 'package:beautiful_snippet/exports.dart';
import 'package:beautiful_snippet/models/specsmodel.dart';
import 'package:flutter/material.dart';
import 'package:beautiful_snippet/constants/colors.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:highlight/languages/all.dart';
import 'package:provider/provider.dart';

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
    final specs = Provider.of<SpecsModel>(context, listen: false);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: specs.hasBorder ? Border.all(color: specs.borderColor) : null,
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
          HeaderBuilder(
            headerColor: specs.snippetHeaderColor,
          ),
          CodeEditor(
            backgroundColor:
                specs.snippetBackgroundColor, //TODO: ADD BACKGROUND CODE COLOR
            theme: 'an-old-hope', //white
            source: specs.sourceCode,
            onChange: (x) {
              specs.sourceCode = x;
            },
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
              padding: const EdgeInsets.symmetric(horizontal: padding_small),
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
  final String source;
  final Function(String)? onChange;

  const CodeEditor(
      {Key? key,
      this.language = 'dart',
      this.theme = 'dark',
      required this.source,
      this.onChange,
      this.backgroundColor = Colors.black})
      : super(key: key);
  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _codeController = CodeController(
        text: widget.source,
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
      cursorColor: Colors.blueAccent,
      minLines: 10,
      padding: EdgeInsets.symmetric(
            horizontal: padding_small,
          ) +
          EdgeInsets.only(bottom: padding_small),
      onChange: (x) => widget.onChange!(x),
      lineNumberStyle: LineNumberStyle(margin: 25.0),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      showLines: false,
      textStyle: TextStyle(
        fontFamily: 'SourceCode',
      ),
    );
  }
}
