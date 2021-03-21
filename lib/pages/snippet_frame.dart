import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_template/pages/snippet.dart';
import 'package:flutter_template/utils/utility.dart';

class SnippetController {
  late void Function() generateImage;
}

/// Widget to take the screenshot of
class SnippetFrame extends StatefulWidget {
  final SnippetController controller;

  const SnippetFrame({Key? key, required this.controller}) : super(key: key);
  @override
  _SnippetFrameState createState() => _SnippetFrameState(controller);
}

class _SnippetFrameState extends State<SnippetFrame> {
  _SnippetFrameState(SnippetController _snippetController) {
    _snippetController.generateImage = generateImageBytes;
  }

  void generateImageBytes({double ratio = 1.5}) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: ratio);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    save(pngBytes, "code.png");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Center(
                    child: SingleChildScrollView(
                        child: RepaintBoundary(
                  key: key,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: width * 0.6,
                            color: Colors.blueAccent,
                            padding: EdgeInsets.all(50),
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: width * 0.3,
                                    maxWidth: width * 0.6),
                                child: SnippetBuilder())),
                      ]),
                ))),
              ),
              Container(width: width * 0.25, child: SideBar()),
            ],
          ),
        ),
      ],
    );
  }
}

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Column(
        children: [Text('Some Text')],
      ),
    );
  }
}
