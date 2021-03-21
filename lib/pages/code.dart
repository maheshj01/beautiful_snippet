import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_template/pages/window.dart';
import 'package:flutter_template/utils/utility.dart';

class BackgroundBuilder extends StatefulWidget {
  @override
  _BackgroundBuilderState createState() => _BackgroundBuilderState();
}

class _BackgroundBuilderState extends State<BackgroundBuilder> {
  final key = GlobalKey();

  void generateImageBytes(double ratio) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: ratio);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    save(pngBytes, "code.png");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        appBar: AppBar(
          title: Text('Beautiful Snippet'),
          actions: [
            IconButton(
                icon: Icon(Icons.download_rounded),
                onPressed: () => generateImageBytes(1.5))
          ],
        ),
        body: Column(
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
                                padding: EdgeInsets.all(50),
                                color: Colors.white,
                                child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    child: WindowBuilder())),
                          ]),
                    ))),
                  ),
                  Container(width: width * 0.25, child: SideBar()),
                ],
              ),
            ),
          ],
        ));
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
