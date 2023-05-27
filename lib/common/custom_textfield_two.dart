import 'package:flutter/material.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.hint,
      this.validator,
      required this.controller,
      this.isPasswordField});
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool? isPasswordField;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return widget.isPasswordField ?? false
        ? Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'InterTight',
                      fontSize: 12 * SizeConfig.textMultiplier!,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 4 * SizeConfig.heightMultiplier!, 0, 0),
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: 'InterTight',
                          color: const Color(0xFFBAC2C7),
                          fontSize: 14 * SizeConfig.textMultiplier!,
                        ),
                    suffixIcon: widget.isPasswordField ?? false
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              showPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF757575),
                              size: 22,
                            ),
                          )
                        : Visibility(
                            visible: widget.isPasswordField ?? false,
                            child: const Icon(Icons.abc)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontFamily: 'InterTight',
                        fontSize: 17 * SizeConfig.textMultiplier!,
                      ),
                  validator: widget.validator,
                ),
              ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'InterTight',
                      fontSize: 12 * SizeConfig.textMultiplier!,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 4 * SizeConfig.heightMultiplier!, 0, 0),
                child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: 'InterTight',
                          color: const Color(0xFFBAC2C7),
                          fontSize: 14 * SizeConfig.textMultiplier!,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontFamily: 'InterTight',
                        fontSize: 17 * SizeConfig.textMultiplier!,
                      ),
                  validator: widget.validator,
                ),
              ),
            ],
          );
  }
}
