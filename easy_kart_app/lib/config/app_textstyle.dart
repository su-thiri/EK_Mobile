import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  /// H5 Font
  static TextStyle selectText = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.itim().fontFamily,
  );
  static TextStyle buttonText = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w800,
    fontFamily: GoogleFonts.inter().fontFamily,
  );
  static TextStyle dialogText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    fontFamily: GoogleFonts.inter().fontFamily,
  );
}
