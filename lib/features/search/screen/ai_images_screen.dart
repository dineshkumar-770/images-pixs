import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/common/custom_loader.dart';
import 'package:wallpaper_pix/common/custom_textfield.dart';
import 'package:wallpaper_pix/common/toast.dart';
import 'package:wallpaper_pix/features/home/widgets/wallpaper_card.dart';
import 'package:wallpaper_pix/features/search/controller/dall_e_controller.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

class AIGeneratedImagesScreen extends StatefulWidget {
  const AIGeneratedImagesScreen({super.key});

  @override
  State<AIGeneratedImagesScreen> createState() =>
      _AIGeneratedImagesScreenState();
}

class _AIGeneratedImagesScreenState extends State<AIGeneratedImagesScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15 * SizeConfig.widthMultiplier!),
            child: Text(
              'AI Images Search',
              style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 28 * SizeConfig.textMultiplier!),
            ),
          ),
          SizedBox(
            height: 10 * SizeConfig.heightMultiplier!,
          ),
          Consumer(builder: (context, ref, _) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15 * SizeConfig.widthMultiplier!),
              child: CustomTextFormField(
                controller: searchController,
                hintText: 'Search for wallpapers',
                labelText: 'Search',
                onChanged: (value) {},
                obscureText: false,
                suffix: InkWell(
                    onTap: () {
                      if (searchController.text.isEmpty) {
                        FlutterToast.showToast(
                            message: 'Empty search cannot performed');
                      } else {
                        ref
                            .read(aiImagesProvider.notifier)
                            .getAIImages(searchController.text);
                      }
                    },
                    child: const Icon(CupertinoIcons.search)),
              ),
            );
          }),
          SizedBox(
            height: 10 * SizeConfig.heightMultiplier!,
          ),
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(aiImagesProvider);
              ref.listen(aiImagesProvider, (previous, next) {
                if (next is AIImagesErrorState) {
                  FlutterToast.showToast(message: next.errorMessage);
                }
              });
              if (state is AIImagesLoadingState) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CustomLoadingWidget()
                  ),
                );
              } else if (state is AIImagesSuccessState) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15 * SizeConfig.widthMultiplier!),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5 * SizeConfig.heightMultiplier!,
                      ),
                      itemCount: state.genetaredImages.length,
                      itemBuilder: (context, index) {
                        return WallpaperCard(
                          imageUrl: state.genetaredImages[index].url ??
                              ConstantsString.noImageFound,
                          herotag: '$index wefwefw',
                        );
                      },
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                  child: Text('Search Here'),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
