import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget(
      {super.key, this.showImageLoadingInsteadOfLoading});
  final bool? showImageLoadingInsteadOfLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100 * SizeConfig.heightMultiplier!,
          width: 100 * SizeConfig.widthMultiplier!,
          child: Lottie.asset(showImageLoadingInsteadOfLoading ?? false
              ? 'assets/lotties/image_loading.json'
              : 'assets/lotties/c_loading.json'),
        ),
        const Text('Loading...')
      ],
    );
  }
}
