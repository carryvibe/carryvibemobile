import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomDropdown extends StatelessWidget {
  String dropdown;
  Function(String?) onChanged;
  List<String> items;
  CustomDropdown(
      {required this.dropdown, required this.onChanged, required this.items});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: DropdownButtonHideUnderline(
        child: GFDropdown(
          borderRadius: BorderRadius.circular(8),
          border: const BorderSide(color: Colors.black12, width: 1),
          value: dropdown,
          onChanged: (newValue) {
            onChanged(newValue);
          },
          items: items.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
              alignment: AlignmentDirectional.bottomCenter,
            );
          }).toList(),
        ),
      ),
    );
  }
}
