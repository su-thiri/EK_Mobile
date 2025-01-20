import 'package:flutter/material.dart';

import '../../../config/app_color.dart';
import '../../../config/app_textstyle.dart';

class ScanButtonWidget extends StatelessWidget {
  final String title;
  final Function onClicked;
  const ScanButtonWidget({
    super.key,
    required this.title,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: 200,
        elevation: 0.3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: AppColor.buttonColor,
        onPressed: () {
          onClicked();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Text(
            title,
            style: AppTextStyle.buttonText.copyWith(color: Colors.black),
          ),
        ));
  }
}
