import 'package:flutter/material.dart';

class CountdownDesign {
  final String id;
  final String name;
  final String? assetPath;
  final Color primaryColor;
  final Color secondaryColor;

  CountdownDesign({
    required this.id,
    required this.name,
    this.assetPath,
    required this.primaryColor,
    required this.secondaryColor,
  });

  static List<CountdownDesign> presetDesigns = [
    // New Year at the top as default
    CountdownDesign(
      id: 'new_year',
      name: 'New Year',
      primaryColor: const Color(0xFF1E1B4B),
      secondaryColor: const Color(0xFFFCD34D),
    ),
    CountdownDesign(
      id: 'baby',
      name: 'Baby',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFFFFB6C1),
    ),
    CountdownDesign(
      id: 'birthday',
      name: 'Birthday',
      primaryColor: const Color(0xFF98D8C8),
      secondaryColor: const Color(0xFFFF69B4),
    ),
    CountdownDesign(
      id: 'party',
      name: 'Party',
      primaryColor: const Color(0xFFFF69B4),
      secondaryColor: const Color(0xFFFFD700),
    ),
    CountdownDesign(
      id: 'vacation',
      name: 'Vacation',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFF32CD32),
    ),
    CountdownDesign(
      id: 'wedding',
      name: 'Wedding',
      primaryColor: const Color(0xFF4169E1),
      secondaryColor: const Color(0xFFFFFFFF),
    ),
    CountdownDesign(
      id: 'married',
      name: 'Just Married',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFFFF69B4),
    ),
    CountdownDesign(
      id: 'weekend',
      name: 'Weekend',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFFFFD700),
    ),
    CountdownDesign(
      id: 'work_from_home',
      name: 'Work From Home',
      primaryColor: const Color(0xFF6A5ACD),
      secondaryColor: const Color(0xFF20B2AA),
    ),
    CountdownDesign(
      id: 'payday',
      name: 'Payday',
      primaryColor: const Color(0xFF483D8B),
      secondaryColor: const Color(0xFF00CED1),
    ),
    CountdownDesign(
      id: 'retirement',
      name: 'Retirement',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFFFFD700),
    ),
    CountdownDesign(
      id: 'football',
      name: 'American Football',
      primaryColor: const Color(0xFF228B22),
      secondaryColor: const Color(0xFFFFFFFF),
    ),
    CountdownDesign(
      id: 'basketball',
      name: 'Basketball',
      primaryColor: const Color(0xFFFF8C00),
      secondaryColor: const Color(0xFFFFFFFF),
    ),
    CountdownDesign(
      id: 'boxing',
      name: 'Boxing',
      primaryColor: const Color(0xFF1E3A8A),
      secondaryColor: const Color(0xFFDC2626),
    ),
    CountdownDesign(
      id: 'chinese_new_year',
      name: 'Chinese New Year',
      primaryColor: const Color(0xFFDC2626),
      secondaryColor: const Color(0xFFFCD34D),
    ),
    CountdownDesign(
      id: 'valentine',
      name: "Valentine's Day",
      primaryColor: const Color(0xFFFFB6C1),
      secondaryColor: const Color(0xFFFF1493),
    ),
    CountdownDesign(
      id: 'easter',
      name: 'Easter',
      primaryColor: const Color(0xFF40E0D0),
      secondaryColor: const Color(0xFFFF69B4),
    ),
    CountdownDesign(
      id: 'halloween',
      name: 'Halloween',
      primaryColor: const Color(0xFF1F2937),
      secondaryColor: const Color(0xFFFF6B00),
    ),
    CountdownDesign(
      id: 'thanksgiving',
      name: 'Thanksgiving',
      primaryColor: const Color(0xFFD2691E),
      secondaryColor: const Color(0xFFFF8C00),
    ),
    CountdownDesign(
      id: 'christmas',
      name: 'Christmas',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFFDC143C),
    ),
    CountdownDesign(
      id: 'spring',
      name: 'Spring',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFF98D8C8),
    ),
    CountdownDesign(
      id: 'summer',
      name: 'Summer',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFFFFD700),
    ),
    CountdownDesign(
      id: 'fall',
      name: 'Fall',
      primaryColor: const Color(0xFFD2691E),
      secondaryColor: const Color(0xFFFF8C00),
    ),
    CountdownDesign(
      id: 'winter',
      name: 'Winter',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFFFFFFFF),
    ),
    CountdownDesign(
      id: 'election',
      name: 'Election',
      primaryColor: const Color(0xFF4B5563),
      secondaryColor: const Color(0xFFDC2626),
    ),
    CountdownDesign(
      id: 'gaming',
      name: 'Gaming',
      primaryColor: const Color(0xFF4C1D95),
      secondaryColor: const Color(0xFF10B981),
    ),
    CountdownDesign(
      id: 'launch',
      name: 'Launch',
      primaryColor: const Color(0xFF1E293B),
      secondaryColor: const Color(0xFF3B82F6),
    ),
    CountdownDesign(
      id: 'road_trip',
      name: 'Road Trip',
      primaryColor: const Color(0xFF87CEEB),
      secondaryColor: const Color(0xFF32CD32),
    ),
    CountdownDesign(
      id: 'black_friday',
      name: 'Black Friday',
      primaryColor: const Color(0xFF1F2937),
      secondaryColor: const Color(0xFFFCD34D),
    ),
    CountdownDesign(
      id: 'sale',
      name: 'Sale',
      primaryColor: const Color(0xFF059669),
      secondaryColor: const Color(0xFFFCD34D),
    ),
    CountdownDesign(
      id: 'tax_day',
      name: 'Tax Day',
      primaryColor: const Color(0xFF4C1D95),
      secondaryColor: const Color(0xFF06B6D4),
    ),
    CountdownDesign(
      id: 'vote',
      name: 'Vote',
      primaryColor: const Color(0xFF4C1D95),
      secondaryColor: const Color(0xFFDC2626),
    ),
    CountdownDesign(
      id: 'generic',
      name: 'Generic',
      primaryColor: const Color(0xFF3B82F6),
      secondaryColor: const Color(0xFF60A5FA),
    ),
    CountdownDesign(
      id: 'text_only',
      name: 'Text Only',
      primaryColor: const Color(0xFFFFFFFF),
      secondaryColor: const Color(0xFFDC2626),
    ),
  ];
}

