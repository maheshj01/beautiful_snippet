import 'package:beautiful_snippet/utils/utility.dart';
import 'package:beautiful_snippet/widgets/alert.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
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

  void _openCustomDialog(BuildContext context) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              // offset: Offset(0, 100 * a1.value),
              scale: a1.value,
              child: BeautifulAlert(
                title: 'About',
              ));
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  late SpecsModel specs;
  @override
  Widget build(BuildContext context) {
    specs = Provider.of<SpecsModel>(context, listen: false);
    return Scaffold(
      backgroundColor: specs.backgroundColor,
      appBar: AppBar(
        title: logoBuilder(),
        toolbarHeight: 70,
        backgroundColor: black,
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
          ),
          IconButton(
              icon: Image.asset(GITHUB_ASSET_PATH),
              onPressed: () {
                launchUrl(REPO_URL);
              }),
          SizedBox(
            width: 10,
          ),
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                _openCustomDialog(context);
              }),
        ],
      ),
      body: SnippetFrame(
        controller: snippetController,
      ),
    );
  }
}
