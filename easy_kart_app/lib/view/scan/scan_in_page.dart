import 'package:easy_kart_app/config/app_color.dart';
import 'package:easy_kart_app/view/scan/scanin_qr_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../util/dialog.dart';
import '../home/home_page.dart';
import 'widget/scan_button_widget.dart';

class ScanInPage extends StatelessWidget {
  const ScanInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiController apiController = Get.put(ApiController());
    return WillPopScope(
      onWillPop: () {
        Get.offAll(() => const HomePage());
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offAll(() => const HomePage());
            },
          ),
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
                Get.to(() => ScanInQRScannerScreen(
                      isScanOut: false,
                    ));
                // scanDialog(
                //     true, context, 'Are you sure, you want to scan DRIVER-1 ?',
                //     () {
                //   Get.back();
                //   Get.to(() => ScanInQRScannerScreen(
                //         isScanOut: false,
                //       ));
                // });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: apiController.qrController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      if (value.isEmpty || int.tryParse(value) == null) {
                        apiController.isInputValid.value = false;
                      } else {
                        apiController.isInputValid.value = true;
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.lightGreyColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Obx(() => apiController.isInputValid.value
                      ? const SizedBox()
                      : const Text(
                          'Please enter a valid number',
                          style: TextStyle(color: Colors.red),
                        )),
                ],
              ),
            ),
            ScanButtonWidget(
              title: 'Send',
              onClicked: () {
                apiController.qrController.text.isEmpty
                    ? null
                    : apiController
                        .sendData({"qr_code": apiController.qrController.text});
              },
            )
          ],
        ),
      ),
    );
  }
}
