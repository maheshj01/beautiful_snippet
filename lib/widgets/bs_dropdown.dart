import 'package:flutter/material.dart';

class BsDropdownMenu extends StatefulWidget {
  final String? selected;
  final List<String> items;
  final Function(String) onSelected;
  final String? hintText;
  final String? label;
  const BsDropdownMenu(
      {Key? key,
      required this.selected,
      required this.items,
      required this.onSelected,
      this.hintText,
      this.label})
      : super(key: key);
  @override
  _BsDropdownMenuState createState() => _BsDropdownMenuState();
}

class _BsDropdownMenuState extends State<BsDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(widget.hintText ?? 'Select'),
              value: widget.selected,
              isDense: true,
              onChanged: (newValue) => widget.onSelected(newValue!),
              items: widget.items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
