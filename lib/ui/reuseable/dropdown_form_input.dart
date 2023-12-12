import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';

class DropdownItem {
  final String name;
  final String value;

  DropdownItem(this.name, this.value);
}

class CustomDropdown extends StatefulWidget {
  final List<DropdownItem> items;
  final String selectedValue;
  final Function(String?)? onChanged;
  final String label;
  final IconData icon;
  final double width;

  CustomDropdown({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.label,
    required this.icon,
    this.width = 300, 
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              widget.label,
              style: TextStyle(color: CHARCOAL),
            ),
        Row(
          
          children: [
            SizedBox(width: 6),
            
            Icon(widget.icon),
            // Text(
            //   widget.label,
            //   style: TextStyle(color: CHARCOAL),
            // ),
            Container(
              width: widget.width, // Utilisez la largeur fournie
              child: DropdownButton<String>(
                value: widget.selectedValue,
                onChanged: widget.onChanged,
                items: widget.items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item.value,
                    child: Text(item.name),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
