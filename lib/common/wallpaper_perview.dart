import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/common/preview_wallpaper.dart';
import 'package:wallpaper_pix/common/toast.dart';
import 'package:wallpaper_pix/features/home/controller/download_images_controller.dart';
import 'package:wallpaper_pix/features/home/controller/home_page_notifier.dart';
import 'package:wallpaper_pix/features/home/widgets/wallpaper_card.dart';
import 'package:wallpaper_pix/features/notification/service/local_notification.dart';
import 'package:wallpaper_pix/responsive/size_config.dart';

class WallpapersPreview extends ConsumerStatefulWidget {
  const WallpapersPreview(
      {super.key,
      this.topHeading,
      required this.originalImageUrl,
      required this.largeXLImageUrl,
      required this.largeImageUrl,
      required this.mediumImageUrl,
      required this.smallImageUrl,
      required this.portraitImageUrl,
      required this.landscapeImageUrl,
      required this.tinyImageUrl,
      required this.photoGrapherName,
      required this.herotag});
  final String? topHeading;
  final String originalImageUrl;
  final String largeXLImageUrl;
  final String largeImageUrl;
  final String mediumImageUrl;
  final String smallImageUrl;
  final String portraitImageUrl;
  final String landscapeImageUrl;
  final String tinyImageUrl;
  final String photoGrapherName;
  final String herotag;

  @override
  ConsumerState<WallpapersPreview> createState() => _WallpapersPreviewState();
}

class _WallpapersPreviewState extends ConsumerState<WallpapersPreview> {
  final Color imageThemeColor = const Color(0XFF999490);

  final List sizes = const [
    'Original',
    '2x Large',
    'Large',
    'Medium',
    'Small',
    'Portrait',
    'Landscape',
    'Tiny',
  ];

