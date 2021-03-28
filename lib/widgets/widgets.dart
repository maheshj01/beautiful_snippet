import 'package:beautiful_snippet/constants/colors.dart';
import 'package:flutter/material.dart';

/** 
 * Small helper widgets go here in this page
 * for custom large widgets consider creating 
 * a separate file under lib/widgets
 */

Widget hMargin({Color? color}) {
  return Container(height: 1, color: color ?? grey.withOpacity(0.5));
}
