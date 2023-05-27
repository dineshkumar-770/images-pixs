import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_pix/features/catagories/screen/catagory_screen.dart';
import 'package:wallpaper_pix/features/home/screen/home_page.dart';
import 'package:wallpaper_pix/features/navigation_bar/controller/navigation_bar_controller.dart';
import 'package:wallpaper_pix/features/search/screen/search_screen.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({super.key});

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(navigationBarProvider);
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          if (state.index == 0) {
            return const HomePage();
          } else if (state.index == 2) {
            return const SearchScreen();
          } else if (state.index == 1) {
            return
                // LocalAuthScreen();
                const CatagoriesScreen();
          } else {
            return Container();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 30 * SizeConfig.widthMultiplier!),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BottomNavigationBar(
              useLegacyColorScheme: true,
              currentIndex: state.index,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(fontSize: 11),
              unselectedLabelStyle: const TextStyle(fontSize: 11),
              onTap: (value) {
                if (value == 0) {
                  ref
                      .read(navigationBarProvider.notifier)
                      .getNavBarItems(NavigationBarItem.home);
                } else if (value == 1) {
                  ref
                      .read(navigationBarProvider.notifier)
                      .getNavBarItems(NavigationBarItem.catagory);
                } else if (value == 2) {
                  ref
                      .read(navigationBarProvider.notifier)
                      .getNavBarItems(NavigationBarItem.search);
                }
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.now_wallpaper),
                    label: 'Home',
                    activeIcon: Icon(Icons.wallpaper)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view_outlined),
                    label: 'Catagory',
                    activeIcon: Icon(Icons.grid_view)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search_outlined),
                    label: 'Search',
                    activeIcon: Icon(Icons.search)),
              ]),
        ),
      ),
    );
  }
}
