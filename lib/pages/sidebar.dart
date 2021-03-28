import 'package:beautiful_snippet/exports.dart';
import 'package:beautiful_snippet/models/specsmodel.dart';
import 'package:beautiful_snippet/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Widget subTitle(String subtitle) {
    return Text(
      '$subtitle',
      style: TextStyle(
          color: black.withOpacity(0.6),
          fontWeight: FontWeight.w600,
          fontSize: font_h4),
    );
  }

  Widget _colorsSelector(Color selectedColor, Function(Color) onChange,
      {List<Color>? colors}) {
    if (colors == null || colors.isEmpty) {
      colors = borderColors;
    }
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: List.generate(
          colors.length,
          (x) => GestureDetector(
                onTap: () => onChange(colors![x]),
                child: Container(
                  decoration: BoxDecoration(
                      color: colors![x],
                      border: selectedColor == colors[x]
                          ? Border.all(color: Colors.deepPurple, width: 2)
                          : null),
                  height: 50,
                  width: 50,
                ),
              )),
    );
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
                    child: _colorsSelector(specs.borderColor, (x) {
                      specs.borderColor = x;
                    }, colors: borderColors))
                : Container(),
            hMargin(),
            Padding(
              padding: const EdgeInsets.only(top: padding_small),
              child: _headerBuilder(
                'Snippet Editor',
              ),
            ),
            subTitle('Header'),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: padding_small),
                child: _colorsSelector(specs.snippetHeaderColor, (x) {
                  specs.snippetHeaderColor = x;
                }, colors: snippetHeaderColors)),
            subTitle('background'),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: padding_small),
                child: _colorsSelector(specs.snippetBackgroundColor, (x) {
                  specs.snippetBackgroundColor = x;
                }, colors: snippetBackgroundColors)),
          ],
        ),
      ),
    );
  }
}
