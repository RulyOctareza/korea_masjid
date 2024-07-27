import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidkorea/cubit/theme_cubit.dart';
import 'package:masjidkorea/pages/home_page.dart';
import 'package:masjidkorea/theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return Scaffold(
          backgroundColor: blackColor,
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/korea2.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/logokmi.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Cari Rumah Allah di\nKorea Selatan',
                        style: blackTextStyle.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Mari luangkan waktu untuk\nberibadah di Negeri Ginseng ',
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 210,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: purpleColor),
                            child: Text(
                              'Explore Now',
                              style: whiteTextStyle.copyWith(
                                fontSize: 18,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
