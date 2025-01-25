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
            controller: apiController.scannerController,
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

                    print("Parsed Scan Data: $parsedData");
                  }
                }
              }
            },
            fit: BoxFit.cover,
          ),
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
