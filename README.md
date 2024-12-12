# Initial OCR functionality

To achieve the OCR functionality required for an application that reads words from a printed page

## Notes

These instructions assumed the user has a Flutter environment already set up 
(if you haven't, the installation guide can be found here: https://docs.flutter.dev/get-started/editor
or following this step-by-step guide: https://medium.com/@blup-tool/flutter-development-environment-setup-a-step-by-step-guide-5e457583bc4d)

### Pre-requisites
1. Flutter SDK & verify your installation by running flutter doctor in the terminal
2. Google_ml_kit package for OCR

### Step-by-Step
1. Clone repository
2. Install dependencies (image_picker: ^1.1.2, google_ml_kit: ^0.19.0, path_provider: ^2.1.5) and run the following command in the root of your project: flutter pub get
3. Add assets: Ensure the image file sample_image.jpg is located in the assets folder and is referenced in pubspec.yaml
4. Platform-specific Configuration: add necessary permissions for file access in
   - android/app/src/main/AndroidManifest.xml:
       - <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
       - <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
   - ios/Runner/Info.plist:
       - key>NSPhotoLibraryUsageDescription</key>
       - <string>We need access to your photo library to pick images</string>
5. Once everything is set up, run the app with: flutter run


