# Quick Start Guide

## Running the App

### Option 1: Run on Android Emulator/Device

1. Make sure you have an Android emulator running or a device connected:
```bash
flutter devices
```

2. Run the app:
```bash
flutter run
```

### Option 2: Run on iOS Simulator (macOS only)

1. Open iOS Simulator:
```bash
open -a Simulator
```

2. Run the app:
```bash
flutter run -d ios
```

### Option 3: Run on Chrome (Web)

```bash
flutter run -d chrome
```

## How to Use

### Step 1: Select a Design
1. Scroll through the grid of 34+ preset designs
2. Click on any design to select it (it will show a pink border)
3. OR click "Custom" to upload your own image
4. If you choose custom, you can crop the image to your preference

### Step 2: Configure Your Countdown

1. **Enter Event Title**: Type your event name (e.g., "New Year Countdown")
2. **Select Font Style**: Choose from Cursive, Modern, Classic, Bold, or Elegant
3. **Set Date**: Enter day, month, year manually OR click the calendar icon
4. **Set Time**: Enter hour, minute, second (optional)
5. **Add Location**: Type city name (optional) - will show in countdown display
6. **Choose Display Mode**:
   - Weeks / Days / Hours / Minutes / Seconds
   - Days / Hours / Minutes / Seconds (default)
   - Just Days
7. **Stop at Zero**: Check this if you want countdown to stop at zero (not go negative)

### Step 3: Start Countdown

1. Click the green "Create Countdown" button
2. Your countdown will appear with beautiful animations!
3. Click the fullscreen icon (top right) to enter fullscreen mode
4. Click the menu icon (top left) to go back and create a new countdown

## Tips

- The seconds number pulses with animation
- Decorative elements float and glow based on your selected theme
- Try different font styles to match your event's mood
- Custom images work best in landscape orientation
- Use the calendar picker for quick date selection
- Location is optional but adds a nice touch to the display

## Troubleshooting

### App won't build?
```bash
flutter clean
flutter pub get
flutter run
```

### Image picker not working?
- Make sure you granted photo library permissions
- On Android: Check Settings > Apps > Countdown > Permissions
- On iOS: Check Settings > Countdown > Photos

### Countdown not accurate?
- The countdown updates every second
- Make sure your device time is correct
- Timezone is based on device settings

## Common Use Cases

### Birthday Countdown
1. Select "Birthday" design
2. Enter birthday person's name
3. Set their birth date
4. Choose "Days / Hours / Minutes / Seconds"
5. Start countdown!

### New Year Countdown
1. Select "New Year" design
2. Enter "New Year Countdown"
3. Set January 1st next year at midnight (00:00:00)
4. Add your city for timezone
5. Watch the countdown!

### Vacation Countdown
1. Select "Vacation" design
2. Upload a photo from your destination (optional)
3. Enter vacation start date
4. Choose "Just Days" for simplicity
5. Get excited!

## Next Steps

- Try all the different designs
- Experiment with custom images
- Test different font styles
- Create countdowns for upcoming events
- Share screenshots with friends!

Enjoy your countdown! 🎉

