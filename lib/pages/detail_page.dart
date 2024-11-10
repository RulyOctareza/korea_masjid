import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidkorea/cubit/theme_cubit.dart';
import 'package:masjidkorea/models/masjid_model.dart';
import 'package:masjidkorea/pages/gallery_pages.dart';
import 'package:masjidkorea/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final MasjidModel masjid;

  const DetailPage(this.masjid, {super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorited = false;

  Future<void> openKakaoMap() async {
    final Uri url = Uri.parse(widget.masjid.address);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return Scaffold(
          backgroundColor:
              themeMode == ThemeMode.dark ? blackColor : whiteColor,
          body: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 800,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.masjid.imageUrl,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                        semanticLabel: 'Name of Masjid',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: edge,
                        vertical: 40,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                    ),
                    ListView(
                      children: [
                        const SizedBox(
                          height: 328,
                        ),
                        BlocBuilder<ThemeCubit, ThemeMode>(
                          builder: (context, themeMode) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                color: themeMode == ThemeMode.dark
                                    ? blackColor
                                    : whiteColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: edge,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.masjid.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontSize: 16,
                                                    ),
                                                // overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                widget.masjid.city,
                                                style: greyTextStyle.copyWith(
                                                  fontSize: 14,
                                                  color: greyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Icon(
                                                    Icons.arrow_back_ios_new)),
                                            // Image.asset(
                                            //   'assets/icon_star.png',
                                            //   width: 28,
                                            //   height: 28,
                                            // ),
                                            // const SizedBox(
                                            //   width: 6,
                                            // ),
                                            // Text(
                                            //   widget.masjid.rating.toString(),
                                            //   style: Theme.of(context)
                                            //       .textTheme
                                            //       .bodyLarge
                                            //       ?.copyWith(
                                            //         fontSize: 18,
                                            //       ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: edge),
                                    child: Text(
                                      'Photos',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  SizedBox(
                                    height: 88,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GalleryPage(
                                                        widget.masjid)));
                                      },
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          const SizedBox(width: 24),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              widget.masjid.photos1,
                                              width: 110,
                                              height: 88,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 18),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              widget.masjid.photos2,
                                              width: 110,
                                              height: 88,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 18),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              widget.masjid.photos3,
                                              width: 110,
                                              height: 88,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 18),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              widget.masjid.photos4,
                                              width: 110,
                                              height: 88,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 18),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              widget.masjid.photos5,
                                              width: 110,
                                              height: 88,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 18),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: edge),
                                    child: Text(
                                      'Location',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: edge),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            widget.masjid.location,
                                            style: greyTextStyle,
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              openKakaoMap();
                                            },
                                            child:
                                                const Icon(Icons.map_rounded)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: edge),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width -
                                        (2 * edge),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        openKakaoMap();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: purpleColor,
                                      ),
                                      child: Text(
                                        'Go to Masjid',
                                        style: whiteTextStyle,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
