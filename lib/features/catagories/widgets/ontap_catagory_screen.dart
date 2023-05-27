import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/common/custom_loader.dart';
import 'package:wallpaper_pix/common/wallpaper_perview.dart';
import 'package:wallpaper_pix/features/catagories/controller/catagories_controller.dart';
import 'package:wallpaper_pix/features/home/widgets/wallpaper_card.dart';

class CatagoriesSearch extends ConsumerStatefulWidget {
  const CatagoriesSearch(
      {super.key,
      required this.id,
      required this.title,
      required this.totalPhotos});
  final String id;
  final String title;
  final int totalPhotos;

  @override
  ConsumerState<CatagoriesSearch> createState() => _CatagoriesSearchState();
}

class _CatagoriesSearchState extends ConsumerState<CatagoriesSearch> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 3;
    final state = ref.watch(imagesBasedOnCatagoriesProvider);
    scrollController.addListener(
      () {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = MediaQuery.of(context).size.width * 0.20;
        if (maxScroll - currentScroll <= delta) {
          ref
              .read(imagesBasedOnCatagoriesProvider.notifier)
              .fetchMoreAvailableCatagories(widget.id);
        }
      },
    );
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Total results found:- ${widget.totalPhotos}',
                          style: GoogleFonts.lato(
                              color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      physics: state.fecthing
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      controller: scrollController,
                      itemCount: state.collectionsData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                            .collectionsData[index]
                                            .photographer ??
                                        'Photographer name unavailable',
                                    topHeading:
                                        state.collectionsData[index].alt,
                                    landscapeImageUrl: state
                                            .collectionsData[index]
                                            .src
                                            ?.landscape ??
                                        ConstantsString.noImageFound,
                                    largeImageUrl: state.collectionsData[index]
                                            .src?.large ??
                                        ConstantsString.noImageFound,
                                    largeXLImageUrl: state
                                            .collectionsData[index]
                                            .src
                                            ?.large2X ??
                                        ConstantsString.noImageFound,
                                    mediumImageUrl: state.collectionsData[index]
                                            .src?.medium ??
                                        ConstantsString.noImageFound,
                                    originalImageUrl: state
                                            .collectionsData[index]
                                            .src
                                            ?.original ??
                                        ConstantsString.noImageFound,
                                    portraitImageUrl: state
                                            .collectionsData[index]
                                            .src
                                            ?.portrait ??
                                        ConstantsString.noImageFound,
                                    smallImageUrl: state.collectionsData[index]
                                            .src?.small ??
                                        ConstantsString.noImageFound,
                                    tinyImageUrl: state
                                            .collectionsData[index].src?.tiny ??
                                        ConstantsString.noImageFound,
                                  ),
                                ));
                          },
                          child: WallpaperCard(
                            imageUrl:
                                state.collectionsData[index].src?.portrait ??
                                    '',
                            herotag: '${index}S',
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            state.fecthing
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
