import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class Custom_Container extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const Custom_Container({super.key, required this.hintText, this.obscureText = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.greyShade200,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:  TextStyle(
            color: CustomColors.grey,
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
