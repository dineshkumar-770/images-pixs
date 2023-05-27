import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/common/custom_loader.dart';
import 'package:wallpaper_pix/common/wallpaper_perview.dart';
import 'package:wallpaper_pix/features/home/controller/home_page_notifier.dart';
import 'package:wallpaper_pix/features/home/widgets/drawer_widget.dart';
import 'package:wallpaper_pix/features/home/widgets/wallpaper_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 3;
    final state = ref.watch(wallpaperSearchProvider);
    scrollController.addListener(
      () {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = MediaQuery.of(context).size.width * 0.20;
        if (maxScroll - currentScroll <= delta) {
          ref.read(wallpaperSearchProvider.notifier).fetchMoreWallpaperImages();
        }
      },
    );
    return Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: 'IMAGES PIXS',
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              )),
        ),
        drawer: const Drawer(child: DrawerWidget()),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    physics: state.isFetched
                        ? const NeverScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemCount: state.imagesData.length,
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
                                  herotag: '${index}home',
                                  photoGrapherName:
                                      state.imagesData[index].photographer,
                                  topHeading: state.imagesData[index].alt,
                                  landscapeImageUrl:
                                      state.imagesData[index].src.landscape,
                                  largeImageUrl:
                                      state.imagesData[index].src.large,
                                  largeXLImageUrl:
                                      state.imagesData[index].src.large2X,
                                  mediumImageUrl:
                                      state.imagesData[index].src.medium,
                                  originalImageUrl:
                                      state.imagesData[index].src.original,
                                  portraitImageUrl:
                                      state.imagesData[index].src.portrait,
                                  smallImageUrl:
                                      state.imagesData[index].src.small,
                                  tinyImageUrl:
                                      state.imagesData[index].src.tiny,
                                ),
                              ));
                        },
                        child: WallpaperCard(
                          imageUrl: state.imagesData[index].src.portrait,
                          herotag: '${index}fromHome',
                        ),
                      );
                    },
                  ),
                )),
              ],
            ),
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
        ));
  }
}
