import 'package:flutter/material.dart';

Color kPrimaryColor = const Color(0xFF166DE0);
Color kConfirmedColor = const Color(0xFFFF1242);
Color kActiveColor = const Color(0xFF017BFF);
Color kRecoveredColor = const Color(0xFF29A746);
Color kDeathColor = const Color(0xFF6D757D);

LinearGradient kGradientShimmer = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Colors.grey[300]!,
    Colors.grey[100]!,
  ],
);

RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
// Function mathFunc = (Match match) => '${match[1]}.';
// Function mathFunc() => (Match match) => '${match[1]}.';
String mathFunc(Match match) => '${match[1]}.';
