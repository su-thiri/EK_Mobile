import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/app_color.dart';
import '../../../config/app_textstyle.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool isScanOut;
  const ButtonWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.isScanOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.symmetric(vertical: 35),
      width: 286,
      decoration: BoxDecoration(
          color: AppColor.buttonColor, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Row(
          children: [
            Container(
              height: 45,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isScanOut ? AppColor.scanOutColor : Colors.white,
                borderRadius:
                    isScanOut ? BorderRadius.circular(15) : BorderRadius.zero,
              ),
              child: SvgPicture.asset(
                icon,
                color: isScanOut ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              maxLines: 3,
              style: AppTextStyle.buttonText.copyWith(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
