enum CountdownDisplayMode {
  weeksToSeconds,
  daysToSeconds,
  justDays,
}

class CountdownConfig {
  final String title;
  final DateTime targetDate;
  final String? location;
  final String? customImagePath;
  final String? selectedDesignId;
  final CountdownDisplayMode displayMode;
  final bool stopAtZero;
  final String fontStyle;

  CountdownConfig({
    required this.title,
    required this.targetDate,
    this.location,
    this.customImagePath,
    this.selectedDesignId,
    this.displayMode = CountdownDisplayMode.daysToSeconds,
    this.stopAtZero = false,
    this.fontStyle = 'Cursive',
  });

  CountdownConfig copyWith({
    String? title,
    DateTime? targetDate,
    String? location,
    String? customImagePath,
    String? selectedDesignId,
    CountdownDisplayMode? displayMode,
    bool? stopAtZero,
    String? fontStyle,
  }) {
    return CountdownConfig(
      title: title ?? this.title,
      targetDate: targetDate ?? this.targetDate,
      location: location ?? this.location,
      customImagePath: customImagePath ?? this.customImagePath,
      selectedDesignId: selectedDesignId ?? this.selectedDesignId,
      displayMode: displayMode ?? this.displayMode,
      stopAtZero: stopAtZero ?? this.stopAtZero,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }
}

