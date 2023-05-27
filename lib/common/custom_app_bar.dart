import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.icon,
      this.leading,
      this.bgColor,
      this.centerTitle,
      this.fontSize});
  final String title;
  final Widget? icon;
  final Widget? leading;
  final Color? bgColor;
  final bool? centerTitle;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      leading: leading,
      centerTitle: centerTitle,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.lato(color: Colors.white, fontSize: 23),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
