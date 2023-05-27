import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/common/custom_loader.dart';
import 'package:wallpaper_pix/common/custom_textfield.dart';
import 'package:wallpaper_pix/common/toast.dart';
import 'package:wallpaper_pix/common/wallpaper_perview.dart';
import 'package:wallpaper_pix/features/home/widgets/wallpaper_card.dart';
import 'package:wallpaper_pix/features/search/controller/search_wallpapers_controller.dart';
import 'package:wallpaper_pix/features/search/widgets/dall_e_widget.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 3;
    final state = ref.watch(searchWallpaperProvider);
    scrollController.addListener(
      () {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = MediaQuery.of(context).size.width * 0.20;
        if (maxScroll - currentScroll <= delta) {
          ref
              .read(searchWallpaperProvider.notifier)
              .fetchMoreWallpaperImages(searchController.text);
        }
      },
    );
    return Scaffold(
      appBar: const CustomAppBar(title: 'Global Search', centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(8.0 * SizeConfig.heightMultiplier!),
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 15 * SizeConfig.widthMultiplier!),
              //   child: Text(
              //     'Global Search',
              //     style: GoogleFonts.lato(
              //         color: Colors.grey,
              //         fontSize: 28 * SizeConfig.textMultiplier!),
              //   ),
              // ),
              SizedBox(
                height: 15 * SizeConfig.heightMultiplier!,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 15 * SizeConfig.widthMultiplier!),
                child: CustomTextFormField(
                  controller: searchController,
                  hintText: 'Search for wallpapers',
                  labelText: 'Search',
                  onSubmit: (value) {
                    if (searchController.text.isNotEmpty) {
                      ref
                          .read(searchWallpaperProvider.notifier)
                          .getWallpaperImages(searchController.text.trim());
                    } else {
                      FlutterToast.showToast(
                          message: 'Empty search can\'t performed!');
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  obscureText: false,
                  suffix: InkWell(
                      onTap: () {
                        if (searchController.text.isNotEmpty) {
                          ref
                              .read(searchWallpaperProvider.notifier)
                              .getWallpaperImages(searchController.text.trim());
                        } else {
                          FlutterToast.showToast(
                              message: 'Empty search can\'t performed!');
                        }
                      },
                      child: const Icon(CupertinoIcons.search)),
                ),
              ),
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier!,
              ),
              state.imagesData.isEmpty
                  ? const DallEFeatureingWidget()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          physics: state.isFetched
                              ? const NeverScrollableScrollPhysics()
                              : const BouncingScrollPhysics(),
                          controller: scrollController,
                          itemCount: state.imagesData.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: (itemWidth / itemHeight),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => WallpapersPreview(
                                        herotag: '${index}S',
                                        photoGrapherName: state
                                                .imagesData[index]
                                                .photographer ??
                                            'Photographer name unavailable',
                                        topHeading: state.imagesData[index].alt,
                                        landscapeImageUrl: state
                                                .imagesData[index]
                                                .src
                                                ?.landscape ??
                                            ConstantsString.noImageFound,
                                        largeImageUrl: state
                                                .imagesData[index].src?.large ??
                                            ConstantsString.noImageFound,
                                        largeXLImageUrl: state.imagesData[index]
                                                .src?.large2X ??
                                            ConstantsString.noImageFound,
                                        mediumImageUrl: state.imagesData[index]
                                                .src?.medium ??
                                            ConstantsString.noImageFound,
                                        originalImageUrl: state
                                                .imagesData[index]
                                                .src
                                                ?.original ??
                                            ConstantsString.noImageFound,
                                        portraitImageUrl: state
                                                .imagesData[index]
                                                .src
                                                ?.portrait ??
                                            ConstantsString.noImageFound,
                                        smallImageUrl: state
                                                .imagesData[index].src?.small ??
                                            ConstantsString.noImageFound,
                                        tinyImageUrl:
                                            state.imagesData[index].src?.tiny ??
                                                ConstantsString.noImageFound,
                                      ),
                                    ));
                              },
                              child: WallpaperCard(
                                imageUrl:
                                    state.imagesData[index].src?.portrait ?? '',
                                herotag: '${index}S',
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ]),
            state.isFetched
                ? Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CustomLoadingWidget()),
                    ))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
