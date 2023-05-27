import 'dart:developer';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/core/shared_prefs.dart';
import 'package:wallpaper_pix/features/auth/screens/login_screen.dart';
import 'package:wallpaper_pix/features/auth/screens/user_info_screen.dart';
import 'package:wallpaper_pix/features/navigation_bar/screen/root_screen.dart';
import 'package:wallpaper_pix/firebase_options.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  FlutterLocalNotificationsPlugin().initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher')));
  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
  "provider": "${provider.name ?? provider.runtimeType}",
  "state": "$newValue"
  ''');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, dark) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && dark != null) {
          lightColorScheme = lightDynamic.harmonized()..copyWith();
          lightColorScheme = lightColorScheme.copyWith(secondary: Colors.blue);
          darkColorScheme = dark.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          );
        }

        return ScreenUtilInit(
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return OrientationBuilder(
                  builder: (context, orientation) {
                    SizeConfig().init(constraints, orientation);
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'IMAGES PIXS',
                      darkTheme: ThemeData(
                          useMaterial3: true, colorScheme: darkColorScheme),
                      theme: ThemeData(
                          useMaterial3: true, colorScheme: lightColorScheme),
                      home: Prefs.getString(ConstantsString.googleSignInToken)
                              .isNotEmpty
                          ? (Prefs.getString(ConstantsString.apiKeyStore)
                                      .isNotEmpty &&
                                  Prefs.getString(ConstantsString.dallEApiKey)
                                      .isNotEmpty)
                              ?
                              // const NotificationWidget()
                              const RootScreen()
                              : const UserInfoScreen()
                          : const LoginScreen(),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
