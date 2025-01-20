import 'package:easy_kart_app/config/app_color.dart';
import 'package:easy_kart_app/config/app_textstyle.dart';
import 'package:easy_kart_app/controller/home_controller.dart';
import 'package:easy_kart_app/view/scan/scan_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../scan/scan_page.dart';
import 'widget/button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(ApiController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/banner.png', // Add your background image to assets
          fit: BoxFit.cover,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Obx(
                  () => TextButton(
                    onPressed: apiController.isDisabled.value
                        ? null
                        : () {
                            apiController.isDisabled.value = true;

                            print('Button clicked!');
                          },
                    child: Text(
                      'Select Screen Mode For Present Phone',
                      style: AppTextStyle.selectText.copyWith(
                        color: apiController.isDisabled.value
                            ? Colors.grey
                            : AppColor.blue,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => ScanInPage());
              },
              child: ButtonWidget(
                title: "Scan In\n Or \nDriver Change",
                icon: 'assets/images/arrow_updown.svg',
                isScanOut: false,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => QRScannerScreen(
                      isScanOut: true,
                    ));
              },
              child: ButtonWidget(
                title: "Scan Out",
                icon: 'assets/images/share_scan.svg',
                isScanOut: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                'Select Round For Scanning First',
                style: AppTextStyle.selectText.copyWith(color: AppColor.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
