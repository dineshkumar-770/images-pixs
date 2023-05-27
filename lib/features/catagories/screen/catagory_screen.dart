import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/common/custom_loader.dart';
import 'package:wallpaper_pix/common/toast.dart';
import 'package:wallpaper_pix/features/catagories/controller/catagories_controller.dart';
import 'package:wallpaper_pix/features/catagories/widgets/grid_card.dart';
import 'package:wallpaper_pix/features/catagories/widgets/ontap_catagory_screen.dart';

class WallpaperCategory {
  final String title;
  final String imageUrl;

  WallpaperCategory({required this.title, required this.imageUrl});
}

class CatagoriesScreen extends ConsumerStatefulWidget {
  const CatagoriesScreen({super.key});

  @override
  ConsumerState<CatagoriesScreen> createState() => _CatagoriesScreenState();
}

class _CatagoriesScreenState extends ConsumerState<CatagoriesScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(catagoriesProvider);
    scrollController.addListener(
      () {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = MediaQuery.of(context).size.width * 0.20;
        if (maxScroll - currentScroll <= delta) {
          ref.read(catagoriesProvider.notifier).fetchMoreAvailableCatagories();
        }
      },
    );
    return Scaffold(
      appBar: const CustomAppBar(title: 'Catagories', centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // crossAxisSpacing: 16.0,
                // mainAxisSpacing: 16.0,
                childAspectRatio: 0.9,
              ),
              itemCount: state.collectionsData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onLongPress: () {
                    FlutterToast.showToast(
                        message: state.collectionsData[index].title);
                  },
                  onTap: () {
                    ref
                        .read(imagesBasedOnCatagoriesProvider.notifier)
                        .fetchAvailableCatagories(
                            1, state.collectionsData[index].id);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CatagoriesSearch(
                              totalPhotos:
                                  state.collectionsData[index].photosCount,
                              title: state.collectionsData[index].title,
                              id: state.collectionsData[index].id),
                        ));
                  },
                  child: GridCard(
                    imageUrl:
                        'https://img.freepik.com/free-photo/vivid-blurred-colorful-background_58702-2655.jpg?w=2000',
                    title: state.collectionsData[index].title,
                  ),
                );
              },
            ),
          ),
          state.fecthing
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CustomLoadingWidget()
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
