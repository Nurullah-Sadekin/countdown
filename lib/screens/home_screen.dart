import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/countdown_design.dart';
import '../models/countdown_config.dart';
import 'countdown_display_screen.dart';
import 'design_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedDesignId;
  String? customImagePath;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  CountdownDisplayMode displayMode = CountdownDisplayMode.daysToSeconds;
  bool stopAtZero = false;
  String selectedFontStyle = 'Cursive';

  final List<String> fontStyles = [
    'Cursive',
    'Modern',
    'Classic',
    'Bold',
    'Elegant',
  ];

  @override
  void initState() {
    super.initState();
    // Set default design to New Year
    selectedDesignId = 'new_year';
    // Auto-populate New Year date/time
    _setNewYearDateTime();
  }

  void _setNewYearDateTime() {
    final now = DateTime.now();
    final nextYear = now.year + 1;

    // Set to January 1st of next year at midnight
    dayController.text = '01';
    monthController.text = '01';
    yearController.text = nextYear.toString();
    hourController.text = '00';
    minuteController.text = '00';
    secondController.text = '00';

    // Set default title
    if (titleController.text.isEmpty) {
      titleController.text = 'New Year Countdown';
    }
  }

  Future<void> pickAndCropImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          customImagePath = croppedFile.path;
          selectedDesignId = null; // Clear preset selection
        });
      }
    }
  }

  void startCountdown() {
    // Validate inputs
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a countdown title')),
      );
      return;
    }

    if (dayController.text.isEmpty || monthController.text.isEmpty || yearController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid date')),
      );
      return;
    }

    try {
      final day = int.parse(dayController.text);
      final month = int.parse(monthController.text);
      final year = int.parse(yearController.text);
      final hour = int.tryParse(hourController.text) ?? 0;
      final minute = int.tryParse(minuteController.text) ?? 0;
      final second = int.tryParse(secondController.text) ?? 0;

      final targetDate = DateTime(year, month, day, hour, minute, second);

      final config = CountdownConfig(
        title: titleController.text,
        targetDate: targetDate,
        location: locationController.text.isNotEmpty ? locationController.text : null,
        customImagePath: customImagePath,
        selectedDesignId: selectedDesignId,
        displayMode: displayMode,
        stopAtZero: stopAtZero,
        fontStyle: selectedFontStyle,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountdownDisplayScreen(config: config),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid date format')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Create Countdown',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Design Selection
            _buildSectionTitle('Countdown design:'),
            const SizedBox(height: 12),
            _buildDesignGrid(),
            const SizedBox(height: 24),

            // Section 2: Countdown Configuration
            _buildConfigurationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDesignGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Upload Image Button
          _buildUploadImageButton(),
          const SizedBox(height: 12),

          // Choose Design Button
          _buildChooseDesignButton(),
        ],
      ),
    );
  }

  Widget _buildUploadImageButton() {
    final hasCustomImage = customImagePath != null;

    return GestureDetector(
      onTap: pickAndCropImage,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: hasCustomImage ? Colors.pinkAccent : Colors.grey[700]!,
            width: hasCustomImage ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: hasCustomImage ? Colors.grey[300] : Colors.grey[600],
        ),
        child: hasCustomImage
          ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Row(
                children: [
                  // Image preview section
                  SizedBox(
                    width: 120,
                    child: Image.file(
                      File(customImagePath!),
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                  // Label section
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Custom Background',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Row(
              children: [
                // Upload icon section
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                // Label section
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Upload Custom Background',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget _buildChooseDesignButton() {
    final hasSelectedDesign = selectedDesignId != null;
    final selectedDesign = hasSelectedDesign
        ? CountdownDesign.presetDesigns.firstWhere(
            (d) => d.id == selectedDesignId,
            orElse: () => CountdownDesign.presetDesigns[0],
          )
        : null;

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DesignSelectionScreen(
              currentSelectedId: selectedDesignId,
            ),
          ),
        );

        if (result != null) {
          setState(() {
            selectedDesignId = result;
            customImagePath = null; // Clear custom image when selecting preset

            // Auto-populate date/time if New Year is selected
            if (result == 'new_year') {
              _setNewYearDateTime();
            }
          });
        }
      },
      child: Stack(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: hasSelectedDesign && customImagePath == null
                    ? Colors.pinkAccent
                    : Colors.grey[700]!,
                width: hasSelectedDesign && customImagePath == null ? 3 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
              gradient: selectedDesign != null
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [selectedDesign.primaryColor, selectedDesign.secondaryColor],
                    )
                  : null,
              color: selectedDesign == null ? Colors.grey[600] : null,
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
                    gradient: selectedDesign != null
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              selectedDesign.primaryColor.withOpacity(0.8),
                              selectedDesign.secondaryColor.withOpacity(0.8),
                            ],
                          )
                        : null,
                    color: selectedDesign == null ? Colors.grey[700] : null,
                  ),
                  child: Center(
                    child: Icon(
                      selectedDesign != null
                          ? _getIconForDesign(selectedDesign.id)
                          : Icons.palette,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                // Label section
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedDesign != null
                            ? selectedDesign.name
                            : 'Choose Design',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: hasSelectedDesign && customImagePath == null
                              ? Colors.pinkAccent
                              : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Change/Choose button overlay
          if (hasSelectedDesign)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Change',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          else
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Choose',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildConfigurationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Font Style Row
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Countdown title:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Event Name...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Font style:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: selectedFontStyle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: fontStyles.map((font) {
                  return DropdownMenuItem(
                    value: font,
                    child: Text(font, style: GoogleFonts.poppins()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFontStyle = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Title Preview
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              titleController.text.isEmpty ? 'Event Title Preview' : titleController.text,
              textAlign: TextAlign.center,
              style: _getFontStyle(selectedFontStyle).copyWith(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          Text(
            'Title Preview',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),

          // Date inputs
          Row(
            children: [
              Expanded(
                child: _buildDateField('Day:', dayController, 'dd'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateField('Month:', monthController, 'mm'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateField('Year:', yearController, 'yyyy'),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() {
                      dayController.text = date.day.toString().padLeft(2, '0');
                      monthController.text = date.month.toString().padLeft(2, '0');
                      yearController.text = date.year.toString();
                    });
                  }
                },
                child: Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.calendar_today, color: Colors.red[400]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Time inputs
          Row(
            children: [
              Expanded(
                child: _buildDateField('Hour:', hourController, 'hh'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateField('Minute:', minuteController, 'mm'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateField('Second:', secondController, 'ss'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Location
          Text(
            'Location of event:',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: locationController,
            decoration: InputDecoration(
              hintText: 'Start typing name of city',
              hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 24),

          // Display mode options
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRadioOption(
                'Weeks / Days / Hours / Minutes / Seconds',
                CountdownDisplayMode.weeksToSeconds,
              ),
              _buildRadioOption(
                'Days / Hours / Minutes / Seconds',
                CountdownDisplayMode.daysToSeconds,
              ),
              _buildRadioOption(
                'Just Days',
                CountdownDisplayMode.justDays,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stop at zero checkbox
          Row(
            children: [
              Checkbox(
                value: stopAtZero,
                onChanged: (value) {
                  setState(() {
                    stopAtZero = value!;
                  });
                },
              ),
              Text(
                'Stop countdown at zero',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Create Countdown Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: startCountdown,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF86BC25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Create Countdown',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(String label, CountdownDisplayMode mode) {
    return InkWell(
      onTap: () {
        setState(() {
          displayMode = mode;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Radio<CountdownDisplayMode>(
              value: mode,
              groupValue: displayMode,
              onChanged: (value) {
                setState(() {
                  displayMode = value!;
                });
              },
            ),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _getFontStyle(String fontName) {
    switch (fontName) {
      case 'Cursive':
        return GoogleFonts.dancingScript();
      case 'Modern':
        return GoogleFonts.montserrat();
      case 'Classic':
        return GoogleFonts.merriweather();
      case 'Bold':
        return GoogleFonts.bebasNeue();
      case 'Elegant':
        return GoogleFonts.playfairDisplay();
      default:
        return GoogleFonts.poppins();
    }
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

  @override
  void dispose() {
    titleController.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    hourController.dispose();
    minuteController.dispose();
    secondController.dispose();
    locationController.dispose();
    super.dispose();
  }
}

