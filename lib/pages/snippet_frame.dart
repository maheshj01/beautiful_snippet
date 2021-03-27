import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:beautiful_snippet/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:beautiful_snippet/pages/snippet.dart';
import 'package:beautiful_snippet/utils/utility.dart';
import 'package:beautiful_snippet/models/specsmodel.dart';
import 'package:provider/provider.dart';

final key = GlobalKey();

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

class _SnippetFrameState extends State<SnippetFrame>
    with SingleTickerProviderStateMixin {
  _SnippetFrameState(SnippetController _snippetController) {
    _snippetController.generateImage = saveBytesAsImage;
  }

  Future<Uint8List> generateImageBytes({double ratio = 1.5}) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: ratio);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

  void saveBytesAsImage() async {
    final bytes = await generateImageBytes();
    save(bytes, "code.png");
  }

  Future<void> generateImages(
      {int fps = 20, int durationInSeconds = 10}) async {
    Future.delayed(Duration(seconds: durationInSeconds), () {
      _timer.cancel();
      print('timer cancelled');
      imageController.sink.add(imageBytesList);
    });
    int i = 0;
    _timer = Timer.periodic(Duration(milliseconds: 1000 ~/ fps), (x) async {
      final imageBytes = await generateImageBytes();
      imageBytesList.add(imageBytes);
      print(imageBytesList.length);
      streamController.sink.add(Duration(seconds: i * fps));
      i++;
    });
  }

  late AnimationController progressController;
  List<Uint8List> imageBytesList = [];
  late StreamSubscription subscription;
  final streamController = StreamController<Duration>.broadcast();
  final imageController = StreamController<List<Uint8List>>.broadcast();
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamController.close();
    imageController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final specs = Provider.of<SpecsModel>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Container(
                          height: 100,
                          width: width * 0.5,
                          alignment: Alignment.center,
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
              Container(
                  width: width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: red, shape: BoxShape.circle),
                            child: IconButton(
                              iconSize: 30,
                              onPressed: () async {
                                if (!progressController.isAnimating) {
                                  if (progressController.status ==
                                      AnimationStatus.completed) {
                                    progressController.reverse();

                                    /// TODO: PAUSE ACTIVITY HERE
                                  } else {
                                    progressController.forward();
                                    generateImages();

                                    /// TODO: PLAY ACTIVITY HERE
                                  }
                                }
                              },
                              icon: AnimatedIcon(
                                progress: progressController,
                                icon: AnimatedIcons.play_pause,
                              ),
                              color: white,
                            ),
                          ),
                          StreamBuilder<Duration>(
                              stream: streamController.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<Duration> snapshot) {
                                if (snapshot.data == null) {
                                  return Container();
                                }
                                final minutes = snapshot.data!.inMinutes;
                                final seconds = snapshot.data!.inSeconds % 60;
                                return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                        '${minutes < 10 ? '0' : ''}$minutes:$seconds',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30)));
                              })
                        ],
                      ),
                      Expanded(
                        child: StreamBuilder<List<Uint8List>>(
                            stream: imageController.stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Uint8List>> snapshot) {
                              if (snapshot.data == null) {
                                return Container();
                              }
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, x) {
                                  return Image.memory(snapshot.data![x]);
                                },
                              );
                            }),
                      )
                    ],
                  )),
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
