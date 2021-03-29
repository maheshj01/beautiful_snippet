import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:beautiful_snippet/exports.dart';
import 'package:beautiful_snippet/pages/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
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
                        Container(
                            height: 100,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.circular(padding_small)),
                            child: ColorPicker()),
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
      ),
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
    _scrollController =
        FixedExtentScrollController(initialItem: itemCount ~/ 2);
    specs = Provider.of<SpecsModel>(context, listen: false);
    selectedIndex = backgroundColors.indexOf(specs.backgroundColor);
    SchedulerBinding.instance!.addPostFrameCallback((x) {
      _scrollController.animateToItem(selectedIndex,
          duration: Duration(milliseconds: 400), curve: Curves.bounceIn);
    });
  }

  late SpecsModel specs;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: -1,
        child: ListWheelScrollView(
          physics: BouncingScrollPhysics(),
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
                    borderRadius: x == selectedIndex ? 70 : 45,
                  ))),
          itemExtent: itemWidth,
        ));
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
          border: isSelected
              ? Border.all(color: Colors.deepPurple, width: 4.0)
              : null,
          shape: BoxShape.circle,
          color: color),
    );
  }
}
