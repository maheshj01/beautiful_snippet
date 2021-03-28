import 'package:beautiful_snippet/constants/colors.dart';
import 'package:flutter/material.dart';

class BSDropdownMenu extends StatefulWidget {
  final String selected;
  final List<String> items;
  final Function onSelected;
  final String? hintText;
  final String? label;

  const BSDropdownMenu(this.selected, this.items, this.onSelected,
      {this.hintText, this.label});

  @override
  BSDropdownMenuState createState() => BSDropdownMenuState();
}

class BSDropdownMenuState extends State<BSDropdownMenu> {
  dynamic selectedItem;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    selectedItem = widget.selected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label == null)
          const SizedBox.shrink()
        else
          Text(widget.label!,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: black)),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              hint: widget.hintText == null ? null : Text(widget.hintText!),
              isExpanded: true,
              style: TextStyle(
                  color: black, fontSize: 12, fontWeight: FontWeight.w600),
              value: selectedItem,
              icon: RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: black,
                  size: 16,
                ),
              ),
              items: widget.items == null
                  ? []
                  : widget.items.map((item) {
                      return DropdownMenuItem(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(item,
                                style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                )),
                          ));
                    }).toList(),
              onChanged: (item) {
                widget.onSelected(item);
                setState(() {
                  selectedItem = item;
                  selectedIndex = widget.items.indexOf(item!);
                });
              }),
        ),
      ],
    );
  }
}
