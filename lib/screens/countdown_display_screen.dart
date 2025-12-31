import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/countdown_config.dart';
import '../models/countdown_design.dart';

class CountdownDisplayScreen extends StatefulWidget {
  final CountdownConfig config;

  const CountdownDisplayScreen({super.key, required this.config});

  @override
  State<CountdownDisplayScreen> createState() => _CountdownDisplayScreenState();
}

class _CountdownDisplayScreenState extends State<CountdownDisplayScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  bool _isFullscreen = false;

  late AnimationController _pulseController;
  late AnimationController _floatingController;
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateRemainingTime();
    });

    // Animation controllers
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    final difference = widget.config.targetDate.difference(now);

    setState(() {
      if (widget.config.stopAtZero && difference.isNegative) {
        _remainingTime = Duration.zero;
      } else {
        _remainingTime = difference;
      }
    });
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });

    // Set screen orientation based on fullscreen state
    if (_isFullscreen) {
      // Enter fullscreen - switch to landscape
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      // Hide system UI for immersive experience
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      // Exit fullscreen - return to portrait
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      // Show system UI again
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _floatingController.dispose();
    _glowController.dispose();

    // Reset orientation to portrait when leaving the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background
          _buildBackground(),

          // Animated decorations
          _buildAnimatedDecorations(),

          // Main content
          SafeArea(
            child: Column(
              children: [
                if (!_isFullscreen) _buildAppBar(),
                Expanded(
                  child: _buildCountdownContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    if (widget.config.customImagePath != null) {
      return Positioned.fill(
        child: Image.file(
          File(widget.config.customImagePath!),
          fit: BoxFit.cover,
        ),
      );
    }

    final design = CountdownDesign.presetDesigns.firstWhere(
      (d) => d.id == widget.config.selectedDesignId,
      orElse: () => CountdownDesign.presetDesigns[0],
    );

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              design.primaryColor.withOpacity(0.8),
              design.secondaryColor.withOpacity(0.8),
              design.primaryColor.withOpacity(0.6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedDecorations() {
    final design = CountdownDesign.presetDesigns.firstWhere(
      (d) => d.id == widget.config.selectedDesignId,
      orElse: () => CountdownDesign.presetDesigns[0],
    );

    return Stack(
      children: [
        // Floating elements based on theme
        ...List.generate(15, (index) {
          return AnimatedBuilder(
            animation: _floatingController,
            builder: (context, child) {
              final offset = math.sin(_floatingController.value * 2 * math.pi + index) * 20;
              return Positioned(
                left: (index % 5) * MediaQuery.of(context).size.width / 5 +
                      math.cos(index.toDouble()) * 30,
                top: (index ~/ 5) * MediaQuery.of(context).size.height / 3 + offset,
                child: Opacity(
                  opacity: 0.3 + (_floatingController.value * 0.3),
                  child: _getDecorativeIcon(design.id, index),
                ),
              );
            },
          );
        }),

        // Animated dots/sparkles
        ...List.generate(30, (index) {
          return AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              final scale = 0.5 + (_glowController.value * 0.5);
              return Positioned(
                left: math.Random(index).nextDouble() * MediaQuery.of(context).size.width,
                top: math.Random(index + 100).nextDouble() * MediaQuery.of(context).size.height,
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _getDecorativeIcon(String designId, int index) {
    IconData icon;

    switch (designId) {
      case 'new_year':
      case 'chinese_new_year':
        icon = Icons.auto_awesome;
        break;
      case 'christmas':
        icon = index % 3 == 0 ? Icons.ac_unit : Icons.star;
        break;
      case 'valentine':
        icon = Icons.favorite;
        break;
      case 'halloween':
        icon = Icons.nightlight;
        break;
      case 'birthday':
        icon = Icons.cake;
        break;
      default:
        icon = Icons.circle;
    }

    return Icon(
      icon,
      color: Colors.white.withOpacity(0.5),
      size: 24 + (index % 3) * 8,
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.pink[400],
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
            color: Colors.white,
            onPressed: _toggleFullscreen,
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final scale = 1.0 + (_pulseController.value * 0.05);
              return Transform.scale(
                scale: scale,
                child: Text(
                  widget.config.title,
                  textAlign: TextAlign.center,
                  style: _getFontStyle().copyWith(
                    fontSize: _isFullscreen ? 56 : 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(2, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),
              );
            },
          ),
          const SizedBox(height: 40),

          // Countdown numbers
          _buildCountdownNumbers(),
          const SizedBox(height: 40),

          // Date and location info
          _buildDateInfo(),
        ],
      ),
    );
  }

  Widget _buildCountdownNumbers() {
    final weeks = _remainingTime.inDays ~/ 7;
    final days = _remainingTime.inDays % 7;
    final hours = _remainingTime.inHours % 24;
    final minutes = _remainingTime.inMinutes % 60;
    final seconds = _remainingTime.inSeconds % 60;

    switch (widget.config.displayMode) {
      case CountdownDisplayMode.weeksToSeconds:
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeUnit(weeks.toString(), 'WEEKS', constraints.maxWidth),
                  _buildTimeUnit(days.toString().padLeft(2, '0'), 'DAYS', constraints.maxWidth),
                  _buildTimeUnit(hours.toString().padLeft(2, '0'), 'HOURS', constraints.maxWidth),
                  _buildTimeUnit(minutes.toString().padLeft(2, '0'), 'MINUTES', constraints.maxWidth),
                  _buildTimeUnit(seconds.toString().padLeft(2, '0'), 'SECONDS', constraints.maxWidth, isLast: true),
                ],
              ),
            );
          },
        );

      case CountdownDisplayMode.daysToSeconds:
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeUnit(_remainingTime.inDays.toString(), 'DAYS', constraints.maxWidth),
                  _buildTimeUnit(hours.toString().padLeft(2, '0'), 'HOURS', constraints.maxWidth),
                  _buildTimeUnit(minutes.toString().padLeft(2, '0'), 'MINUTES', constraints.maxWidth),
                  _buildTimeUnit(seconds.toString().padLeft(2, '0'), 'SECONDS', constraints.maxWidth, isLast: true),
                ],
              ),
            );
          },
        );

      case CountdownDisplayMode.justDays:
        return LayoutBuilder(
          builder: (context, constraints) {
            return _buildTimeUnit(_remainingTime.inDays.toString(), 'DAYS', constraints.maxWidth, isLast: true, large: true);
          },
        );
    }
  }

  Widget _buildTimeUnit(String value, String label, double screenWidth, {bool isLast = false, bool large = false}) {
    // Calculate responsive font sizes based on screen width
    double numberFontSize;
    double labelFontSize;
    double spacing = 8.0;

    if (large) {
      numberFontSize = screenWidth > 600 ? 120 : (screenWidth > 400 ? 80 : 60);
      labelFontSize = screenWidth > 600 ? 24 : (screenWidth > 400 ? 18 : 14);
    } else {
      if (_isFullscreen) {
        numberFontSize = screenWidth > 600 ? 100 : (screenWidth > 400 ? 60 : 45);
        labelFontSize = screenWidth > 600 ? 16 : (screenWidth > 400 ? 12 : 10);
      } else {
        numberFontSize = screenWidth > 600 ? 80 : (screenWidth > 400 ? 50 : 38);
        labelFontSize = screenWidth > 600 ? 16 : (screenWidth > 400 ? 12 : 10);
      }
      spacing = screenWidth > 400 ? 16.0 : 8.0;
    }

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final isSeconds = label == 'SECONDS';
        final scale = isSeconds ? 1.0 + (_pulseController.value * 0.1) : 1.0;

        return Transform.scale(
          scale: scale,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: large ? 0 : (screenWidth > 400 ? 8 : 4)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: numberFontSize,
                    fontWeight: FontWeight.bold,
                    color: isSeconds ? Colors.pink[300] : Colors.white,
                    height: 1,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(3, 3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ).animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                ).shimmer(
                  duration: 2000.ms,
                  color: Colors.white.withOpacity(0.3),
                ),
                SizedBox(height: spacing),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: labelFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: screenWidth > 400 ? 2 : 1,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateInfo() {
    final formattedDate = DateFormat('EEEE, d MMMM yyyy').format(widget.config.targetDate);
    final location = widget.config.location;

    return Column(
      children: [
        Text(
          'Time until $formattedDate${location != null ? " ($location time)" : ""}',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: _isFullscreen ? 20 : 16,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(1, 1),
                blurRadius: 4,
              ),
            ],
          ),
        ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
      ],
    );
  }

  TextStyle _getFontStyle() {
    switch (widget.config.fontStyle) {
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
}

