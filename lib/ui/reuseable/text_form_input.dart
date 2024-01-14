import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class TextFormInput extends StatefulWidget {
  final TextEditingController controller;
  TextInputType? keyboardType = TextInputType.text;
  String? label = "";
  final Function(dynamic)? onChange;
  final String? Function(String?)? validator;
  String? note = "";
  TextFormInput(
      {Key? key,
      required this.controller,
      this.onChange,
      this.label = "",
      this.note = "",
      this.validator,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  _TextFormInputState createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          style: TextStyle(color: CHARCOAL),
          validator: widget.validator,
          onChanged: (textValue) {},
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: widget.label,
              labelStyle: TextStyle(color: BLACK_GREY)),
        ),
        if (widget.note != null && widget.note != "") ...[
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.note ?? "", style: GlobalStyle.authNotes),
              ],
            ),
          ),
        ]
      ],
    );
  }
}
