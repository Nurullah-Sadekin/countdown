# 🚀 Countdown Timer App - Release Build Instructions

## Step 1: Save the App Icon

**IMPORTANT**: You need to manually save the countdown rocket icon image.

1. Save your app icon image to:
   ```
   assets/icon/app_icon.png
   ```

2. **Icon Requirements**:
   - Format: PNG with transparency
   - Recommended size: 1024x1024 pixels
   - The rocket countdown icon you provided in the chat

## Step 2: Generate Icons for All Platforms

After saving the icon, run:

```bash
flutter pub run flutter_launcher_icons
```

This will automatically generate:
- ✅ Android icons (all densities: mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)
- ✅ Android adaptive icons (foreground + background)
- ✅ iOS icons (all required sizes)

## Step 3: Build Release AAB

Run one of these commands:

**Option 1 - Automated Script:**
```bash
./build_release.sh
```

**Option 2 - Manual Command:**
```bash
flutter build appbundle --release
```

## Release AAB Location

After successful build:
```
build/app/outputs/bundle/release/app-release.aab
```

## App Configuration

✅ **App Name**: Countdown Timer
✅ **Package ID**: com.countdown.countdown
✅ **Version**: 1.0.0 (Build 1)
✅ **Signing**: Configured with upload-keystore.jks
✅ **Key Alias**: bsc
✅ **Store Password**: *** (from key.properties)

## Build Features

- ✅ Code minification enabled
- ✅ Resource shrinking enabled
- ✅ Proper release signing
- ✅ Optimized for Google Play Store

## Upload to Google Play Console

1. Go to: https://play.google.com/console
2. Create a new app or select existing
3. Go to "Release" > "Production" > "Create new release"
4. Upload the AAB file: `app-release.aab`
5. Fill in release notes
6. Submit for review

## Keystore Backup

⚠️ **IMPORTANT**: Keep these files safe and backed up:
- `android/app/upload-keystore.jks`
- `android/key.properties`

Without these, you cannot update your app in the future!

## Troubleshooting

### Icon Generation Failed
```bash
# Make sure icon file exists
ls -la assets/icon/app_icon.png

# Re-run icon generation
flutter clean
flutter pub get
flutter pub run flutter_launcher_icons
```

### Build Failed
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build appbundle --release
```

### Signing Issues
- Verify `key.properties` has correct values
- Verify `upload-keystore.jks` exists
- Check file paths in `key.properties`

## Next Steps After Build

1. ✅ Test the release build on a device
2. ✅ Upload to Google Play Console
3. ✅ Configure store listing (screenshots, description)
4. ✅ Set up pricing & distribution
5. ✅ Submit for review

---

**Current Status**: Ready to build once icon is placed!

