/**
 * 
 * A utility class containing all the helper functions
 * to keep your code clean and readable and helping to maintain
 * the Single responsibility princple
 */

import 'dart:html' as html;
import 'dart:js' as js;

import 'package:url_launcher/url_launcher.dart';

void save(List<int> bytes, String fileName) {
  js.context.callMethod("saveAs", <Object>[
    html.Blob(<List<int>>[bytes]),
    fileName
  ]);
}

/// TODO: Add canLaunch condition back when this issue is fixed https://github.com/flutter/flutter/issues/74557
Future<void> launchUrl(String url, {bool isNewTab = true}) async {
  // await canLaunch(url)
  // ?
  await launch(
    url,
    webOnlyWindowName: isNewTab ? '_blank' : '_self',
  );
  // : throw 'Could not launch $url';
}
