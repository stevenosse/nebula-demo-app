import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;

  CTextField({this.hintText, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).backgroundColor,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText2.apply(fontWeightDelta: 3, color: Colors.grey[500]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}