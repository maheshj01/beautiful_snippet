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

class _SnippetBuilderState extends State<SnippetBuilder> {
  // late SpecsModel specs;
  Widget build(BuildContext context) {
    return Consumer<SpecsModel>(
      builder: (_, specs, child) => Container(
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
              backgroundColor: specs
                  .snippetBackgroundColor, //TODO: ADD BACKGROUND CODE COLOR
              theme: specs.codeTheme.toLowerCase(),
              language: specs.language.toLowerCase(),
              source: specs.sourceCode,
              onChange: (x) {
                specs.sourceCode = x;
              },
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
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, TextStyle> map = {};
    keywords.forEach((e) {
      map[e] = TextStyle(color: Colors.blue);
    });
    _codeController = CodeController(
        text: widget.source,
        language: allLanguages[widget.language],
        stringMap: map,
        patternMap: {
          /// Widget color
          r'[A-Z][a-z0-9]+\(.*\)': TextStyle(color: Colors.blue),

          r'^\\w*\\b(library|import|part of|part|export)\\b':
              TextStyle(color: Colors.purple),

          /// storage type annotation
          r'@[a-zA-Z]+': TextStyle(color: Colors.cyan),

          /// constants and vars
          r'(?<!\\$)\\b(true|false|null)\\b(?!\\$)': TextStyle(color: green),

          /// function name,
          r'\([a-z]+[A-Z]+\\w+\)+\(.*\)':
              TextStyle(color: Colors.greenAccent.shade700),

          r'\([A-Z]+[a-zA-Z0-9]+\\w+\)+\(.*\)': TextStyle(color: Colors.cyan),

          /// import as
          r'\\b(as|show|hide)\\b': TextStyle(color: red)

          /// Widget color
        },
        theme: themeMap[widget.theme]);
    if (!_codeController!.hasListeners) {
      _codeController!
          .addListener(() => widget.onChange!(_codeController!.text));
    }

    return CodeField(
      controller: _codeController!,
      cursorColor: Colors.blueAccent,
      minLines: 15,
      padding: EdgeInsets.symmetric(
            horizontal: padding_small,
          ) +
          EdgeInsets.only(bottom: padding_small),
      // onChange: (x) => widget.onChange!(x),
      lineNumberStyle: LineNumberStyle(margin: 25.0, width: 50),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      showLines: false,
      onTap: () {},
      textStyle: TextStyle(
        fontFamily: 'SourceCode',
      ),
    );
  }
}
