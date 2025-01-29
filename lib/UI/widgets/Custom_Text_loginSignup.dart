
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class Custom_Text_loginSignup extends StatelessWidget {
  final String details;
  final String text;
  final VoidCallback? ontap;
  const Custom_Text_loginSignup({
    super.key, required this.details, required this.text, this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          details,
          style:  TextStyle(
            color: CustomColors.blackShade26,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: ontap,
          child: Text(
            text,
            style:  TextStyle(
              color: CustomColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
