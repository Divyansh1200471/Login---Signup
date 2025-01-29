import 'package:flutter/material.dart';

import '../../utils/colors.dart';








class Line_Or_Widget extends StatelessWidget {
  const Line_Or_Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 50,
            child: Divider(
              color: CustomColors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'or',
            style: TextStyle(
              color: CustomColors.grey,
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 50,
            child: Divider(
              color: CustomColors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
