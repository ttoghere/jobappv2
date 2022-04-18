import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  final TextEditingController fieldControl;
  final Size size;
  final String labelN;
  final bool obsecure;

  TextItem({
    required this.obsecure,
    required this.size,
    required this.labelN,
    required this.fieldControl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width - 70,
      height: 55,
      child: TextFormField(
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        controller: fieldControl,
        decoration: InputDecoration(
          labelText: labelN,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[600]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
        ),
      ),
    );
  }
}
