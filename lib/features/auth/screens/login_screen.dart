import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/common/toast.dart';
import 'package:wallpaper_pix/features/auth/controller/auth_controller.dart';
import 'package:wallpaper_pix/features/auth/screens/user_info_screen.dart';
import 'package:wallpaper_pix/features/auth/service/auth_repo.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi There!',
                  style: GoogleFonts.lato(color: Colors.grey, fontSize: 32),
                ),
                Text(
                  'Login to your account to continue.',
                  style: GoogleFonts.lato(color: Colors.grey, fontSize: 20),
                ),
                Lottie.asset('assets/lotties/welcome.json'),
                CarouselSlider(
                    items: [
                      Text(
                        'Get a latest wallpaper at every hour.',
                        style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Get attrective and trending wallpapers.',
                        style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Easy to use, easy to download, easy to apply.',
                        style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Get AI generated images at any time.',
                        style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 80,
                      animateToClosest: true,
                      autoPlayCurve: Curves.easeIn,
                      enlargeCenterPage: true,
                    )),
                SizedBox(
                  height: 50 * SizeConfig.heightMultiplier!,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(authStateProvider);
                    ref.listen(authStateProvider, (previous, next) {
                      if (next is GoogleSignInErrorState) {
                        FlutterToast.showToast(message: next.errorMessage);
                      }
                      if (next is GoogleSignInSuccessState) {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const UserInfoScreen(),
                            ));
                      }
                    });
                    if (state is GoogleSignInLoadingState) {
                      return SizedBox(
                        height: 50 * SizeConfig.heightMultiplier!,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: () {
                            AuthRepositary().googleSignIn();
                          },
                          child: Center(
                            child: CupertinoActivityIndicator(
                              color: Theme.of(context).primaryColorLight,
                              radius: 15.0,
                              animating: true,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 50 * SizeConfig.heightMultiplier!,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: () {
                            ref
                                .read(authStateProvider.notifier)
                                .signInWithGoogle();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(FontAwesomeIcons.google),
                              SizedBox(
                                width: 10 * SizeConfig.heightMultiplier!,
                              ),
                              const Text('Sign In with Google')
                            ],
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
