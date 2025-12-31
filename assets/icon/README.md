# App Icon Setup Instructions

## Required Icon File

Please save your app icon image as:
`assets/icon/app_icon.png`

**Requirements:**
- Format: PNG
- Size: 1024x1024 pixels (recommended)
- Transparent background: Optional
- The image should be the countdown rocket icon you provided

## After Placing the Icon

Run this command to generate icons for all platforms:
```bash
flutter pub run flutter_launcher_icons
```

This will automatically create icons for:
- Android (all required sizes)
- iOS (all required sizes)
- Adaptive icons for Android

## Current Configuration

The app is configured with:
- Background color: #0A1E4D (dark blue from your icon)
- Adaptive icon support for Android
- iOS icon support

