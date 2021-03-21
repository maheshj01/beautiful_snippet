import 'package:flutter/material.dart';
import 'package:flutter_template/exports.dart';
import 'package:flutter_template/pages/snippet_frame.dart';

class BeautifulHome extends StatefulWidget {
  @override
  _BeautifulHomeState createState() => _BeautifulHomeState();
}

class _BeautifulHomeState extends State<BeautifulHome> {
  SnippetController snippetController = SnippetController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text('$APP_TITLE', style: TextStyle(color: black, fontSize: 18)),
        backgroundColor: white,
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.download_rounded,
                color: Colors.blueAccent,
              ),
              onPressed: () => snippetController.generateImage()),
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
