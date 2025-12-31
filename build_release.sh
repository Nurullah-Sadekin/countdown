#!/bin/bash

echo "=============================================="
echo "Countdown Timer App - Icon & Build Setup"
echo "=============================================="
echo ""

# Check if icon exists
if [ ! -f "assets/icon/app_icon.png" ]; then
    echo "⚠️  WARNING: App icon not found!"
    echo ""
    echo "Please save your countdown rocket icon as:"
    echo "  assets/icon/app_icon.png"
    echo ""
    echo "Requirements:"
    echo "  - Format: PNG"
    echo "  - Size: 1024x1024 pixels (recommended)"
    echo "  - Use the rocket countdown icon you provided"
    echo ""
    echo "After saving the icon, run:"
    echo "  1. flutter pub run flutter_launcher_icons"
    echo "  2. flutter build appbundle --release"
    echo ""
    exit 1
fi

echo "✅ Icon file found!"
echo ""

# Generate icons for all platforms
echo "📱 Generating icons for all platforms..."
flutter pub run flutter_launcher_icons

if [ $? -eq 0 ]; then
    echo "✅ Icons generated successfully!"
else
    echo "❌ Icon generation failed!"
    exit 1
fi

echo ""
echo "🏗️  Building release AAB..."
flutter build appbundle --release

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ BUILD SUCCESSFUL!"
    echo ""
    echo "📦 Release AAB location:"
    echo "   build/app/outputs/bundle/release/app-release.aab"
    echo ""
    echo "📊 App Details:"
    echo "   - Name: Countdown Timer"
    echo "   - Package: com.countdown.countdown"
    echo "   - Version: 1.0.0"
    echo "   - Build: 1"
    echo ""
else
    echo "❌ Build failed!"
    exit 1
fi

