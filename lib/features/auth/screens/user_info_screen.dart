
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/common/custom_textfield_two.dart';
import 'package:wallpaper_pix/core/helper_fucntion.dart';
import 'package:wallpaper_pix/core/shared_prefs.dart';
import 'package:wallpaper_pix/features/navigation_bar/screen/root_screen.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(
      text: Prefs.getString(ConstantsString.dallEApiKey).isEmpty
          ? ''
          : Prefs.getString(ConstantsString.dallEApiKey));
  TextEditingController keyController = TextEditingController(
      text: Prefs.getString(ConstantsString.apiKeyStore).isEmpty
          ? ''
          : Prefs.getString(ConstantsString.apiKeyStore));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Details',
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'API Key!',
                  style: GoogleFonts.lato(color: Colors.grey, fontSize: 32),
                ),
                Text(
                  'Get your Pexels API key for free',
                  style: GoogleFonts.lato(color: Colors.grey, fontSize: 20),
                ),
                SizedBox(
                  height: 50 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                  label: 'DALL E API Key',
                  controller: nameController,
                  isPasswordField: true,
                  hint: 'Enter your DALL E API Key here',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'API Key is required to continue';
                    } else if (value.contains(' ')) {
                      return 'Please enter a valid key';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),
                CustomTextField(
                  label: 'PEXELS API Key',
                  controller: keyController,
                  hint: 'Enter your Pexel API key here',
                  isPasswordField: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'API key is required to continue';
                    } else if (value.contains('-') || value.contains(' ')) {
                      return 'Please enter a valid key';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 24.0 * SizeConfig.heightMultiplier!,
                ),
                SizedBox(
                  height: 50 * SizeConfig.heightMultiplier!,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await Prefs.setString(ConstantsString.apiKeyStore,
                            keyController.text.trim());
                        await Prefs.setString(ConstantsString.dallEApiKey,
                                nameController.text)
                            .then((value) => Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const RootScreen(),
                                )));
                      }
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0 * SizeConfig.heightMultiplier!,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Don\'t know to get Pexels API Key?  ',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Click here',
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // log('Click here!');
                                HelperFunction.openUrl(
                                    ConstantsString.pexelAPIUrl);
                              }),
                        const TextSpan(
                          text: ' to get your API key for free. ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 15.0 * SizeConfig.heightMultiplier!,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Don\'t know to get OpenAI\'s DALL E API Key?  ',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Click here',
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // log('Click here!');
                                HelperFunction.openUrl(
                                    'https://platform.openai.com/account/api-keys');
                              }),
                        const TextSpan(
                          text:
                              ' to get your API key for free. By just creating a free account. ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
