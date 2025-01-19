import 'package:easy_kart_app/config/app_color.dart';
import 'package:easy_kart_app/config/app_textstyle.dart';
import 'package:easy_kart_app/view/scan/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../../util/dialog.dart';
import 'widget/scan_button_widget.dart';

class ScanInPage extends StatelessWidget {
  const ScanInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/banner.png',
          fit: BoxFit.cover,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          ScanButtonWidget(
            title: 'Scan Now !',
            onClicked: () {
              scanDialog(context, 'Are you sure, you want to scan DRIVER-1 ?',
                  () {
                Get.back();
                Get.to(() => QRScannerScreen(
                      isScanOut: false,
                    ));
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: TextField(
                decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.lightGreyColor,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
            )),
          ),
          ScanButtonWidget(
            title: 'Send',
            onClicked: () {},
          ),
        ],
      ),
    );
  }
}
