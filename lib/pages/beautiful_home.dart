import 'package:flutter/material.dart';
import 'package:beautiful_snippet/exports.dart';
import 'package:beautiful_snippet/pages/snippet_frame.dart';
import 'package:beautiful_snippet/models/specsmodel.dart';
import 'package:provider/provider.dart';

class BeautifulHome extends StatefulWidget {
  @override
  _BeautifulHomeState createState() => _BeautifulHomeState();
}

class _BeautifulHomeState extends State<BeautifulHome> {
  SnippetController snippetController = SnippetController();

  Widget logoBuilder() {
    return Padding(
      padding: const EdgeInsets.only(top: padding_large),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Beautiful',
              style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: font_h2,
                  height: -1)),
          Text('Snippet',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                  fontSize: font_h6)),
        ],
      ),
    );
  }

  late SpecsModel specs;
  @override
  Widget build(BuildContext context) {
    specs = Provider.of<SpecsModel>(context, listen: false);
    return Scaffold(
      backgroundColor: specs.backgroundColor,
      appBar: AppBar(
        title: logoBuilder(),
        backgroundColor:
            black, // specs.backgroundColor == white ? black : white,
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.download_rounded,
                color: specs.backgroundColor,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                snippetController.generateImage();
              }),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SnippetFrame(
        controller: snippetController,
      ),
    );
  }
}
