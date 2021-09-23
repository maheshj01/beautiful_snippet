import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BeautifulAlert extends StatelessWidget {
  final String title;
  final Function()? onConfirm;
  final Function()? onCancel;

  const BeautifulAlert(
      {Key? key, required this.title, this.onConfirm, this.onCancel})
      : super(key: key);

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 0.5,
      child: Container(
        width: 350,
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
                'Beautiful Snippet is a open-sourced code snippet generation tool built with flutter 💙, to build beautiful code snippets. This tool is still in development. If you see any bugs or have feature requests, please consider filing a bug by using the report button.'),
            FutureBuilder<String>(
                future: getVersion(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  String version = '';
                  if (snapshot != null && snapshot.data != null) {
                    version = snapshot.data!;
                  }
                  return Text('version: ${version}');
                })
          ],
        ),
      ),
    );
  }
}
