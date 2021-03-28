import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:beautiful_snippet/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:beautiful_snippet/pages/snippet.dart';
import 'package:beautiful_snippet/utils/utility.dart';
import 'package:beautiful_snippet/models/specsmodel.dart';
import 'package:provider/provider.dart';

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

  final key = GlobalKey();

  Widget build(BuildContext context) {
    final specs = Provider.of<SpecsModel>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 100,
                              width: width * 0.5,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: ColorPicker()),
                        ],
                      ),
                      RepaintBoundary(
                        key: key,
                        child: Container(
                            width: width * 0.6,
                            color: specs.backgroundColor,
                            padding: EdgeInsets.all(50),
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: width * 0.3,
                                    maxWidth: width * 0.6),
                                child: SnippetBuilder())),
                      ),
                    ])),
              ),
              Container(width: width * 0.3, child: SideBar()),
            ],
          ),
        ),
      ],
    );
  }
}

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  double itemWidth = 80.0;
  int itemCount = backgroundColors.length;
  late FixedExtentScrollController _scrollController;
  late int selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = itemCount ~/ 2;
    _scrollController =
        FixedExtentScrollController(initialItem: itemCount ~/ 2);
  }

  @override
  Widget build(BuildContext context) {
    final specs = Provider.of<SpecsModel>(context, listen: false);
    return Center(
        child: RotatedBox(
            quarterTurns: -1,
            child: ListWheelScrollView(
              onSelectedItemChanged: (x) {
                specs.backgroundColor = backgroundColors[x];
                setState(() {
                  selectedIndex = x;
                });
              },
              diameterRatio: 1.5,
              controller: _scrollController,
              children: List.generate(
                  itemCount,
                  (x) => Container(
                      alignment: Alignment.center,
                      child: CircularColor(
                        color: backgroundColors[x],
                        selectedColor: backgroundColors[selectedIndex],
                        borderRadius: x == selectedIndex ? 60 : 45,
                      ))),
              itemExtent: itemWidth,
            )));
  }
}

class CircularColor extends StatelessWidget {
  final Color color;
  final Color selectedColor;
  final double borderRadius;

  const CircularColor(
      {Key? key,
      required this.color,
      required this.selectedColor,
      this.borderRadius = 50.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    if (selectedColor != null) {
      isSelected = (color == selectedColor);
    }
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: borderRadius,
      height: borderRadius,
      decoration: BoxDecoration(
          border: isSelected ? Border.all(color: Colors.red, width: 4.0) : null,
          shape: BoxShape.circle,
          color: color),
    );
  }
}

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Widget _headerBuilder(String title, {Widget? child}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        child ?? Container()
      ],
    );
  }

  Widget _borderColorsBuilder(Color selectedColor, Function(Color) onChange) {
    return Consumer<SpecsModel>(
        builder: (BuildContext _, SpecsModel model, Widget? child) {
      return Wrap(
        spacing: 10,
        runSpacing: 5,
        children: List.generate(
            borderColors.length,
            (x) => GestureDetector(
                  onTap: () {
                    specs.borderColor = borderColors[x];
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: borderColors[x],
                        border: model.borderColor == borderColors[x]
                            ? Border.all(color: Colors.deepPurple, width: 2)
                            : null),
                    height: 50,
                    width: 50,
                  ),
                )),
      );
    });
  }

  late SpecsModel specs;

  @override
  void initState() {
    // TODO: implement initState
    specs = Provider.of<SpecsModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(padding_medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerBuilder('Border',
                child: CupertinoSwitch(
                  value: specs.hasBorder,
                  onChanged: (x) {
                    specs.hasBorder = x;
                  },
                )),
            specs.hasBorder
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: padding_medium),
                    child: _borderColorsBuilder(specs.backgroundColor, (x) {
                      specs.borderColor = x;
                    }))
                : Container(),
            // _headerBuilder('Editor',
            //     child: CupertinoSwitch(
            //       value: specs.hasBorder,
            //       onChanged: (x) {
            //         specs.hasBorder = x;
            //       },
            //     )),
          ],
        ),
      ),
    );
  }
}