  final List resolutons = const [
    'Original',
    '940 x 650',
    '650 x 940',
    '350 x 350',
    '130 x 130',
    '1200 x 800',
    '650 x 1200',
    '200 x 280',
  ];
  double downloadProcess = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(downloadImageProvider);
    // log(state.downloading.toString());
    ref.listen(
      downloadImageProvider,
      (previous, next) {
        next.downloading
            ? FlutterToast.showToast(message: 'Downloading...')
            : LocalNotification.showNotification(
                    heading: 'Image by ${widget.photoGrapherName}',
                    message: 'Downloaded Successfully')
                .then((value) {
                Navigator.pop(context);
              });
        // : FlutterToast.showToast(message: 'Downloaded');
      },
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: SizedBox(
        child: Padding(
          padding: EdgeInsets.only(bottom: 12 * SizeConfig.heightMultiplier!),
          child: Row(
            children: [
              FloatingActionButton(
                tooltip: 'Download',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Download',
                                  style: GoogleFonts.lato(
                                      color: imageThemeColor,
                                      fontSize:
                                          17 * SizeConfig.textMultiplier!),
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const CircleAvatar(
                                      child: Icon(Icons.close),
                                    ))
                              ],
                            ),
                            alignment: Alignment.center,
                            content: Builder(
                              builder: (context) => SizedBox(
                                height: 75 * SizeConfig.heightMultiplier!,
                                child: Center(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2<String>(
                                        selectedItemBuilder: (context) {
                                          return sizes
                                              .map(
                                                  (element) => DropdownMenuItem(
                                                        value: element,
                                                        child: Center(
                                                          child: Text(
                                                            element,
                                                            style: GoogleFonts.lato(
                                                                color:
                                                                    imageThemeColor,
                                                                fontSize: 15 *
                                                                    SizeConfig
                                                                        .textMultiplier!),
                                                          ),
                                                        ),
                                                      ))
                                              .toList();
                                        },
                                        hint: Center(
                                          child: Text(
                                            'Select Resolution',
                                            style: GoogleFonts.lato(
                                                color: imageThemeColor,
                                                fontSize: 15 *
                                                    SizeConfig.textMultiplier!),
                                          ),
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: 15 *
                                                    SizeConfig
                                                        .heightMultiplier!),
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Theme.of(context)
                                                        .dividerColor))),
                                        enableFeedback: true,
                                        isDense: true,
                                        dropdownStyleData: DropdownStyleData(
                                            isFullScreen: true,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            offset: Offset(
                                                0,
                                                -15 *
                                                    SizeConfig
                                                        .heightMultiplier!)),
                                        items: List.generate(
                                            sizes.length,
                                            (index) => DropdownMenuItem(
                                                  value: sizes[index],
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        sizes[index],
                                                        style: GoogleFonts.lato(
                                                            color:
                                                                imageThemeColor,
                                                            fontSize: 15 *
                                                                SizeConfig
                                                                    .textMultiplier!),
                                                      ),
                                                      Text(
                                                        resolutons[index],
                                                        style: GoogleFonts.lato(
                                                            color:
                                                                imageThemeColor,
                                                            fontSize: 10 *
                                                                SizeConfig
                                                                    .textMultiplier!),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                        onChanged: (value) {
                                          ref
                                              .read(
                                                  selectImagetoDownloadProvider
                                                      .notifier)
                                              .update((state) =>
                                                  value ?? 'Original');
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              Center(
                                child: TextButton.icon(
                                    onPressed: () {
                                      String imageType = ref
                                          .read(selectImagetoDownloadProvider);
                                      switch (imageType) {
                                        case '2x Large':
                                          ref
                                              .read(downloadImageProvider
                                                  .notifier)
                                              .downloadImage(
                                                  widget.largeXLImageUrl);
                                          break;
                                        case 'Large':
                                          ref
                                              .read(downloadImageProvider
                                                  .notifier)
                                              .downloadImage(
                                                  widget.largeImageUrl);
                                          break;
                                        case 'Medium':
                                          ref
                                              .read(downloadImageProvider
                                                  .notifier)
                                              .downloadImage(
                                                  widget.mediumImageUrl);
                                          log('iPhone Downloaded');
                                          break;
                                        case 'Small':
                                          ref
                                              .read(downloadImageProvider
                                                  .notifier)
                                              .downloadImage(
                                                  widget.smallImageUrl);
                                          log('Desktop Downloaded');
                                          break;
                                        case 'Portrait':
                                          ref
                                              .read(downloadImageProvider
                                                  .notifier)
                                              .downloadImage(
                                                  widget.portraitImageUrl);
                                          log('Original Downloaded');
                                          break;
                                        case 'Landscape':
                                          ref
                                              .read(downloadImageProvider
                                                  .notifier)
                                              .downloadImage(
                                                  widget.landscapeImageUrl);
                                          log('Original Downloaded');
                                          break;
                                        case 'Tiny':
                                          ref
                                              .read(downloadImageProvider
                                                  .notifier)
                                              .downloadImage(
                                                  widget.tinyImageUrl);
                                          log('Original Downloaded');
                                          break;
                                        case 'Original':
                                          ref
                                              .read(downloadImageProvider
                                                  .notifier)
                                              .downloadImage(
                                                  widget.originalImageUrl);
                                          log('Original Downloaded');
                                          break;
                                      }
                                    },
                                    icon: state.downloading
                                        ? const Icon(Icons.download_done)
                                        : const Icon(Icons.download),
                                    label: const Text('Download')),
                              )
                            ],
                          ));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20 * SizeConfig.widthMultiplier!),
                  child: const Icon(
                    CupertinoIcons.arrow_down_to_line,
                    size: 17,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 12 * SizeConfig.widthMultiplier!),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => PreviewWallpaper(
                            image: widget.portraitImageUrl,
                          ),
                        ));
                  },
                  tooltip: 'Preview',
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20 * SizeConfig.widthMultiplier!),
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: CustomAppBar(
        title: '',
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: Text(
                widget.topHeading ?? '',
                textAlign: TextAlign.start,
                style: GoogleFonts.lato(
                    color: imageThemeColor,
                    fontSize: 13 * SizeConfig.textMultiplier!),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: SizedBox(
                  height: 550 * SizeConfig.heightMultiplier!,
                  width: double.maxFinite,
                  child: WallpaperCard(
                      imageUrl: widget.portraitImageUrl,
                      herotag: widget.herotag),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 25 * SizeConfig.widthMultiplier!),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.hand_thumbsup,
                      color: imageThemeColor,
                    ),
                  ),
                  SizedBox(
                    width: 10 * SizeConfig.widthMultiplier!,
                  ),
                  Icon(
                    CupertinoIcons.camera,
                    color: imageThemeColor,
                  ),
                  SizedBox(
                    width: 10 * SizeConfig.widthMultiplier!,
                  ),
                  Text(
                    widget.photoGrapherName,
                    style: GoogleFonts.lato(
                        color: imageThemeColor,
                        fontSize: 15 * SizeConfig.textMultiplier!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
