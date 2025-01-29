
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class Custom_Btn_Login_signUp extends StatelessWidget {
  final String text;
  final VoidCallback? ontap;

  const Custom_Btn_Login_signUp({
    super.key,
    required this.text,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: const Color(0xffCCD3CA),
          borderRadius: BorderRadius.circular(10),
          color: CustomColors.greyShade200,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: CustomColors.blackShade38,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
