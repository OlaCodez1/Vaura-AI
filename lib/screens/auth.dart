import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';
import '../sp_custom.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  late final AppLinks _appLinks;
  late final Uri _authUrl;

  @override
  void initState() {
    super.initState();
    _authUrl = Uri.parse('https://olacodez1.github.io/Vaura-AI/auth');
    _appLinks = AppLinks();

    _initDeepLinkListener();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchWebLogin();
    });
  }

  void _initDeepLinkListener() async {
    // Background links
    _appLinks.uriLinkStream.listen(_handleUri);

    // Cold start links
    final String? initialLink = await _appLinks.getInitialAppLinkString();
    if (initialLink != null) {
      final uri = Uri.tryParse(initialLink);
      if (uri != null) _handleUri(uri);
    }
  }

  void _handleUri(Uri uri) {
    if (uri.scheme == 'vaura' && uri.host == 'login') {
      final uid = uri.queryParameters['uid'];
      final email = uri.queryParameters['email'];
      final name = uri.queryParameters['name'];
      final photo = uri.queryParameters['photo'];

      // Save to SharedPreferences
      SP.save('uid', uid);
      SP.save('email', email);
      SP.save('name', name);
      SP.save('photo', photo);

      // Navigate to home
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(
          '/home',
          arguments: {
            'uid': uid,
            'email': email,
            'name': name,
            'photo': photo,
          },
        );
      }
    }
  }

  Future<void> _launchWebLogin() async {
    setState(() => _isLoading = true);
    try {
      if (await canLaunchUrl(_authUrl)) {
        await launchUrl(_authUrl, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch browser');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open browser: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Remix.login_box_line,
                size: 64,
                color: Color(0xFF6C5CE7),
              ),
              const SizedBox(height: 40),
              Text(
                "Authentication Required",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "You'll be redirected to your browser to login...",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface.withAlpha(180),
                    ),
              ),
              const SizedBox(height: 40),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  onPressed: _launchWebLogin,
                  icon: const Icon(Remix.google_fill),
                  label: const Text("Open Browser Again"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
