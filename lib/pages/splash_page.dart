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
          backgroundColor: whiteColor,
          body: SafeArea(
            bottom: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Layout untuk Desktop/Laptop
                  return Row(
                    children: [
                      // Gambar dalam Card di sisi kiri
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Card(
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
                                'assets/korea2.jpg',
                                fit: BoxFit.cover,
                                height: constraints.maxHeight * 0.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Teks dan Tombol di sisi kanan
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('assets/logokmi.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text(
                                'Cari Rumah Allah di\nKorea Selatan',
                                style: blackTextStyle.copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Mari luangkan waktu untuk\nberibadah di Negeri Ginseng',
                                style: blackTextStyle.copyWith(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 60),
                              SizedBox(
                                width: 250,
                                height: 60,
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
                                    backgroundColor: purpleColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Explore Now',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Layout untuk Mobile/Tablet
                  return Stack(
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
                          right: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/logokmi.png'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'Cari Rumah Allah di\nKorea Selatan',
                              style: blackTextStyle.copyWith(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Mari luangkan waktu untuk\nberibadah di Negeri Ginseng ',
                              style: whiteTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 40),
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
                                  backgroundColor: purpleColor,
                                ),
                                child: Text(
                                  'Explore Now',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
