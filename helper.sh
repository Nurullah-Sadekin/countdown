#!/bin/bash
# Helpful Commands for Live Countdown Timer App

echo "════════════════════════════════════════════════════════════"
echo "  Live Countdown Timer - Helpful Commands"
echo "════════════════════════════════════════════════════════════"
echo ""

# Function to display menu
show_menu() {
    echo "Choose an option:"
    echo "1. Install dependencies"
    echo "2. Run on Chrome (Web)"
    echo "3. Run on Android"
    echo "4. Run on iOS"
    echo "5. Build for Web"
    echo "6. Build for Android"
    echo "7. Build for iOS"
    echo "8. Clean and reinstall"
    echo "9. Check for errors"
    echo "10. Exit"
    echo ""
    read -p "Enter your choice (1-10): " choice
    echo ""
}

# Main loop
while true; do
    show_menu

    case $choice in
        1)
            echo "📦 Installing dependencies..."
            flutter pub get
            echo "✅ Done!"
            ;;
        2)
            echo "🌐 Running on Chrome..."
            flutter run -d chrome
            ;;
        3)
            echo "🤖 Running on Android..."
            flutter run -d android
            ;;
        4)
            echo "🍎 Running on iOS..."
            flutter run -d ios
            ;;
        5)
            echo "🏗️  Building for Web..."
            flutter build web --no-tree-shake-icons
            echo "✅ Build complete! Check build/web folder"
            ;;
        6)
            echo "🏗️  Building for Android..."
            flutter build apk --release
            echo "✅ Build complete! Check build/app/outputs/flutter-apk/"
            ;;
        7)
            echo "🏗️  Building for iOS..."
            flutter build ios --release
            echo "✅ Build complete!"
            ;;
        8)
            echo "🧹 Cleaning and reinstalling..."
            flutter clean
            flutter pub get
            echo "✅ Done!"
            ;;
        9)
            echo "🔍 Checking for errors..."
            flutter analyze
            ;;
        10)
            echo "👋 Goodbye!"
            exit 0
            ;;
        *)
            echo "❌ Invalid choice. Please try again."
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
    echo ""
done

