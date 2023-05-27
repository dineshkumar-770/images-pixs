import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/core/shared_prefs.dart';
import 'package:wallpaper_pix/features/auth/screens/login_screen.dart';
import 'package:wallpaper_pix/features/navigation_bar/widget/local_auth_api.dart';
import 'package:wallpaper_pix/features/search/screen/ai_images_screen.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 50 * SizeConfig.heightMultiplier!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50 * SizeConfig.heightMultiplier!,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                Prefs.getString(ConstantsString.userProfileUrl).isEmpty
                    ? ConstantsString.noImageFound
                    : Prefs.getString(ConstantsString.userProfileUrl)),
            backgroundColor: Colors.grey,
          ),
          SizedBox(
            height: 10 * SizeConfig.heightMultiplier!,
          ),
          Text(
            Prefs.getString(ConstantsString.userEmail),
            style: GoogleFonts.lato(
                color: Theme.of(context).primaryColorLight,
                fontSize: 15 * SizeConfig.textMultiplier!),
          ),
          SizedBox(
            height: 10 * SizeConfig.heightMultiplier!,
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              Prefs.getString(ConstantsString.userDisplayName),
              style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 16 * SizeConfig.textMultiplier!),
            ),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            leading: const Icon(Icons.key),
            title: SelectableText(
              isVisible
                  ? Prefs.getString(ConstantsString.apiKeyStore)
                  : '*****************',
              style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 16 * SizeConfig.textMultiplier!),
            ),
            trailing: IconButton(
                onPressed: () async {
                  if (isVisible) {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  } else {
                    final isAutherticated = await LocalAuthApi.authenticate();
                    setState(() {
                      isVisible = isAutherticated;
                    });
                  }
                },
                icon: isVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AIGeneratedImagesScreen(),
                  ));
            },
            // ignore: deprecated_member_use
            leading: const Icon(Icons.smart_toy),
            title: Text(
              'Get AI generated Images',
              style: GoogleFonts.lato(color: Colors.grey, fontSize: 16),
            ),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            onTap: () async {
              await Prefs.remove(ConstantsString.googleSignInToken)
                  .then((value) => Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const LoginScreen(),
                      )));
            },
            // ignore: deprecated_member_use
            leading: const Icon(Icons.logout_outlined),
            title: Text(
              'Change Key or SignOut',
              style: GoogleFonts.lato(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
