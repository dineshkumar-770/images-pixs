import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_pix/features/catagories/widgets/grid_card.dart';
import 'package:wallpaper_pix/features/search/screen/ai_images_screen.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

class DallEFeatureingWidget extends StatelessWidget {
  const DallEFeatureingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15 * SizeConfig.widthMultiplier!),
            child: Text(
              'AI Generated Images',
              style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 28 * SizeConfig.textMultiplier!),
            ),
          ),
        ),
        SizedBox(
          height: 10 * SizeConfig.heightMultiplier!,
        ),
        CarouselSlider(
            items: const [
              GridCard(
                isNetworkImage: false,
                imageUrl: 'assets/images/slider_one.png',
                title: '3D render of a pink balloon dog in a violet room',
              ),
              GridCard(
                isNetworkImage: false,
                imageUrl: 'assets/images/slider_two.png',
                title: 'An abstract painting of artificial intelligence',
              ),
              GridCard(
                isNetworkImage: false,
                imageUrl: 'assets/images/slider_three.png',
                title: 'A 3D render of an astronaut walking in a green desert',
              ),
              GridCard(
                isNetworkImage: false,
                imageUrl: 'assets/images/slider_four.png',
                title: 'A cartoon of a monkey in space',
              ),
              GridCard(
                isNetworkImage: false,
                imageUrl: 'assets/images/slider_five.png',
                title: 'A hand drawn sketch of a Porsche 911',
              ),
              GridCard(
                isNetworkImage: false,
                imageUrl: 'assets/images/slider_six.png',
                title:
                    'A photo of a teddy bear on a skateboard in Times Square',
              ),
            ],
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 16 / 9,
              animateToClosest: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
            )),
        SizedBox(
          height: 25 * SizeConfig.heightMultiplier!,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15 * SizeConfig.widthMultiplier!),
          child: SizedBox(
            height: 50 * SizeConfig.heightMultiplier!,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AIGeneratedImagesScreen(),
                    ));
              },
              child: const Text(
                'Get AI generated Images',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10 * SizeConfig.heightMultiplier!,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15 * SizeConfig.widthMultiplier!),
            child: Text(
              'Powered by OpenAI\'s DALL-E',
              style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 12 * SizeConfig.textMultiplier!),
            ),
          ),
        ),
      ],
    );
  }
}
