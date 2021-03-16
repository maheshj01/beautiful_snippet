import 'package:flutter/material.dart';
import 'package:highlight/languages/dart.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:code_text_field/code_text_field.dart';

class WindowBuilder extends StatelessWidget {
  final double borderRadius = 5;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 5,
                          color: Colors.grey,
                          offset: Offset(4, 10)),
                      BoxShadow(
                          blurRadius: 20,
                          spreadRadius: 10,
                          color: Color.fromRGBO(206, 213, 222, 0.8))
                    ],
                  ),
                  child: Column(
                    children: [
                      HeaderBuilder(
                          // headerColor: Colors.grey,
                          ),
                      CodeEditor(),
                    ],
                  ),
                ),
              )
            ],
          ),
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
            circle(Colors.red),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: circle(Colors.amberAccent),
            ),
            circle(Colors.green),
          ],
        ),
      ),
    );
  }
}

class CodeEditor extends StatefulWidget {
  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;
  final source = "void main() {\n    print(\"Hello, world!\");\n}";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _codeController = CodeController(
      text: source,
      language: dart,
      theme: monokaiSublimeTheme,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CodeField(
      controller: _codeController!,
      minLines: 10,
      lineNumberStyle: LineNumberStyle(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      showLines: false,
      textStyle: TextStyle(fontFamily: 'SourceCode', height: 1),
    );
  }
}
