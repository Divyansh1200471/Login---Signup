
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class GoogleBtn extends StatelessWidget {
  final VoidCallback? ontap;
  final String text;
  const GoogleBtn({
    super.key, this.ontap, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: CustomColors.whiteShade60,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/google_icon.png'),
            ),
            const  SizedBox(
              width: 10,
            ),
            Text(text,style:  TextStyle(
              color: CustomColors.blackShade38,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
          ],
        ),

      ),
    );
  }
}

