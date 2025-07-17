import 'package:flutter/material.dart';
import '../sp_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    // Get route arguments before async operation
    final modalArgs = ModalRoute.of(context)?.settings.arguments;
    final initialArgs = modalArgs is Map<String, dynamic>
        ? modalArgs
        : modalArgs is Map
            ? Map<String, dynamic>.from(modalArgs)
            : <String, dynamic>{};

    final saved = await SP.getMap('user');

    if (saved == null || saved.isEmpty) {
      await SP.save('user', initialArgs);
      if (mounted) {
        setState(() => user = initialArgs);
      }
    } else {
      if (mounted) {
        setState(() => user = saved);
      }
    }
  }

  Future<void> _logout() async {
    await SP.del('user');
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: "Logout",
          ),
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (user?['photo'] != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(user!['photo']),
                      radius: 40,
                    ),
                  const SizedBox(height: 20),
                  Text(
                    "Hello, ${user?['name'] ?? 'Unknown'}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(user?['email'] ?? 'Unknown'),
                  const SizedBox(height: 10),
                  Text("UID: ${user?['uid'] ?? 'N/A'}",
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _logout,
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ),
    );
  }
}
