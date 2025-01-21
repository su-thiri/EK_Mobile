import 'dart:async';
import 'dart:io';

import 'package:easy_kart_app/config/app_textstyle.dart';
import 'package:easy_kart_app/view/home/home_page.dart';
import 'package:easy_kart_app/view/scan/scan_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/api_constant.dart';
import '../config/app_color.dart';
import '../network/api_repository.dart';
import '../network/api_repository_impl.dart';

class ApiController extends GetxController {
  final TextEditingController qrController = TextEditingController();

  final ApiRepository _apiRepository = ApiRepositoryImpl();
  var isInputValid = true.obs;
  var isProcessing = false.obs;
  var isDisabled = false.obs;

  Future<void> fetchData() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final data = await _apiRepository
          .getMobileData(mobileDataUrl); // Replace with your endpoint
      Get.back();
      Get.defaultDialog(
        title: "Success",
        content: Text("Data fetched: ${data.toString()}"),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text("OK"),
        ),
      );
    } catch (e) {
      Get.back(); // Close the dialog
      Get.defaultDialog(
        title: "Error",
        content: Text("Failed to fetch data: $e"),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text("OK"),
        ),
      );
    }
  }

  Future<void> sendScanOutQRData(Map<String, dynamic> requestBody) async {
    if (isProcessing.value) return; // Prevent multiple API calls

    isProcessing.value = true; // Set processing flag to true
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final response = await _apiRepository.postMobileData(
        mobileDataUrl, requestBody,
        // {"time": time, "date": date},
      );
      if (response.isNotEmpty) {
        isProcessing.value = false;

        await Get.defaultDialog(
          backgroundColor: AppColor.buttonColor,
          title: "Driver Successfully Scanned Out.",
          titleStyle: AppTextStyle.dialogText.copyWith(fontSize: 20),
          content: Text(
            "Driver End Driving Time is Saved Successfully.",
            // "${response['message']}",
            style: AppTextStyle.dialogText,
          ),
          confirm: ElevatedButton(
            onPressed: () => Get.offAll(HomePage()),
            child: Text(
              "OK",
              style: AppTextStyle.buttonText
                  .copyWith(color: Colors.black, fontSize: 15),
            ),
          ),
        );
      } else {}
    } catch (e) {
      Get.back();

      String errorMessage;
      if (e is HttpException) {
        errorMessage = e.message;
      } else if (e is SocketException) {
        errorMessage = "No internet connection. Please try again.";
      } else if (e is TimeoutException) {
        errorMessage = "Request timed out. Please try again.";
      } else {
        errorMessage = e.toString(); // Fallback for other exception types
      }

      Get.defaultDialog(
        title: "Error",
        content: Text("Failed to send data: $errorMessage"),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text("OK"),
        ),
      );
    } finally {
      isProcessing.value = false; // Reset the flag after the process
    }
  }

  Future<void> sendQRData(Map<String, dynamic> requestBody) async {
    if (isProcessing.value) return; // Prevent multiple API calls

    isProcessing.value = true; // Set processing flag to true
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final response = await _apiRepository.postMobileData(
        mobileDataUrl,
        requestBody,
      );
      if (response.isNotEmpty) {
        isProcessing.value = false;

        await Get.defaultDialog(
          barrierDismissible: false,
          backgroundColor: AppColor.buttonColor,
          title: "Success",
          titleStyle: AppTextStyle.dialogText.copyWith(fontSize: 20),
          content: Text(
            "${response['message']}",
            style: AppTextStyle.dialogText,
          ),
          confirm: ElevatedButton(
            onPressed: () {
              Get.back();

              Get.to(ScanInPage());
            },
            child: Text(
              "OK",
              style: AppTextStyle.buttonText
                  .copyWith(color: Colors.black, fontSize: 15),
            ),
          ),
        );
      } else {}
    } catch (e) {
      Get.back();

      String errorMessage;
      if (e is HttpException) {
        errorMessage = e.message;
      } else if (e is SocketException) {
        errorMessage = "No internet connection. Please try again.";
      } else if (e is TimeoutException) {
        errorMessage = "Request timed out. Please try again.";
      } else {
        errorMessage = e.toString(); // Fallback for other exception types
      }

      Get.defaultDialog(
        title: "Error",
        content: Text("Failed to send data: $errorMessage"),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text("OK"),
        ),
      );
    } finally {
      isProcessing.value = false; // Reset the flag after the process
    }
  }

  Future<void> sendData(Map<String, dynamic> requestBody) async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final data =
          await _apiRepository.postMobileData(mobileDataUrl, requestBody);
      Get.back();
      Get.defaultDialog(
        backgroundColor: AppColor.buttonColor,
        title: "Success",
        titleStyle: AppTextStyle.dialogText.copyWith(fontSize: 20),
        content: Text(
          "${data['message']}",
          style: AppTextStyle.dialogText,
        ),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: Text(
            "OK",
            style: AppTextStyle.buttonText
                .copyWith(color: Colors.black, fontSize: 15),
          ),
        ),
      );
    } catch (e) {
      Get.back();

      String errorMessage;
      if (e is HttpException) {
        errorMessage = e.message;
      } else if (e is SocketException) {
        errorMessage = "No internet connection. Please try again.";
      } else if (e is TimeoutException) {
        errorMessage = "Request timed out. Please try again.";
      } else {
        errorMessage = e.toString(); // Fallback for other exception types
      }

      Get.defaultDialog(
        title: "Error",
        content: Text("Failed to send data: $errorMessage"),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text("OK"),
        ),
      );
    }
  }
}
