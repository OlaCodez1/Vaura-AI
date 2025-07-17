import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'screens/onboarding.dart'; // Assuming this file exists and is correct

void main() => runApp(const VauraApp());
=======
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'sp_custom.dart'; // ✅ make sure this import is here
import 'screens/auth.dart';
import 'screens/onboarding.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Required before async code
  await SP.init(); // ✅ Initialize shared prefs

  runApp(const VauraApp());
}
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config

class VauraApp extends StatefulWidget {
  const VauraApp({super.key});

  @override
  State<VauraApp> createState() => _VauraAppState();
}

class _VauraAppState extends State<VauraApp> {
  bool _fontLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadFont();
  }

  Future<void> _loadFont() async {
<<<<<<< HEAD
    try {
      // This function now handles downloading, caching, and loading the font
      await loadFontFromUrl(
          "https://olacodez1.github.io/fonts-public/ZonaPro-Bold.ttf",
          "ZonaPro");
=======
    if (kIsWeb) {
      debugPrint("Skipping font loading on web.");
      return;
    }

    try {
      await loadFontFromUrl(
        "https://olacodez1.github.io/fonts-public/ZonaPro-Bold.ttf",
        "ZonaPro",
      );
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
      setState(() {
        _fontLoaded = true;
      });
    } catch (e) {
<<<<<<< HEAD
      // It's good practice to log errors for debugging
=======
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
      debugPrint("Failed to load font: $e");
    }
  }

<<<<<<< HEAD
  /// Downloads a font from a URL, caches it locally, and loads it for the app.
=======
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
  Future<void> loadFontFromUrl(String url, String fontFamily) async {
    final dir = await getApplicationDocumentsDirectory();
    final fontFile = File('${dir.path}/$fontFamily.ttf');
    Uint8List fontBytes;

<<<<<<< HEAD
    // Check if the font is already cached on the device
=======
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
    if (await fontFile.exists()) {
      debugPrint("Font loaded from cache.");
      fontBytes = await fontFile.readAsBytes();
    } else {
<<<<<<< HEAD
      // If not cached, download it from the URL
=======
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
      debugPrint("Downloading font...");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        fontBytes = response.bodyBytes;
<<<<<<< HEAD
        // Save the downloaded font to the file for future use
        await fontFile.writeAsBytes(fontBytes);
        debugPrint("Font downloaded and cached.");
      } else {
        // Handle cases where the font fails to download
=======
        await fontFile.writeAsBytes(fontBytes);
        debugPrint("Font downloaded and cached.");
      } else {
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
        throw Exception('Failed to download font: ${response.statusCode}');
      }
    }

<<<<<<< HEAD
    // Load the font into the app's font loader
    final fontLoader = FontLoader(fontFamily);
    // **FIX:** Convert Uint8List to ByteData and wrap in a Future
=======
    final fontLoader = FontLoader(fontFamily);
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
    final byteData = ByteData.view(fontBytes.buffer);
    fontLoader.addFont(Future.value(byteData));
    await fontLoader.load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaura',
      theme: ThemeData(
<<<<<<< HEAD
        // Apply the font to the entire app's text theme once loaded
        textTheme: _fontLoaded
            ? Theme.of(context).textTheme.apply(
                  fontFamily: 'ZonaPro',
                  bodyColor: Colors.white, // Example: Set default text color
                  displayColor: Colors.white, // Example: Set default text color
=======
        textTheme: _fontLoaded
            ? Theme.of(context).textTheme.apply(
                  fontFamily: 'ZonaPro',
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
                )
            : Theme.of(context).textTheme,
      ),
      initialRoute: '/',
      routes: {
<<<<<<< HEAD
        // Ensure the OnboardingScreen widget is const if its constructor is
        '/': (context) => const OnboardingScreen(),
      },
      // **FIX:** Added the missing closing parenthesis for MaterialPageRoute
=======
        '/': (context) => const OnboardingScreen(),
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
      },
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('404 - Screen not found')),
        ),
      ),
    );
  }
}
