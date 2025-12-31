import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/countdown_design.dart';

class DesignSelectionScreen extends StatefulWidget {
  final String? currentSelectedId;

  const DesignSelectionScreen({
    super.key,
    this.currentSelectedId,
  });

  @override
  State<DesignSelectionScreen> createState() => _DesignSelectionScreenState();
}

class _DesignSelectionScreenState extends State<DesignSelectionScreen> {
  String? selectedDesignId;

  @override
  void initState() {
    super.initState();
    selectedDesignId = widget.currentSelectedId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Choose Design',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          if (selectedDesignId != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context, selectedDesignId);
              },
              child: Text(
                'Done',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: const Color(0xFF86BC25),
                ),
              ),
            ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.separated(
            itemCount: CountdownDesign.presetDesigns.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final design = CountdownDesign.presetDesigns[index];
              final isSelected = selectedDesignId == design.id;
              return _buildDesignCard(design, isSelected);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesignCard(CountdownDesign design, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDesignId = design.id;
        });
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.pinkAccent : Colors.grey[700]!,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [design.primaryColor, design.secondaryColor],
          ),
        ),
        child: Row(
          children: [
            // Icon section
            Container(
              width: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    design.primaryColor.withOpacity(0.8),
                    design.secondaryColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  _getIconForDesign(design.id),
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
            // Name section
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        design.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.pinkAccent : Colors.blue[700],
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.pinkAccent,
                        size: 28,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForDesign(String id) {
    switch (id) {
      case 'baby':
        return Icons.child_care;
      case 'birthday':
        return Icons.cake;
      case 'party':
        return Icons.celebration;
      case 'vacation':
        return Icons.flight;
      case 'wedding':
      case 'married':
        return Icons.favorite;
      case 'weekend':
        return Icons.weekend;
      case 'work_from_home':
        return Icons.home_work;
      case 'payday':
        return Icons.attach_money;
      case 'retirement':
        return Icons.beach_access;
      case 'football':
      case 'basketball':
      case 'boxing':
        return Icons.sports;
      case 'new_year':
      case 'chinese_new_year':
        return Icons.auto_awesome;
      case 'valentine':
        return Icons.favorite;
      case 'easter':
        return Icons.egg;
      case 'halloween':
        return Icons.nightlight;
      case 'thanksgiving':
        return Icons.dinner_dining;
      case 'christmas':
        return Icons.ac_unit;
      case 'spring':
      case 'summer':
      case 'fall':
      case 'winter':
        return Icons.wb_sunny;
      case 'election':
      case 'vote':
        return Icons.how_to_vote;
      case 'gaming':
        return Icons.sports_esports;
      case 'launch':
        return Icons.rocket_launch;
      case 'road_trip':
        return Icons.directions_car;
      case 'black_friday':
      case 'sale':
        return Icons.shopping_bag;
      case 'tax_day':
        return Icons.receipt;
      default:
        return Icons.event;
    }
  }
}

