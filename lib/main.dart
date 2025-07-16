import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'screens/onboarding.dart'; // Assuming this file exists and is correct

void main() => runApp(const VauraApp());

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
    try {
      // This function now handles downloading, caching, and loading the font
      await loadFontFromUrl(
          "https://olacodez1.github.io/fonts-public/ZonaPro-Bold.ttf",
          "ZonaPro");
      setState(() {
        _fontLoaded = true;
      });
    } catch (e) {
      // It's good practice to log errors for debugging
      debugPrint("Failed to load font: $e");
    }
  }

  /// Downloads a font from a URL, caches it locally, and loads it for the app.
  Future<void> loadFontFromUrl(String url, String fontFamily) async {
    final dir = await getApplicationDocumentsDirectory();
    final fontFile = File('${dir.path}/$fontFamily.ttf');
    Uint8List fontBytes;

    // Check if the font is already cached on the device
    if (await fontFile.exists()) {
      debugPrint("Font loaded from cache.");
      fontBytes = await fontFile.readAsBytes();
    } else {
      // If not cached, download it from the URL
      debugPrint("Downloading font...");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        fontBytes = response.bodyBytes;
        // Save the downloaded font to the file for future use
        await fontFile.writeAsBytes(fontBytes);
        debugPrint("Font downloaded and cached.");
      } else {
        // Handle cases where the font fails to download
        throw Exception('Failed to download font: ${response.statusCode}');
      }
    }

    // Load the font into the app's font loader
    final fontLoader = FontLoader(fontFamily);
    // **FIX:** Convert Uint8List to ByteData and wrap in a Future
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
        // Apply the font to the entire app's text theme once loaded
        textTheme: _fontLoaded
            ? Theme.of(context).textTheme.apply(
                  fontFamily: 'ZonaPro',
                  bodyColor: Colors.white, // Example: Set default text color
                  displayColor: Colors.white, // Example: Set default text color
                )
            : Theme.of(context).textTheme,
      ),
      initialRoute: '/',
      routes: {
        // Ensure the OnboardingScreen widget is const if its constructor is
        '/': (context) => const OnboardingScreen(),
      },
      // **FIX:** Added the missing closing parenthesis for MaterialPageRoute
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('404 - Screen not found')),
        ),
      ),
    );
  }
}
