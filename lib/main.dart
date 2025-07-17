import 'package:flutter/material.dart';
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
    if (kIsWeb) {
      debugPrint("Skipping font loading on web.");
      return;
    }

    try {
      await loadFontFromUrl(
        "https://olacodez1.github.io/fonts-public/ZonaPro-Bold.ttf",
        "ZonaPro",
      );
      setState(() {
        _fontLoaded = true;
      });
    } catch (e) {
      debugPrint("Failed to load font: $e");
    }
  }

  Future<void> loadFontFromUrl(String url, String fontFamily) async {
    final dir = await getApplicationDocumentsDirectory();
    final fontFile = File('${dir.path}/$fontFamily.ttf');
    Uint8List fontBytes;

    if (await fontFile.exists()) {
      debugPrint("Font loaded from cache.");
      fontBytes = await fontFile.readAsBytes();
    } else {
      debugPrint("Downloading font...");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        fontBytes = response.bodyBytes;
        await fontFile.writeAsBytes(fontBytes);
        debugPrint("Font downloaded and cached.");
      } else {
        throw Exception('Failed to download font: ${response.statusCode}');
      }
    }

    final fontLoader = FontLoader(fontFamily);
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
        textTheme: _fontLoaded
            ? Theme.of(context).textTheme.apply(
                  fontFamily: 'ZonaPro',
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                )
            : Theme.of(context).textTheme,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('404 - Screen not found')),
        ),
      ),
    );
  }
}
