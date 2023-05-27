import 'package:flutter/material.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/features/navigation_bar/widget/local_auth_api.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  bool isAuthenticated = false;

  authnti() async {}

  @override
  void initState() {
    super.initState();
    authnti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Authenticate',
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isAuthenticated
                ? const Text(
                    'Authenticated',
                    style: TextStyle(color: Colors.green),
                  )
                : const Text(
                    'Unauthenticated',
                    style: TextStyle(color: Colors.red),
                  ),
            ElevatedButton(
                onPressed: () async {
                  final authFingerprint = await LocalAuthApi.authenticate();
                  setState(() {
                    isAuthenticated = authFingerprint;
                  });
                },
                child: const Text('AUTH'))
          ],
        ),
      ),
    );
  }
}
