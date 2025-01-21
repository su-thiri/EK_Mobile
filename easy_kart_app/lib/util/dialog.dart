import 'package:easy_kart_app/config/app_textstyle.dart';
import 'package:easy_kart_app/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_color.dart';

Future<dynamic> scanDialog(
    bool isScanIn, BuildContext context, String title, Function onClicked) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.lightGreyColor,
        content: Text(
          title,
          style: AppTextStyle.dialogText,
        ),
        actions: [
          MaterialButton(
              elevation: 0.2,
              minWidth: 80,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              onPressed: () {
                isScanIn ? Get.offAll(HomePage()) : Get.back();
              },
              child: Text(
                'No',
                style: AppTextStyle.buttonText
                    .copyWith(color: Colors.black, fontSize: 18),
              )),
          SizedBox(width: 3),
          MaterialButton(
              elevation: 0.2,
              minWidth: 80,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              onPressed: () {
                onClicked();
              },
              child: Text(
                'Yes',
                style: AppTextStyle.buttonText
                    .copyWith(color: Colors.black, fontSize: 18),
              )),
        ],
      );
    },
  );
}
