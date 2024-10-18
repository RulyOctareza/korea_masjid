import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidkorea/cubit/masjid_cubit.dart';
import 'package:masjidkorea/cubit/theme_cubit.dart';
import 'package:masjidkorea/models/masjid_model.dart';
import 'package:masjidkorea/pages/comunity_masjid_page.dart';
import 'package:masjidkorea/pages/masjid_terdekat.dart';
import 'package:masjidkorea/pages/search_page.dart';
import 'package:masjidkorea/theme.dart';
import 'package:masjidkorea/widgets/space_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<MasjidCubit>().fetchMasjids();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget komunitasMasjid(String communityName, String imageUrl) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommunityMasjidPage(communityName),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[300],
                  image: DecorationImage(
                      image: AssetImage(imageUrl), fit: BoxFit.cover)),
            ),
            Center(
              child: Text(
                communityName,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    Widget masjidPopuler(List<MasjidModel> masjids) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Community of Mosque',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                    ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 150,
              child: ListView(
                padding: const EdgeInsets.only(left: 5),
                children: [
                  SizedBox(
                    height: 175,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            komunitasMasjid('FKMWU', 'assets/FKMWU.jpg'),
                            komunitasMasjid('FKMID', 'assets/FKMID.jpg'),
                            komunitasMasjid('KMJJ', 'assets/KMJJ.jpg'),
                            komunitasMasjid(
                                'MITRA PUMITA', 'assets/MITRAPUMITA.jpg'),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget titleHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: edge),
                  child: Text(
                    'Explore Now',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  icon: const Icon(Icons.brightness_6),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: EdgeInsets.only(left: edge),
            child: Text(
              'Let\'s go to Mosque !',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      );
    }

    Widget rekomendasiMasjid(List<MasjidModel> masjids) {
      List<MasjidModel> displayedMasjids =
          masjids.length > 10 ? masjids.sublist(0, 10) : masjids;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: edge, top: edge),
            child: Text(
              'Rekomendasi Masjid ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: displayedMasjids.map((MasjidModel masjid) {
              return Column(
                children: [
                  SpaceCard(masjid),
                  const SizedBox(height: 10),
                ],
              );
            }).toList(),
          ),
        ],
      );
    }

    // ignore: unused_element
    // Widget tipsGuidance() {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.only(left: edge, top: 20),
    //         child: Text(
    //           'Tips & Guidance',
    //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //                 fontSize: 16,
    //               ),
    //         ),
    //       ),
    //       const SizedBox(height: 16),
    //       Padding(
    //         padding: EdgeInsets.symmetric(horizontal: edge),
    //         child: Column(
    //           children: [
    //             InkWell(
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => const BlogPage()),
    //                 );
    //               },
    //               child: TipsCard(
    //                 Tips(
    //                   id: 1,
    //                   title: 'Tips Berkunjung ke Masjid',
    //                   imageUrl: 'assets/tips1.png',
    //                   updatedAt: '10 Jun',
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             TipsCard(
    //               Tips(
    //                 id: 2,
    //                 title: 'Tips bepergian \ndi Korea Selatan',
    //                 imageUrl: 'assets/tips2.png',
    //                 updatedAt: '11 Jun',
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 100 + edge),
    //     ],
    //   );
    // }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<MasjidCubit, MasjidState>(
          listener: (context, state) {
            if (state is MasjidFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: purpleColor,
                  content: Text(state.error), // Tampilkan pesan kesalahan
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is MasjidSuccess) {
              return ListView(
                children: [
                  titleHeader(),
                  masjidPopuler(state.masjids),
                  MasjidTerdekat(masjids: state.masjids),
                  // rekomendasiMasjid(state.masjids),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
