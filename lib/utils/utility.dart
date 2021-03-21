/**
 * 
 * A utility class containing all the helper functions
 * to keep your code clean and readable and helping to maintain
 * the Single responsibility princple
 */

import 'dart:html' as html;
import 'dart:js' as js;

void save(List<int> bytes, String fileName) {
  js.context.callMethod("saveAs", <Object>[
    html.Blob(<List<int>>[bytes]),
    fileName
  ]);
}
