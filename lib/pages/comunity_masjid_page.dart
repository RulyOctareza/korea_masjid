import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidkorea/cubit/masjid_cubit.dart';
import 'package:masjidkorea/cubit/theme_cubit.dart';
import 'package:masjidkorea/theme.dart';
import 'package:masjidkorea/widgets/space_card.dart';

class CommunityMasjidPage extends StatelessWidget {
  final String community;

  const CommunityMasjidPage(this.community, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, themeMode) {
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark ? kDefaultIconDarkColor : whiteColor,
        appBar: AppBar(
          title: Text(
            'Mosque in Area $community',
            style:
                themeMode == ThemeMode.dark ? whiteTextStyle : blackTextStyle,
          ),
          backgroundColor:
              themeMode == ThemeMode.dark ? kDefaultIconDarkColor : whiteColor,
        ),
        body: BlocBuilder<MasjidCubit, MasjidState>(
          builder: (context, state) {
            if (state is MasjidSuccess) {
              // Filter masjid berdasarkan komunitas

              final masjids = state.masjids
                  .where((masjid) => masjid.comunity == community)
                  .toList();

              if (masjids.isEmpty) {
                return const Center(
                  child: Text('No Mosque in the Community'),
                );
              }

              return ListView.builder(
                itemCount: masjids.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SpaceCard(masjids[index]),
                    ],
                  );
                },
              );
            } else if (state is MasjidLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MasjidFailed) {
              return Center(
                child: Text('Failed to load Mosque: ${state.error}'),
              );
            } else {
              return const Center(
                child: Text('No Mosque'),
              );
            }
          },
        ),
      );
    });
  }
}
