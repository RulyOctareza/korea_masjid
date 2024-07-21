import 'package:flutter/material.dart';
import 'package:masjidkorea/models/masjid_model.dart';
import 'package:masjidkorea/pages/detail_page.dart';

import '../theme.dart';

class SpaceCard extends StatelessWidget {
  final MasjidModel masjid;

  const SpaceCard(this.masjid, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(masjid),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: edge),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                width: 130,
                height: 110,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(masjid.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          color: purpleColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon_star.png',
                              width: 22,
                              height: 22,
                            ),
                            Text(
                              masjid.rating.toString(),
                              style: whiteTextStyle.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              // Menambahkan Expanded untuk membatasi teks agar sesuai dengan lebar yang tersedia
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    masjid.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                        ),
                    overflow:
                        TextOverflow.ellipsis, // Tambahkan overflow ellipsis
                  ),
                  const SizedBox(height: 8),
                  Text(
                    masjid.city,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Tambahkan overflow ellipsis
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
