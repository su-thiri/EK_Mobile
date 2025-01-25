import 'package:easy_kart_app/config/app_color.dart';
import 'package:easy_kart_app/config/app_textstyle.dart';
import 'package:easy_kart_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanInQRScannerScreen extends StatelessWidget {
  final bool isScanOut;
  const ScanInQRScannerScreen({super.key, required this.isScanOut});

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

                    Map<String, dynamic> parseScanData(String data) {
                      List<String> fields =
                          data.split('|').map((field) => field.trim()).toList();

                      return {
                        'driver_name': fields[0],
                        'qr_code': fields[1],
                        'role_in_team': fields[2],
                        'round_name': fields[3],
                        'team_name': fields[4],
                        'team_number': fields[5],
                        'championship_name': fields[6],
                        'country_flag': fields[7],
                        'nationality': fields[8],
                        'driver_weight': double.parse(fields[9]),
                        'team_logo': fields[10],
                        'driver_id': fields[11],
                      };
                    }

                    Map<String, dynamic> parseDuplicateScanData(String data) {
                      List<String> fields =
                          data.split('|').map((field) => field.trim()).toList();

                      return {
                        'driver_name': fields[0],
                        'qr_code': fields[1],
                        'role_in_team': fields[2],
                        'round_name': fields[3],
                        'team_name': fields[4],
                        'team_number': fields[5],
                        'championship_name': fields[6],
                        'country_flag': fields[7],
                        'nationality': fields[8],
                        'driver_weight': double.parse(fields[9]),
                        'team_logo': fields[10],
                        'driver_id': fields[11],
                        "duplicate": true
                      };
                    }

                    Map<String, dynamic> parsedData = parseScanData(code);
                    Map<String, dynamic> parsedDuplicateData =
                        parseDuplicateScanData(code);
                    String driverId = parsedData['driver_id'];
                    String qrCode = parsedData['qr_code'];
                    apiController.processQrCode(parsedData, parsedDuplicateData,
                        qrCode, context, driverId);
                    //  bool isDuplicate = await  DataStorage.isDuplicateQRCode(scannedData);
                    // if (isDuplicate) {
                    //   String driverId = parsedDuplicateData['driver_id'];
                    //   // await apiController
                    //   //     .sendDuplicateQRData(parsedDuplicateData, driverId)
                    //   //     .then((value) async {
                    //   await scanDialog(context, 'Duplicate QR Scan detected!',
                    //       () async {
                    //     await apiController.sendDuplicateQRData(
                    //         parsedDuplicateData, driverId);
                    //     // Get.to(() => ScanInPage());
                    //   }, () async {
                    //     await apiController.deleteData(driverId);
                    //     await DataStorage.clearAllQRCodes();
                    //   });
                    //   // });
                    // } else {
                    print("Parsed Scan Data: $parsedData");

                    // await apiController.sendQRData(parsedData);

                    // }
                    // bool isDuplicate = await DataStorage.isDuplicateQRCode(
                    //     parsedData['qr_code']);
                    // if (!isDuplicate) {
                    //   // await apiController.sendQRData(parsedData);
                    //   //  await apiController.sendQRData(parsedData['qr_code']);

                    //   await DataStorage.saveQRCode(parsedData['qr_code']);
                    //   Get.snackbar('Success', 'QR Code sent successfully');
                    // } else {
                    //   // await apiController.sendDuplicateQR(scannedData);
                    //   Get.snackbar('Duplicate', 'Duplicate QR Code data sent');
                    // }
                  }
                }
              }
            },
            fit: BoxFit.cover,
          ),

          // scanDialog(
          //   true,
          //   context,
          //   'Duplicate QR Scan detected!',
          //   () async {
          //     String driverId = parsedDuplicateData['driver_id'];

          //     Get.back();
          //     await apiController.sendDuplicateQRData(
          //         parsedDuplicateData, driverId);
          //   },
          // );
          // MobileScanner(
          //   onDetect: (barcodeCapture) async {
          //     if (code == "") {
          //       if (barcodeCapture.barcodes.isNotEmpty) {
          //         final barcode = barcodeCapture.barcodes.first;
          //         if (barcode.rawValue != null) {
          //           code = barcode.rawValue!;

          //           Map<String, dynamic> parseScanData(String data) {
          //             List<String> fields =
          //                 data.split('|').map((field) => field.trim()).toList();

          //             return {
          //               'driver_name': fields[0],
          //               'qr_code': fields[1],
          //               'role_in_team': fields[2],
          //               'round_name': fields[3],
          //               'team_name': fields[4],
          //               'team_number': fields[5],
          //               'championship_name': fields[6],
          //               'country_flag': fields[7],
          //               'nationality': fields[8],
          //               'driver_weight': double.parse(fields[9]),
          //               'team_logo': fields[10],
          //               'driver_id': fields[11],
          //             };
          //           }

          //           Map<String, dynamic> parsedData = parseScanData(code);

          //           print("Parsed Scan Data: $parsedData");
          //           scanDialog(true, context,
          //               'Are you sure, you want to scan DRIVER-1 ?', () async {
          //             Get.back();
          //             await apiController.sendQRData(parsedData);
          //           });
          //         }
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
