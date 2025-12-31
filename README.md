# Live Countdown Timer With Animations

A beautiful and feature-rich Flutter countdown timer application with custom animations, multiple design templates, and image cropping capabilities.

## Features

### 🎨 Design Templates
- **34+ Pre-designed Templates** including:
  - Life Events: Baby, Birthday, Wedding, Just Married
  - Holidays: Christmas, New Year, Halloween, Valentine's Day, Easter, Thanksgiving
  - Sports: Football, Basketball, Boxing, etc.
  - Seasons: Spring, Summer, Fall, Winter
  - Work & Finance: Payday, Retirement, Tax Day, Black Friday
  - And many more!

### 📸 Custom Background
- Upload custom images from gallery
- Advanced image cropping with multiple aspect ratios
- Full control over image positioning

### ⚙️ Countdown Configuration
- **Event Title** with live preview
- **Font Styles**: Cursive, Modern, Classic, Bold, Elegant
- **Date & Time Picker** with calendar support
- **Location Support** for timezone display
- **Display Modes**:
  - Weeks / Days / Hours / Minutes / Seconds
  - Days / Hours / Minutes / Seconds
  - Just Days
- **Stop at Zero** option

### ✨ Animations
- Smooth countdown animations
- Pulsing effects on seconds
- Floating decorative elements based on theme
- Glowing sparkles and dots
- Shimmer effects on numbers
- Theme-based animated decorations

### 🎯 Countdown Display
- Full-screen mode support
- Beautiful gradient backgrounds
- Dynamic theme-based decorations
- Real-time countdown updates
- Custom font rendering
- Shadow and glow effects

## Screenshots

The app includes three main screens:
1. **Design Selection**: Grid of 34 preset designs + custom upload option
2. **Configuration Form**: Title, date/time, location, display options
3. **Countdown Display**: Animated countdown with beautiful backgrounds

## Installation

### Prerequisites
- Flutter SDK (3.10.1 or higher)
- Dart SDK
- Android Studio / Xcode for mobile development

### Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd countdown
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
# For Android
flutter run

# For iOS
flutter run -d ios

# For Web
flutter run -d chrome
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  image_picker: ^1.0.7        # Image selection
  image_cropper: ^5.0.1       # Image cropping
  intl: ^0.19.0               # Date formatting
  google_fonts: ^6.1.0        # Custom fonts
  flutter_animate: ^4.5.0     # Animations
```

## Project Structure

```
lib/
├── main.dart                           # App entry point
├── models/
│   ├── countdown_config.dart          # Countdown configuration model
│   └── countdown_design.dart          # Design templates model
└── screens/
    ├── home_screen.dart               # Main configuration screen
    └── countdown_display_screen.dart  # Countdown display with animations
```

## Usage

### Creating a Countdown

1. **Select a Design**:
   - Choose from 34 preset designs
   - Or upload a custom image and crop it

2. **Configure Details**:
   - Enter event title
   - Choose font style
   - Set date and time
   - Add location (optional)
   - Select display mode
   - Toggle "Stop at zero" if needed

3. **Start Countdown**:
   - Click "Create Countdown" button
   - View animated countdown display
   - Toggle fullscreen mode

### Design Categories

- **Life Events**: Baby, Birthday, Party, Wedding, Just Married
- **Work**: Weekend, Work From Home, Payday, Retirement
- **Sports**: American Football, Basketball, Boxing, Fight, Football, Ice Hockey, Wrestling, Gaming
- **Holidays**: New Year, Chinese New Year, Valentine's Day, Easter, Halloween, Thanksgiving, Christmas
- **Seasons**: Spring, Summer, Fall, Winter
- **Shopping**: Black Friday, Sale
- **Other**: Vacation, Election, Launch, Road Trip, Tax Day, Vote, Generic, Text Only

## Customization

### Adding New Design Templates

Edit `lib/models/countdown_design.dart`:

```dart
CountdownDesign(
  id: 'your_design_id',
  name: 'Your Design Name',
  primaryColor: const Color(0xFF123456),
  secondaryColor: const Color(0xFF654321),
),
```

### Modifying Animations

Edit `lib/screens/countdown_display_screen.dart` to customize:
- Animation durations
- Floating elements
- Glow effects
- Decorative icons

## Permissions

### Android
The following permissions are automatically configured:
- `READ_EXTERNAL_STORAGE`
- `WRITE_EXTERNAL_STORAGE`
- `CAMERA`
- `READ_MEDIA_IMAGES`

### iOS
The following permissions are automatically configured:
- `NSPhotoLibraryUsageDescription`
- `NSCameraUsageDescription`

## Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## Known Issues

- Some deprecation warnings for `withOpacity` (using older Flutter API for compatibility)
- Radio button deprecation warnings (will be updated in future versions)

## Future Enhancements

- [ ] Save/load countdown presets
- [ ] Share countdown on social media
- [ ] Widget support for home screen
- [ ] Notification when countdown reaches zero
- [ ] Multiple countdowns management
- [ ] Sound effects and music
- [ ] More animation effects
- [ ] Dark/light theme toggle

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or suggestions, please create an issue in the repository.

---

**Built with ❤️ using Flutter**
