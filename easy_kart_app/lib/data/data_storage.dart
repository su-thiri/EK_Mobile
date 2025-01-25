import 'package:shared_preferences/shared_preferences.dart';

// class LocalStorageHelper {
//   static const _scannedQRCodesKey = 'scannedQRCodes';

//   // Save a QR code to local storage
//   static Future<void> saveQRCode(String qrCode) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> scannedCodes = prefs.getStringList(_scannedQRCodesKey) ?? [];
//     if (!scannedCodes.contains(qrCode)) {
//       scannedCodes.add(qrCode);
//       await prefs.setStringList(_scannedQRCodesKey, scannedCodes);
//     }
//   }

//   // Check if a QR code already exists in local storage
//   static Future<bool> isDuplicateQRCode(String qrCode) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> scannedCodes = prefs.getStringList(_scannedQRCodesKey) ?? [];
//     return scannedCodes.contains(qrCode);
//   }

//   // Clear all stored QR codes (for testing or resetting purposes)
//   static Future<void> clearAllQRCodes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_scannedQRCodesKey);
//   }
// }

class DataStorage {
  static final DataStorage _instance = DataStorage._internal();

  factory DataStorage() {
    return _instance;
  }

  DataStorage._internal();
  static const qrCode = 'qrCode';
  // Future<void> saveQRCode(String deviceId) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(qrCode, qrCode);
  // }

  Future<String?> getQRCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(qrCode);
  }

  Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> saveQRCode(String qrCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> scannedCodes = prefs.getStringList(qrCode) ?? [];
    if (!scannedCodes.contains(qrCode)) {
      scannedCodes.add(qrCode);
      await prefs.setStringList(qrCode, scannedCodes);
    }
  }

  // Check if a QR code already exists in local storage
  static Future<bool> isDuplicateQRCode(String qrCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> scannedCodes = prefs.getStringList(qrCode) ?? [];
    return scannedCodes.contains(qrCode);
  }

  // Clear all stored QR codes (for testing or resetting purposes)
  static Future<void> clearAllQRCodes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(qrCode);
  }
}
