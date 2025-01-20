import 'package:easy_kart_app/config/app_color.dart';
import 'package:easy_kart_app/config/app_textstyle.dart';
import 'package:easy_kart_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  final bool isScanOut;
  const QRScannerScreen({super.key, required this.isScanOut});

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(ApiController());
    String code = '';
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (barcodeCapture) async {
              if (code == "") {
                if (barcodeCapture.barcodes.isNotEmpty) {
                  final barcode = barcodeCapture.barcodes.first;
                  if (barcode.rawValue != null) {
                    code = barcode.rawValue!;
                    await apiController.sendQRData(code);
                  }
                }
              }
              // if (barcodeCapture.barcodes.isNotEmpty) {
              //   final barcode = barcodeCapture.barcodes.first;
              //   if (barcode.rawValue != null) {
              //     final String code = barcode.rawValue!;
              //     print('QR Code Found: $code');
              //     // await apiController.sendQRData(code);
              //   }
              // }
            },
            fit: BoxFit.cover,
          ),
          // MobileScanner(
          //   onDetect: (barcodeCapture) {
          //     final List<Barcode> barcodes = barcodeCapture.barcodes;
          //     for (final barcode in barcodes) {
          //       if (barcode.rawValue != null) {
          //         final String code = barcode.rawValue!;
          //         print('QR Code Found: $code');
          //         // Handle the scanned QR code here
          //       }
          //     }
          //   },
          //   fit: BoxFit.cover,
          // ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    isScanOut
                        ? 'SCAN DRIVER OUT'
                        : 'SCAN FIRST QR\n OR\nDRIVER CHANGES!',
                    textAlign: TextAlign.center,
                    style:
                        AppTextStyle.selectText.copyWith(color: AppColor.blue),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              child: Center(
                child: IconButton(
                  icon:
                      Icon(Icons.close_outlined, color: Colors.white, size: 18),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
